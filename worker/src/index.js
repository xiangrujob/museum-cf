/**
 * Knowledge Museum API — Cloudflare Worker + D1
 * Auth: write operations require X-Museum-Token header matching the WRITE_TOKEN secret.
 * Read (GET) is public.
 */

const ALLOWED_ORIGIN = '*';

function cors(extra = {}) {
  return {
    'Access-Control-Allow-Origin': ALLOWED_ORIGIN,
    'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type,X-Museum-Token',
    'Content-Type': 'application/json',
    ...extra,
  };
}

function json(data, status = 200) {
  return new Response(JSON.stringify(data), { status, headers: cors() });
}
function err(msg, status = 400) { return json({ error: msg }, status); }
function uid() { return Date.now().toString(36) + Math.random().toString(36).slice(2, 8); }

// ─── AUTH ────────────────────────────────────────────────
// Only POST / PUT / DELETE require the token.
// GET is always public (read-only for guests).
function isWriteMethod(method) {
  return ['POST', 'PUT', 'DELETE'].includes(method);
}
function authorized(request, env) {
  const token = request.headers.get('X-Museum-Token') || '';
  return token === (env.WRITE_TOKEN || '');
}

// ─── ROUTER ──────────────────────────────────────────────
export default {
  async fetch(request, env) {
    const url    = new URL(request.url);
    const path   = url.pathname;
    const method = request.method;

    if (method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: cors() });
    }

    // Auth gate for all write operations
    if (isWriteMethod(method) && !authorized(request, env)) {
      return err('Unauthorized — wrong or missing token', 401);
    }

    // ── GET /api/wings ──────────────────────────────────
    if (method === 'GET' && path === '/api/wings') {
      const wings  = await env.DB.prepare(
        `SELECT id, name, era, img, description, sort_order FROM wings ORDER BY sort_order ASC, created_at ASC`
      ).all();
      const pieces = await env.DB.prepare(
        `SELECT id, wing_id, name, url, status, sort_order FROM pieces ORDER BY sort_order ASC, created_at ASC`
      ).all();
      const pieceMap = {};
      for (const p of pieces.results) {
        if (!pieceMap[p.wing_id]) pieceMap[p.wing_id] = [];
        pieceMap[p.wing_id].push(p);
      }
      // Mark pieces that have a non-empty note
      const notedPieces = await env.DB.prepare(
        `SELECT piece_id FROM notes WHERE content != ''`
      ).all();
      const notedSet = new Set(notedPieces.results.map(r => r.piece_id));

      const result = wings.results.map(w => ({
        ...w,
        pieces: (pieceMap[w.id] || []).map(p => ({ ...p, _hasNote: notedSet.has(p.id) })),
      }));
      return json(result);
    }

    // ── POST /api/wings ─────────────────────────────────
    if (method === 'POST' && path === '/api/wings') {
      const body = await request.json();
      if (!body.name) return err('name is required');
      const maxOrder = await env.DB.prepare(`SELECT MAX(sort_order) as m FROM wings`).first();
      const order = (maxOrder?.m ?? 0) + 1;
      const id = body.id || uid();
      await env.DB.prepare(
        `INSERT INTO wings (id, name, era, img, description, sort_order) VALUES (?,?,?,?,?,?)`
      ).bind(id, body.name, body.era||'', body.img||'', body.description||'', order).run();
      return json({ id, sort_order: order }, 201);
    }

    // ── PUT /api/wings/reorder ───────────────────────────
    if (method === 'PUT' && path === '/api/wings/reorder') {
      const body = await request.json();
      if (!Array.isArray(body)) return err('Expected array');
          if (body.length > 0) {
             const stmt = env.DB.prepare(`UPDATE wings SET sort_order=? WHERE id=?`);
             await env.DB.batch(body.map(({ id, sort_order }) => stmt.bind(sort_order, id)));
          }
          return json({ ok: true });
      }

    // ── PUT /api/wings/:id ───────────────────────────────
    const wingMatch = path.match(/^\/api\/wings\/([^/]+)$/);
    if (method === 'PUT' && wingMatch) {
      const id = wingMatch[1];
      const body = await request.json();
      await env.DB.prepare(
        `UPDATE wings SET name=?, era=?, img=?, description=? WHERE id=?`
      ).bind(body.name, body.era||'', body.img||'', body.description||'', id).run();
      return json({ ok: true });
    }

    // ── DELETE /api/wings/:id ────────────────────────────
    if (method === 'DELETE' && wingMatch) {
      const id = wingMatch[1];
      await env.DB.prepare(`DELETE FROM notes WHERE piece_id IN (SELECT id FROM pieces WHERE wing_id=?)`).bind(id).run();
      await env.DB.prepare(`DELETE FROM pieces WHERE wing_id=?`).bind(id).run();
      await env.DB.prepare(`DELETE FROM wings WHERE id=?`).bind(id).run();
      return json({ ok: true });
    }

    // ── POST /api/wings/:wingId/pieces ───────────────────
    const pieceCreateMatch = path.match(/^\/api\/wings\/([^/]+)\/pieces$/);
    if (method === 'POST' && pieceCreateMatch) {
      const wingId = pieceCreateMatch[1];
      const body = await request.json();
      if (!body.name) return err('name is required');
      const maxOrder = await env.DB.prepare(
        `SELECT MAX(sort_order) as m FROM pieces WHERE wing_id=?`
      ).bind(wingId).first();
      const order = (maxOrder?.m ?? 0) + 1;
      const id = uid();
      await env.DB.prepare(
        `INSERT INTO pieces (id, wing_id, name, url, status, sort_order) VALUES (?,?,?,?,?,?)`
      ).bind(id, wingId, body.name, body.url||'', body.status||'todo', order).run();
      return json({ id, sort_order: order }, 201);
    }

    // ── PUT /api/pieces/:id ──────────────────────────────
    const pieceMatch = path.match(/^\/api\/pieces\/([^/]+)$/);
    if (method === 'PUT' && pieceMatch) {
      const id = pieceMatch[1];
      const body = await request.json();
      await env.DB.prepare(
        `UPDATE pieces SET name=?, url=?, status=? WHERE id=?`
      ).bind(body.name, body.url||'', body.status||'todo', id).run();
      return json({ ok: true });
    }

    // ── DELETE /api/pieces/:id ───────────────────────────
    if (method === 'DELETE' && pieceMatch) {
      const id = pieceMatch[1];
      await env.DB.prepare(`DELETE FROM notes WHERE piece_id=?`).bind(id).run();
      await env.DB.prepare(`DELETE FROM pieces WHERE id=?`).bind(id).run();
      return json({ ok: true });
    }

    // ── GET /api/pieces/:id/note ─────────────────────────
    const noteMatch = path.match(/^\/api\/pieces\/([^/]+)\/note$/);
    if (method === 'GET' && noteMatch) {
      const id = noteMatch[1];
      const row = await env.DB.prepare(
        `SELECT content, format FROM notes WHERE piece_id=?`
      ).bind(id).first();
      return json(row || { content: '', format: 'text' });
    }

    // ── PUT /api/pieces/:id/note ─────────────────────────
    if (method === 'PUT' && noteMatch) {
      const id = noteMatch[1];
      const body = await request.json();
      await env.DB.prepare(
        `INSERT INTO notes (piece_id, content, format) VALUES (?,?,?)
         ON CONFLICT(piece_id) DO UPDATE SET content=excluded.content, format=excluded.format, updated_at=datetime('now')`
      ).bind(id, body.content||'', body.format||'text').run();
      return json({ ok: true });
    }

    return json({ error: 'Not found' }, 404);
  },
};
