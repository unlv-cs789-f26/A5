#!/usr/bin/env bash
# Instructor: publish this folder as the public repo unlv-cs789-f26/A5 (run once, on your Mac).
# instructor/ (solution notebook, answer key) and *.docx/*.pdf are excluded by .gitignore.
set -e
cd "$(dirname "$0")"
rm -f .git/*.lock .git/objects/*.lock 2>/dev/null || true
[ -d .git ] || git init -b main
git add -A
git commit -m "CS 789 A5: GraphRAG vs LightRAG vs vector RAG, and Neo4j" || true
gh repo create unlv-cs789-f26/A5 --public --source=. --remote=origin --push || git push -u origin main
echo "Students open: https://colab.research.google.com/github/unlv-cs789-f26/A5/blob/main/A5_GraphRAG.ipynb"
