import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qna_frontend/core/network/api_service.dart';
import 'package:qna_frontend/features/chat/data/models/message_model.dart';
import 'package:qna_frontend/features/chat/data/repositories/chat_repository.dart';

part 'chat_provider.g.dart';

/// Provides the [ApiService] instance.
@riverpod
ApiService apiService(Ref ref) {
  return ApiService();
}

/// Provides the [ChatRepository] instance.
@riverpod
ChatRepository chatRepository(Ref ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ChatRepository(apiService);
}

/// Manages the state of the chat interface.
///
/// This [AsyncNotifier] holds the list of [MessageModel]s and handles
/// sending messages to the backend. It supports optimistic UI updates
/// to make the chat feel responsive.
@riverpod
class Chat extends _$Chat {
  @override
  FutureOr<List<MessageModel>> build() {
    return [];
  }

  /// Sends a user message to the chat API.
  ///
  /// [question] is the text entered by the user.
  ///
  /// This method:
  /// 1. Immediately adds the user's message to the state (Optimistic UI).
  /// 2. Sets the state to loading (while keeping the previous data).
  /// 3. Calls the repository to get the AI's response.
  /// 4. Updates the state with the AI's response.
  /// 5. Handles errors by setting the state to [AsyncValue.error].
  Future<void> sendMessage(String question) async {
    // 1. Add user message immediately (Optimistic UI)
    final userMessage = MessageModel(
      text: question,
      isUser: true,
      timestamp: DateTime.now(),
    );

    final currentMessages = state.value ?? [];
    state = AsyncValue.data([...currentMessages, userMessage]);

    // 2. Set loading state but KEEP the data
    state = const AsyncValue<List<MessageModel>>.loading().copyWithPrevious(
      state,
    );

    try {
      final repository = ref.read(chatRepositoryProvider);
      final response = await repository.sendMessage(question);

      // 3. Update with AI response
      // We need to fetch the latest state value again because it might have changed (though unlikely in this simple flow)
      // But more importantly, we want to append to the list that includes the user message.
      final messagesWithUser = state.value ?? [];
      state = AsyncValue.data([...messagesWithUser, response]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
