import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qna_frontend/features/upload/presentation/providers/upload_provider.dart';

/// A widget that handles file selection via drag-and-drop or file picker.
///
/// It listens to the [uploadProvider] to show the current status
/// (uploading, indexing, success, error) with appropriate animations.
class UploadWidget extends ConsumerStatefulWidget {
  const UploadWidget({super.key});

  @override
  ConsumerState<UploadWidget> createState() => _UploadWidgetState();
}

class _UploadWidgetState extends ConsumerState<UploadWidget> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final uploadStatus = ref.watch(uploadProvider);

    return DropTarget(
      onDragEntered: (details) {
        setState(() => _isDragging = true);
      },
      onDragExited: (details) {
        setState(() => _isDragging = false);
      },
      onDragDone: (details) async {
        setState(() => _isDragging = false);
        if (details.files.isNotEmpty) {
          final xfile = details.files.first;

          // Convert XFile to PlatformFile
          final bytes = await xfile.readAsBytes();
          final platformFile = PlatformFile(
            name: xfile.name,
            size: await xfile.length(),
            bytes: bytes,
            path: xfile.path,
          );

          await _handleFileUpload(platformFile);
        }
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: _isDragging
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isDragging
                ? Theme.of(context).colorScheme.primary
                : const Color(0xFFE2E8F0),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: InkWell(
          onTap:
              uploadStatus == UploadStatus.uploading ||
                  uploadStatus == UploadStatus.indexing
              ? null
              : _pickFile,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(uploadStatus),
              const SizedBox(height: 16),
              _buildText(uploadStatus),
            ],
          ),
        ),
      ).animate().fadeIn().scale(),
    );
  }

  Widget _buildIcon(UploadStatus status) {
    switch (status) {
      case UploadStatus.uploading:
      case UploadStatus.indexing:
        return const CircularProgressIndicator()
            .animate(onPlay: (controller) => controller.repeat())
            .rotate();
      case UploadStatus.success:
        return Icon(
          Icons.check_circle_outline,
          size: 48,
          color: Colors.green[600],
        ).animate().scale(duration: 400.ms, curve: Curves.elasticOut);
      case UploadStatus.error:
        return Icon(
          Icons.error_outline,
          size: 48,
          color: Colors.red[600],
        ).animate().shake();
      default:
        return Icon(
          Icons.cloud_upload_outlined,
          size: 48,
          color: _isDragging
              ? Theme.of(context).colorScheme.primary
              : const Color(0xFF94A3B8),
        );
    }
  }

  Widget _buildText(UploadStatus status) {
    switch (status) {
      case UploadStatus.uploading:
        return const Text(
          'Uploading document...',
          style: TextStyle(fontWeight: FontWeight.w500),
        );
      case UploadStatus.indexing:
        return const Text(
          'Indexing content...',
          style: TextStyle(fontWeight: FontWeight.w500),
        );
      case UploadStatus.success:
        return const Text(
          'Ready to chat!',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
        );
      case UploadStatus.error:
        return const Text(
          'Upload failed. Try again.',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
        );
      default:
        return Column(
          children: [
            Text(
              'Click to upload or drag and drop',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'PDF, DOCX, or CSV (max. 10MB)',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
          ],
        );
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'csv'],
      withData: true, // Important for Web to get bytes!
    );

    if (result != null) {
      await _handleFileUpload(result.files.single);
    }
  }

  Future<void> _handleFileUpload(PlatformFile file) async {
    await ref.read(uploadProvider.notifier).uploadAndIndex(file);
  }
}
