#!/usr/bin/env bash
# Fails unless host-hero.yml has no anonymous image host, no contents write,
# no git publish of main, and every action pin is a 40-character commit SHA.
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
file="${1:-$root/.github/workflows/host-hero.yml}"

if [[ ! -f "$file" ]]; then
  echo "missing workflow: $file" >&2
  exit 1
fi

fail=0

host=$(printf '%s.%s' 'uguu' 'se')
perm_re=$(printf '%s:[[:space:]]*%s' 'contents' 'write')
push=$(printf '%s %s' 'git' 'push')
push_re=${push// /[[:space:]]+}

count_uguu_se=$(grep -F -i -c "$host" "$file" || true)
count_contents_write=$(grep -E -i -c "$perm_re" "$file" || true)
count_git_push_main=$(grep -E -c "$push_re" "$file" || true)

uses_lines=$(grep -E '^[[:space:]]*-?[[:space:]]*uses:' "$file" || true)
if [[ -z "$uses_lines" ]]; then
  count_uses=0
  count_uses_pinned_sha40=0
  count_uses_version_comment=0
else
  count_uses=$(printf '%s\n' "$uses_lines" | wc -l | tr -d ' ')
  count_uses_pinned_sha40=$(
    printf '%s\n' "$uses_lines" |
      grep -E -c 'uses:[[:space:]]*[^[:space:]#]+@[0-9a-f]{40}([[:space:]]+#.*)?$' ||
      true
  )
  count_uses_version_comment=$(
    printf '%s\n' "$uses_lines" |
      grep -E -c 'uses:[[:space:]]*[^[:space:]#]+@[0-9a-f]{40}[[:space:]]+# v[0-9]' ||
      true
  )
fi

echo "count_uguu_se=${count_uguu_se}"
echo "count_contents_write=${count_contents_write}"
echo "count_git_push_main=${count_git_push_main}"
echo "count_uses=${count_uses}"
echo "count_uses_pinned_sha40=${count_uses_pinned_sha40}"
echo "count_uses_version_comment=${count_uses_version_comment}"

if [[ "$count_uguu_se" -ne 0 ]]; then
  fail=1
fi
if [[ "$count_contents_write" -ne 0 ]]; then
  fail=1
fi
if [[ "$count_git_push_main" -ne 0 ]]; then
  fail=1
fi
if [[ "$count_uses" -lt 1 ]]; then
  fail=1
fi
if [[ "$count_uses" -ne "$count_uses_pinned_sha40" ]]; then
  fail=1
fi
if [[ "$count_uses" -ne "$count_uses_version_comment" ]]; then
  fail=1
fi

repo_uguu=$(git -C "$root" grep -F -i -e "$host" -- . || true)
if [[ -n "$repo_uguu" ]]; then
  echo "repo_uguu_se_hits<<EOF"
  printf '%s\n' "$repo_uguu"
  echo "EOF"
  fail=1
else
  echo "count_uguu_se_repo=0"
fi

exit "$fail"
