import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qna_frontend/features/chat/presentation/providers/chat_provider.dart';
import 'package:qna_frontend/features/upload/data/repositories/document_repository.dart';

part 'upload_provider.g.dart';

/// Provides the [DocumentRepository] instance.
@riverpod
DocumentRepository documentRepository(Ref ref) {
  final apiService = ref.watch(apiServiceProvider);
  return DocumentRepository(apiService);
}

/// Represents the various states of the file upload process.
enum UploadStatus { initial, uploading, indexing, success, error }

/// Manages the state of document upload and indexing.
///
/// This [AutoDisposeNotifier] tracks the current [UploadStatus] and
/// exposes methods to trigger the upload flow.
@riverpod
class Upload extends _$Upload {
  @override
  UploadStatus build() {
    return UploadStatus.initial;
  }

  /// Uploads a file and triggers indexing.
  ///
  /// [file] is the [PlatformFile] selected by the user.
  ///
  /// The flow is:
  /// 1. Set status to [UploadStatus.uploading].
  /// 2. Upload the file via [DocumentRepository].
  /// 3. Set status to [UploadStatus.indexing].
  /// 4. Index the document chunks.
  /// 5. Set status to [UploadStatus.success].
  ///
  /// If any step fails, the status is set to [UploadStatus.error].
  Future<void> uploadAndIndex(PlatformFile file) async {
    state = UploadStatus.uploading;
    try {
      final repository = ref.read(documentRepositoryProvider);

      // 1. Upload
      final document = await repository.uploadDocument(file);

      // 2. Index
      state = UploadStatus.indexing;
      // Index all chunks by default for now
      // In a real app, we might let the user select chunks
      if (document.previewChunks != null) {
        await repository.indexDocument(document.id, document.previewChunks!);
      }

      state = UploadStatus.success;
    } catch (e) {
      state = UploadStatus.error;
      // You might want to expose the error message in the state
    }
  }
}
