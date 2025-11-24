import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

/// Represents a chat message in the application.
///
/// This model is used for both user questions and AI answers.
/// It supports serialization to/from JSON for API communication.
@JsonSerializable()
class MessageModel {
  /// The content of the message.
  final String text;

  /// True if the message was sent by the user, false if by the AI.
  final bool isUser;

  /// List of source citations (e.g., "doc_id:chunk_index") provided by the AI.
  /// Only applicable for AI responses.
  final List<String>? sources;

  /// Timestamp when the message was created.
  final DateTime timestamp;

  MessageModel({
    required this.text,
    required this.isUser,
    this.sources,
    required this.timestamp,
  });

  /// Creates a [MessageModel] from a JSON map.
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  /// Converts this [MessageModel] to a JSON map.
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
