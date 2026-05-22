# Knowledge Museum — Cloudflare Workers + D1 部署指南

## 目录结构

```
museum-cf/
├── worker/              ← Cloudflare Worker (后端 API)
│   ├── src/index.js     ← API 逻辑
│   ├── schema.sql       ← 建表 SQL
│   ├── seed.sql         ← 初始数据 SQL
│   ├── wrangler.toml    ← Worker 配置
│   └── package.json
└── frontend/
    └── index.html       ← 前端（改一行 URL 即可）
```

---

## Step 1 — 安装 Wrangler CLI

```bash
npm install -g wrangler
wrangler login          # 浏览器里授权 Cloudflare 账号
```

---

## Step 2 — 创建 D1 数据库

```bash
cd museum-cf/worker
wrangler d1 create knowledge-museum
```

输出类似：
```
✅ Successfully created DB 'knowledge-museum'
database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

**把这个 `database_id` 填进 `wrangler.toml`**（替换 `REPLACE_WITH_YOUR_D1_ID`）。

---

## Step 3 — 建表 & 导入初始数据

```bash
# 建表
wrangler d1 execute knowledge-museum --file=schema.sql

# 导入初始 wings / pieces（如果你已有旧数据可跳过）
wrangler d1 execute knowledge-museum --file=seed.sql
```

---

## Step 4 — 部署 Worker

```bash
npm install      # 安装 wrangler 依赖
npm run deploy   # = wrangler deploy
```

输出会给你一个 URL，类似：
```
https://knowledge-museum-api.YOUR_SUBDOMAIN.workers.dev
```

记住这个 URL。

---

## Step 5 — 配置前端

打开 `frontend/index.html`，找到顶部这一行：

```javascript
const API = 'https://knowledge-museum-api.YOUR_SUBDOMAIN.workers.dev';
```

把 `YOUR_SUBDOMAIN` 换成你实际的 Workers 子域名。

---

## Step 6 — 部署前端（Cloudflare Pages）

```bash
# 在 museum-cf/ 目录
wrangler pages deploy frontend --project-name=knowledge-museum
```

第一次会提示创建 Pages 项目，按提示操作即可。

部署完成后会给你一个永久 URL，例如：
```
https://knowledge-museum.pages.dev
```

之后每次更新前端只需重新运行这条命令。

---

## 日常使用

| 操作 | 命令 |
|------|------|
| 本地预览 Worker | `cd worker && npm run dev` |
| 重新部署 Worker | `cd worker && npm run deploy` |
| 重新部署前端 | `wrangler pages deploy frontend --project-name=knowledge-museum` |
| 查询数据库 | `wrangler d1 execute knowledge-museum --command="SELECT * FROM wings"` |
| 备份数据 | `wrangler d1 export knowledge-museum --output=backup.sql` |

---

## 可选：锁定 CORS

部署稳定后，把 `worker/src/index.js` 顶部的：

```javascript
const ALLOWED_ORIGIN = '*';
```

改为你的 Pages URL：

```javascript
const ALLOWED_ORIGIN = 'https://knowledge-museum.pages.dev';
```

然后重新 `npm run deploy`。

---

## 免费额度说明（2025）

| 资源 | 免费额度 |
|------|---------|
| Workers 请求 | 100,000 次/天 |
| D1 读操作 | 5,000,000 次/天 |
| D1 写操作 | 100,000 次/天 |
| D1 存储 | 5 GB |
| Pages 部署 | 500 次/月 |

个人使用完全够用，不需要绑定信用卡。
