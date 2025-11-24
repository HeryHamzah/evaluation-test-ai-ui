// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    DocumentModel(
      id: json['doc_id'] as String,
      filename: json['filename'] as String,
      chunksCount: (json['chunks_count'] as num).toInt(),
      previewChunks: (json['preview_chunks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DocumentModelToJson(DocumentModel instance) =>
    <String, dynamic>{
      'doc_id': instance.id,
      'filename': instance.filename,
      'chunks_count': instance.chunksCount,
      'preview_chunks': instance.previewChunks,
    };
