import 'package:json_annotation/json_annotation.dart';

part 'document_model.g.dart';

/// Represents an uploaded document.
///
/// Contains metadata about the file and optionally a preview of its chunks.
@JsonSerializable()
class DocumentModel {
  /// Unique identifier for the document (UUID).
  @JsonKey(name: 'doc_id')
  final String id;

  /// Original filename of the uploaded document.
  final String filename;

  /// Total number of chunks extracted from the document.
  @JsonKey(name: 'chunks_count')
  final int chunksCount;

  /// A subset of chunks returned by the upload API for preview/indexing.
  @JsonKey(name: 'preview_chunks')
  final List<String>? previewChunks;

  DocumentModel({
    required this.id,
    required this.filename,
    required this.chunksCount,
    this.previewChunks,
  });

  /// Creates a [DocumentModel] from a JSON map.
  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  /// Converts this [DocumentModel] to a JSON map.
  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);
}
