<!-- BEGIN:nextjs-agent-rules -->
# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` before writing any code. Heed deprecation notices.
<!-- END:nextjs-agent-rules -->

<!-- BEGIN:graphify-rules -->
## Graphify Knowledge Graph

Repository ini dilengkapi dengan Knowledge Graph yang telah diekstraksi di `graphify-out/`.

- Jangan menganalisis atau membaca file codebase satu per satu saat mencari arsitektur atau relasi file/komponen.
- Gunakan `graphify query "<pertanyaan>"` (CLI) atau tool MCP `query_graph`, `get_node`, `shortest_path` untuk menavigasi struktur kode secara cepat dan terarah.
- Baca `graphify-out/GRAPH_REPORT.md` untuk tinjauan arsitektur umum, God Nodes, dan relasi antar modul.
- Buka `graphify-out/graph.html` untuk visualisasi interaktif di browser.
- Setelah melakukan perubahan signifikan pada file kode, jalankan `graphify update .` atau manfaatkan git hook otomatis agar graph tetap mutakhir.
<!-- END:graphify-rules -->
