// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
  text: json['text'] as String,
  isUser: json['isUser'] as bool,
  sources: (json['sources'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'isUser': instance.isUser,
      'sources': instance.sources,
      'timestamp': instance.timestamp.toIso8601String(),
    };
