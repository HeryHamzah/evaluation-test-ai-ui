import 'package:dio/dio.dart';
import 'package:qna_frontend/core/constants/api_constants.dart';
import 'package:qna_frontend/core/network/api_service.dart';
import 'package:qna_frontend/features/chat/data/models/message_model.dart';

/// Repository responsible for chat-related operations.
///
/// Handles sending messages to the backend and parsing the responses.
class ChatRepository {
  final ApiService _apiService;

  ChatRepository(this._apiService);

  /// Sends a user question to the chat API and returns the AI's response.
  ///
  /// [question] is the user's input text.
  /// Returns a [MessageModel] containing the AI's answer and sources.
  /// Throws an [Exception] if the API call fails.
  Future<MessageModel> sendMessage(String question) async {
    try {
      final response = await _apiService.dio.post(
        ApiConstants.chatEndpoint,
        data: {'question': question},
      );

      return MessageModel(
        text: response.data['answer'],
        isUser: false,
        sources: (response.data['sources'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        timestamp: DateTime.now(),
      );
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
