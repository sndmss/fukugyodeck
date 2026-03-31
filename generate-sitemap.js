const fs = require('fs');
const path = require('path');

const BASE_URL = 'https://fukugyodeck.com';
const TODAY = new Date().toISOString().split('T')[0];

const pages = [
  { path: '/',               priority: '1.0' },
  { path: '/simulator.html', priority: '0.9' },
];

// articles/フォルダ内のHTMLを自動検出
const articlesDir = path.join(__dirname, 'articles');
const articleFiles = fs.readdirSync(articlesDir)
  .filter(f => f.endsWith('.html'))
  .sort();

articleFiles.forEach(f => {
  pages.push({ path: `/articles/${f}`, priority: '0.8' });
});

pages.push(
  { path: '/about.html',   priority: '0.5' },
  { path: '/privacy.html', priority: '0.4' },
  { path: '/contact.html', priority: '0.4' },
);

const urls = pages.map(p => `  <url>
    <loc>${BASE_URL}${p.path}</loc>
    <lastmod>${TODAY}</lastmod>
    <priority>${p.priority}</priority>
  </url>`).join('\n');

const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls}
</urlset>
`;

fs.writeFileSync(path.join(__dirname, 'sitemap.xml'), xml);
console.log(`sitemap.xml updated: ${pages.length} pages (${TODAY})`);
