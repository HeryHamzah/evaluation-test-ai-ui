import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qna_frontend/features/chat/presentation/screens/chat_screen.dart';
import 'package:qna_frontend/shared/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Knowledge Agent',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ChatScreen(),
    );
  }
}
