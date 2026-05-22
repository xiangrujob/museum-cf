-- schema.sql  (run once: wrangler d1 execute knowledge-museum --file=schema.sql)

CREATE TABLE IF NOT EXISTS wings (
  id        TEXT PRIMARY KEY,
  name      TEXT NOT NULL,
  era       TEXT,
  img       TEXT,
  description TEXT,
  sort_order INTEGER DEFAULT 0,
  created_at TEXT DEFAULT (datetime('now')),
  updated_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS pieces (
  id        TEXT PRIMARY KEY,
  wing_id   TEXT NOT NULL REFERENCES wings(id) ON DELETE CASCADE,
  name      TEXT NOT NULL,
  url       TEXT,
  status    TEXT DEFAULT 'todo',   -- 'todo' | 'learning' | 'done'
  sort_order INTEGER DEFAULT 0,
  created_at TEXT DEFAULT (datetime('now')),
  updated_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS notes (
  piece_id  TEXT PRIMARY KEY REFERENCES pieces(id) ON DELETE CASCADE,
  content   TEXT DEFAULT '',
  format    TEXT DEFAULT 'text',   -- 'text' | 'markdown'
  updated_at TEXT DEFAULT (datetime('now'))
);

-- Trigger: auto-update updated_at on wings
CREATE TRIGGER IF NOT EXISTS wings_updated
  AFTER UPDATE ON wings
  BEGIN
    UPDATE wings SET updated_at = datetime('now') WHERE id = NEW.id;
  END;

-- Trigger: auto-update updated_at on pieces
CREATE TRIGGER IF NOT EXISTS pieces_updated
  AFTER UPDATE ON pieces
  BEGIN
    UPDATE pieces SET updated_at = datetime('now') WHERE id = NEW.id;
  END;
