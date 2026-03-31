#!/bin/bash
# 記事を追加したら `bash generate-sitemap.sh` を実行してください

BASE_URL="https://fukugyodeck.com"
TODAY=$(date +%Y-%m-%d)
OUT="sitemap.xml"

cat > "$OUT" << HEADER
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>${BASE_URL}/</loc>
    <lastmod>${TODAY}</lastmod>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>${BASE_URL}/simulator.html</loc>
    <lastmod>${TODAY}</lastmod>
    <priority>0.9</priority>
  </url>
HEADER

# articles/内のHTMLを自動検出・追加
for f in $(ls articles/*.html 2>/dev/null | sort); do
  name=$(basename "$f")
  cat >> "$OUT" << ENTRY
  <url>
    <loc>${BASE_URL}/articles/${name}</loc>
    <lastmod>${TODAY}</lastmod>
    <priority>0.8</priority>
  </url>
ENTRY
done

cat >> "$OUT" << FOOTER
  <url>
    <loc>${BASE_URL}/about.html</loc>
    <lastmod>${TODAY}</lastmod>
    <priority>0.5</priority>
  </url>
  <url>
    <loc>${BASE_URL}/privacy.html</loc>
    <lastmod>${TODAY}</lastmod>
    <priority>0.4</priority>
  </url>
  <url>
    <loc>${BASE_URL}/contact.html</loc>
    <lastmod>${TODAY}</lastmod>
    <priority>0.4</priority>
  </url>
</urlset>
FOOTER

COUNT=$(grep -c "<loc>" "$OUT")
echo "sitemap.xml updated: ${COUNT} pages (${TODAY})"
