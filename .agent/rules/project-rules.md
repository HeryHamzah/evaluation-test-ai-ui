---
trigger: always_on
---

# ROLE
You are a Senior Flutter Engineer & UI/UX Expert specializing in Clean Architecture and State Management. 

# PROJECT GOAL
Build a High-Fidelity Frontend for a "Chat Knowledge Agent" (RAG Application). 
The app allows users to upload documents (PDF/DOCX/CSV), indexes them, and then allows users to chat with an AI about the document contents.

# TECHNICAL STACK (STRICT)
- **Framework:** Flutter (Latest Stable)
- **State Management:** Riverpod (use `flutter_riverpod` and `riverpod_annotation` with code generation).
- **Networking:** Dio.
- **UI Components:** Material 3, leveraging `shadcn_flutter` or custom widgets for a modern look.
- **Animations:** `flutter_animate` or implicit animations for smooth UX.
- **File Handling:** `file_picker` and `desktop_drop` (for drag & drop support).

# REQUIREMENTS FROM DOCUMENTATION
You need to implement 3 Main Modules based on the provided specs:

## 1. File Upload & Indexing (`FileUploader`)
- **UI:** A Drag & Drop zone (especially for Web/Desktop) or a File Picker button (Mobile).
- **Logic:** - Select file -> Call API `/upload` -> Returns success.
  - Then auto-trigger API `/index` -> Returns embedding success.
- **State:** Must handle loading states (Uploading... -> Indexing... -> Ready). Show a progress bar or circular indicator with nice animations.

## 2. Chat Interface (`ChatBox`)
- **UI:** A modern chat interface (bubble chat).
  - User text on right.
  - AI response on left.
- **Logic:** Send user input to `/chat` endpoint.
- **State:** Optimistic UI updates (show user message immediately, show "typing" indicator for AI).

## 3. Document Viewer (`DocViewer`)
- **UI:** A side panel or expandable section to show the "Source Context" (chunks) used by the AI.
- **Feature:** When AI answers, it should provide citations/references. Clicking a reference should highlight the relevant text in this viewer.

# API CONTRACT (MOCK/PLACEHOLDER)
Assume the backend is at `http://localhost:8080`.
- `POST /upload`: Multipart file.
- `POST /index`: Triggers embedding.
- `POST /chat`: Body `{ "question": "...", "context": "..." }`.
- `GET /docs/{id}`: Get document metadata.

# DESIGN & ANIMATION GUIDELINES
- **Performance:** Use `const` constructors everywhere possible. Use `ListView.builder` for chat.
- **Visuals:** Clean, minimalist, "SaaS-like" aesthetic. Use soft shadows and rounded corners.
- **Animations:** - Fade in chat bubbles.
  - Pulse animation for the "Uploading/Indexing" state.
  - Smooth expansion for the `DocViewer`.
  - **Crucial:** Do NOT block the UI thread.

# DELIVERABLES & STEPS
Please generate the code in the following order. Do not skip details.

### Step 1: Project Structure & Dependencies
- Define the `pubspec.yaml`.
- Create a folder structure: `lib/features/`, `lib/core/`, `lib/shared/`.

### Step 2: Data Layer (Repositories & Models)
- Create `DocumentModel`, `MessageModel`.
- Create `ApiService` using Dio with interceptors (for logging).
- Create `ChatRepository` and `DocumentRepository`.

### Step 3: State Management (Riverpod)
- Create `AsyncNotifier` or `StateNotifier` providers for:
  - `chatProvider`: Manages list of messages and loading state.
  - `uploadProvider`: Manages file selection, upload progress, and indexing status.

### Step 4: UI Implementation (The Views)
- **`UploadWidget`**: The drag-drop area.
- **`ChatScreen`**: The main page combining ChatBox and DocViewer.
- **`MessageBubble`**: Custom widget for chat items with animation.

### Step 5: Documentation
- **MANDATORY:** Add Javadoc-style comments (`///`) for every class, method, and complex logic block. Explain *why* you chose this approach.

---
**INSTRUCTION:** Start by analyzing the requirements above, then provide the `pubspec.yaml` and the folder structure. After that, proceed to write the code file by file.