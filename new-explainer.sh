#!/usr/bin/env bash
# 解説・学びの共有系の記事テンプレートを作成する
# 使い方: ./new-explainer.sh [タイトル] [slug]
#   slug を省略すると zenn-cli がランダムに付与する
set -euo pipefail

title="${1:-}"
slug="${2:-}"

# zenn-cli は実行ディレクトリ配下の articles/ に作成するため、リポジトリ直下へ移動する
cd "$(dirname "$0")"

args=(--machine-readable --emoji "📘" --type tech)
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

<!-- 背景 -->


## この記事で分かること


## 説明

:::message alert
<!-- よくあるハマりどころ -->
:::

:::details "aaaaa"
<!-- よくあるハマりどころ -->
:::

| 観点 | A | B |
| --- | --- | --- |
|  |  |  |


## まとめ

-
-
-

## 参考文献

EOF

echo "作成しました: $file"
