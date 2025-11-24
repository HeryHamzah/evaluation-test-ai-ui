---
trigger: always_on
---

# Chat Knowledge Agent API

## Overview
- Backend menyediakan upload dokumen, indexing ke Vector DB, dan Q&A berbasis konteks menggunakan LLM.
- Semua endpoint berada di bawah base URL: `http://127.0.0.1:8000/api/v1`.
- CORS diaktifkan untuk development (allow origins `*`).

## Base URLs
- API: `http://127.0.0.1:8000`
- Swagger UI: `http://127.0.0.1:8000/docs`
- OpenAPI JSON: `http://127.0.0.1:8000/openapi.json`

## Authentication
- Tidak ada auth di backend lokal. Jika embedding/LLM membutuhkan auth, set di environment dan tambahkan header sesuai kebutuhan pada service.

## Models
- ChatRequest
  - `question: str`
- ChatResponse
  - `answer: str`
  - `sources: list[str]` (ID chunk dari Chroma, format `"<doc_id>:<index>"`)
- DocIndexRequest
  - `doc_id: UUID`
  - `chunks: list[str]`
- UploadResponse
  - `doc_id: UUID`
  - `filename: str`
  - `chunks_count: int`
  - `preview_chunks: list[str]`

## Endpoints

### POST /api/v1/documents/upload
- Input: `multipart/form-data` dengan field `file` (PDF/DOCX/CSV)
- Proses:
  - Simpan file ke folder `uploads/`
  - Ekstrak teks menggunakan parser sesuai tipe file
  - Chunking teks (default 1000 chars, overlap 100)
  - Simpan metadata dokumen ke Postgres
- Response: `UploadResponse`
- Contoh curl:
```
curl -X POST \
  -F "file=@/path/to/file.pdf" \
  http://127.0.0.1:8000/api/v1/documents/upload
```
- Contoh respons:
```
{
  "doc_id": "b7baf6e7-0d0a-470f-9f5e-2f0b3a1f5a1c",
  "filename": "file.pdf",
  "chunks_count": 42,
  "preview_chunks": ["chunk 1...", "chunk 2...", "chunk 3..."]
}
```

### POST /api/v1/documents/index
- Input: `DocIndexRequest` (JSON)
- Proses:
  - Async embed semua `chunks` via `httpx.AsyncClient` ke `EMBEDDING_BASE_URL`
  - Simpan ke Chroma (`add_documents`)
- Response:
```
{"status": "indexed", "doc_id": "<uuid>"}
```
- Contoh curl:
```
curl -X POST http://127.0.0.1:8000/api/v1/documents/index \
  -H "Content-Type: application/json" \
  -d '{"doc_id":"<uuid>","chunks":["text chunk 1","text chunk 2"]}'
```

### GET /api/v1/documents/{doc_id}
- Mengembalikan metadata dokumen dari Postgres
- Contoh:
```
curl http://127.0.0.1:8000/api/v1/documents/<uuid>
```
- Response:
```
{
  "id": "<uuid>",
  "filename": "file.pdf",
  "file_type": "pdf",
  "upload_timestamp": "2025-11-23T10:00:00+00:00",
  "file_path": "uploads/<uuid>_file.pdf"
}
```

### POST /api/v1/chat/
- Input: `ChatRequest` (JSON)
- Proses:
  - Embed pertanyaan → search top-3 dari Chroma → susun konteks → panggil LLM `gpt-oss-20b`
  - Simpan history ke Redis (opsional)
- Response: `ChatResponse`
- Contoh curl:
```
curl -X POST http://127.0.0.1:8000/api/v1/chat/ \
  -H "Content-Type: application/json" \
  -d '{"question":"Apa isi dokumen?"}'
```
- Contoh respons:
```
{
  "answer": "Jawaban berdasarkan konteks...",
  "sources": ["<doc-uuid>:0", "<doc-uuid>:3"]
}
```

## Workflow
1. Upload dokumen → dapatkan `doc_id` dan preview chunks
2. Kirim chunks terpilih ke `/index` untuk embedding dan penyimpanan
3. Kirim pertanyaan ke `/chat/`
4. Gunakan `sources` untuk menandai chunk yang dipakai oleh model

## Error Handling
- Format error: `{"detail": "<pesan>"}`
- Contoh kasus:
  - `400 Bad Request`: file tidak didukung atau parsing gagal
  - `500 Internal Server Error`: embedding/vector search/LLM error
  - `Invalid type for url`: pastikan `.env` berisi raw URL tanpa backticks/kutip; backend telah melakukan `str(...).strip()` untuk URL embedding

## Frontend Usage (Fetch API)
- Upload:
```
const form = new FormData();
form.append('file', file);
fetch('/api/v1/documents/upload', { method: 'POST', body: form });
```
- Index:
```
fetch('/api/v1/documents/index', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ doc_id, chunks }),
});
```
- Chat:
```
const res = await fetch('/api/v1/chat/', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ question }),
});
const data = await res.json();
```

## Notes
- Folder `uploads/` digunakan untuk menyimpan salinan file yang diunggah.
- `VECTOR_DB_PATH` menentukan lokasi penyimpanan Chroma.
- Jika diperlukan auth untuk embedding/LLM, tambahkan header di service dengan nilai dari `.env` (tidak diaktifkan secara default).
