import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:qna_frontend/core/constants/api_constants.dart';
import 'package:qna_frontend/core/network/api_service.dart';
import 'package:qna_frontend/features/upload/data/models/document_model.dart';

/// Repository responsible for document upload and indexing operations.
class DocumentRepository {
  final ApiService _apiService;

  DocumentRepository(this._apiService);

  /// Uploads a file to the backend.
  ///
  /// [file] is the [PlatformFile] selected by the user.
  /// Supports both Web (bytes) and Mobile/Desktop (path).
  /// Returns a [DocumentModel] with the upload result.
  Future<DocumentModel> uploadDocument(PlatformFile file) async {
    try {
      MultipartFile multipartFile;

      if (file.bytes != null) {
        // Web: Use bytes
        multipartFile = MultipartFile.fromBytes(
          file.bytes!,
          filename: file.name,
        );
      } else if (file.path != null) {
        // Mobile/Desktop: Use path
        multipartFile = await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
        );
      } else {
        throw Exception('File has no path or bytes');
      }

      final formData = FormData.fromMap({'file': multipartFile});

      final response = await _apiService.dio.post(
        ApiConstants.uploadEndpoint,
        data: formData,
      );

      return DocumentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Triggers the indexing process for a specific document.
  ///
  /// [docId] is the UUID of the uploaded document.
  /// [chunks] is the list of text chunks to be embedded and stored.
  /// Throws an [Exception] if indexing fails.
  Future<void> indexDocument(String docId, List<String> chunks) async {
    try {
      await _apiService.dio.post(
        ApiConstants.indexEndpoint,
        data: {'doc_id': docId, 'chunks': chunks},
      );
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
