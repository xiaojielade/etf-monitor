#!/bin/bash
# 一键更新线上页面：从 kline-matcher 取最新的手机版报告，推送到 GitHub Pages
set -e
cd "$(dirname "$0")"

SRC=../kline-matcher/output/etf_share/site/index.html

if [ ! -f "$SRC" ]; then
    echo "找不到源文件：$SRC"
    echo "请先在 kline-matcher 里运行：.venv/bin/python3 national_team_etf.py"
    exit 1
fi

cp "$SRC" index.html

if git diff --quiet HEAD -- index.html; then
    echo "页面内容没有变化，无需提交"
    exit 0
fi

git add index.html
git -c user.email="xiaojielade@sina.cn" -c user.name="gerrard" \
    commit -m "更新数据 $(date +%Y-%m-%d)" -q
git push origin main -q

echo "已推送，约 30 秒后生效："
echo "https://xiaojielade.github.io/etf-monitor/"
