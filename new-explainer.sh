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

<!-- この記事で分かること -->

:::message
**対象読者**:
**前提知識**:
:::

## 背景

<!-- なぜ知る必要があるか。よくある疑問や誤解 -->

## 結論

<!-- 一言で言うと何か。先に答えを出す -->

<!-- 学びの共有の場合は、ここに「つまずいた点と気づき」を入れる -->

## 仕組み

<!-- 概念 → 図 → 内部の動き の順に説明する -->

## 具体例

<!-- サンプルコード。動作確認していない場合はその旨を明記 -->

```ts:src/index.ts

```

:::message alert
<!-- よくあるハマりどころ -->
:::

## 比較・使い分け

<!-- 類似技術との違いと選び方 -->

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
