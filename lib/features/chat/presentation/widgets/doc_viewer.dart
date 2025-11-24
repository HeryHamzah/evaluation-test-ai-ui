import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A side panel for viewing document context.
///
/// Currently a placeholder. In a full implementation, this would show
/// the text of the source chunk referenced by the AI's answer.
class DocViewer extends ConsumerWidget {
  const DocViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real implementation, this would listen to a provider that tracks
    // the currently selected document or chunk.
    // For now, we'll show a placeholder or a list of "Indexed Chunks" if available.
    
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Source Context',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined, 
                    size: 48, 
                    color: Colors.grey[300]
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select a source citation\nto view context',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
