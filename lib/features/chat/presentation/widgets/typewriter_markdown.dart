import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// A widget that displays Markdown text with a typewriter effect.
///
/// The text appears character by character (or word by word) to simulate typing.
class TypewriterMarkdown extends StatefulWidget {
  final String text;
  final Duration duration;
  final VoidCallback? onComplete;
  final MarkdownStyleSheet? styleSheet;

  const TypewriterMarkdown({
    super.key,
    required this.text,
    this.duration = const Duration(milliseconds: 10),
    this.onComplete,
    this.styleSheet,
  });

  @override
  State<TypewriterMarkdown> createState() => _TypewriterMarkdownState();
}

class _TypewriterMarkdownState extends State<TypewriterMarkdown> {
  String _displayedText = '';
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(covariant TypewriterMarkdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _currentIndex = 0;
      _displayedText = '';
      _startTyping();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTyping() {
    _timer?.cancel();

    // If text is empty or already fully displayed (shouldn't happen on init but good for safety)
    if (widget.text.isEmpty) {
      if (widget.onComplete != null) widget.onComplete!();
      return;
    }

    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _currentIndex++;
          _displayedText = widget.text.substring(0, _currentIndex);
        });
      } else {
        _timer?.cancel();
        if (widget.onComplete != null) widget.onComplete!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use a key based on the text length to help Flutter rebuild correctly if needed,
    // though setState should handle it.
    return MarkdownBody(
      data: _displayedText,
      styleSheet:
          widget.styleSheet ??
          MarkdownStyleSheet(p: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
