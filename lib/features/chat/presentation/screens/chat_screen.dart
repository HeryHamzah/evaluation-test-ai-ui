import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qna_frontend/features/chat/presentation/providers/chat_provider.dart';
import 'package:qna_frontend/features/chat/presentation/widgets/doc_viewer.dart';
import 'package:qna_frontend/features/chat/presentation/widgets/message_bubble.dart';
import 'package:qna_frontend/features/upload/presentation/providers/upload_provider.dart';
import 'package:qna_frontend/features/upload/presentation/widgets/upload_widget.dart';

/// The main screen of the application.
///
/// Displays the [UploadWidget] if no document is uploaded,
/// or the chat interface (messages list + input) if a document is ready.
/// On large screens, it also shows the [DocViewer] side panel.
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final uploadStatus = ref.watch(uploadProvider);
    final chatState = ref.watch(chatProvider);
    final isLargeScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // Header / Top Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, 
                        color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      Text(
                        'Chat Knowledge Agent',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: uploadStatus != UploadStatus.success
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 600),
                              child: const UploadWidget(),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: chatState.when(
                                data: (messages) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                                  
                                  if (messages.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'Ask me anything about your document!',
                                        style: TextStyle(color: Colors.grey[400]),
                                      ),
                                    );
                                  }
                                  
                                  return ListView.builder(
                                    controller: _scrollController,
                                    padding: const EdgeInsets.all(16),
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      return MessageBubble(message: messages[index]);
                                    },
                                  );
                                },
                                loading: () => const Center(child: CircularProgressIndicator()),
                                error: (err, stack) => Center(child: Text('Error: $err')),
                              ),
                            ),
                            
                            // Input Area
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(top: BorderSide(color: Colors.grey[200]!)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                        hintText: 'Type your question...',
                                        border: OutlineInputBorder(),
                                      ),
                                      onSubmitted: (_) => _sendMessage(),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton.filled(
                                    onPressed: _sendMessage,
                                    icon: const Icon(Icons.send),
                                    style: IconButton.styleFrom(
                                      padding: const EdgeInsets.all(16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          
          // DocViewer (Side Panel)
          if (isLargeScreen) ...[
            const VerticalDivider(width: 1),
            const Expanded(
              flex: 1,
              child: DocViewer(),
            ),
          ],
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      ref.read(chatProvider.notifier).sendMessage(text);
      _controller.clear();
    }
  }
}
