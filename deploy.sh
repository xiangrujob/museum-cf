#!/bin/bash
# deploy.sh — 知识博物馆一键部署脚本
# 用法：./deploy.sh           → 同时部署 worker + frontend
#       ./deploy.sh worker    → 只部署 worker
#       ./deploy.sh frontend  → 只部署 frontend

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-all}"

deploy_worker() {
  echo "🔧 Deploying Worker..."
  cd "$SCRIPT_DIR/worker"
  wrangler deploy
  echo "✅ Worker deployed"
}

deploy_frontend() {
  echo "🌐 Deploying Frontend..."
  cd "$SCRIPT_DIR/frontend"
  wrangler pages deploy . --project-name=knowledge-museum
  echo "✅ Frontend deployed → https://knowledge-museum.pages.dev"
}

case "$TARGET" in
  worker)   deploy_worker ;;
  frontend) deploy_frontend ;;
  all)      deploy_worker && deploy_frontend ;;
  *)        echo "Usage: ./deploy.sh [worker|frontend|all]"; exit 1 ;;
esac
