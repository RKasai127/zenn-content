#!/usr/bin/env bash
# やってみた・作ってみた系の記事テンプレートを作成する
# 使い方: ./new-handson.sh [タイトル] [slug]
#   slug を省略すると zenn-cli がランダムに付与する
set -euo pipefail

title="${1:-}"
slug="${2:-}"

# zenn-cli は実行ディレクトリ配下の articles/ に作成するため、リポジトリ直下へ移動する
cd "$(dirname "$0")"

args=(--machine-readable --emoji "🛠" --type tech)
[ -n "$title" ] && args+=(--title "$title")
[ -n "$slug" ] && args+=(--slug "$slug")

# --machine-readable で "articles/<slug>.md" だけが出力される
file="$(npx zenn new:article "${args[@]}")"

if [ ! -f "$file" ]; then
  echo "エラー: 記事の作成に失敗しました: $file" >&2
  exit 1
fi

cat >> "$file" <<'EOF'

## 概要

<!-- 何を作った・試したかと、その結果を2〜3文で -->

## 背景

<!-- なぜ取り組んだのか。きっかけや前提となる状況 -->

## 解決しようとする課題

<!-- 既存の方法では何が困るのか。具体的に -->

## 解決手段

<!-- 採用した技術・手法の構成。図があると分かりやすい -->

## 効果

<!-- 課題は解決できたか。数値や before/after で示す -->

## 実施形態

<!-- 実際のサンプルコード。動作確認していない場合はその旨を明記 -->

```ts:src/index.ts

```
EOF

echo "作成しました: $file"
