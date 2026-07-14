import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smart_clinic_app/features/chat/domain/chat_message.dart';
import 'package:smart_clinic_app/features/chat/presentation/widgets/dots.dart';
import 'package:smart_clinic_app/features/chat/presentation/widgets/image_gallery_sheet.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCopy;
  final VoidCallback? onAnalyze;

  const ChatBubble({
    super.key,
    required this.message,
    this.onEdit,
    this.onDelete,
    this.onCopy,
    this.onAnalyze,
  });

  Color get _bubbleColor {
    if (message.isUser) return const Color(0xFF2196F3);
    return const Color(0xFFF1F3F4);
  }

  Color get _textColor {
    return message.isUser ? Colors.white : Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showOptions(context),
      child: Column(
        crossAxisAlignment: message.isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _bubbleColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(message.isUser ? 18 : 4),
                    bottomRight: Radius.circular(message.isUser ? 4 : 18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildContent(context),
              ),
              Positioned(
                bottom: 0,
                right: message.isUser ? -8 : null,
                left: message.isUser ? null : -8,
                child: CustomPaint(
                  painter: BubbleArrowPainter(_bubbleColor, message.isUser),
                  size: const Size(12, 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _buildMetadata(),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (message.isGenerating && message.text.isEmpty) {
      return const TypingDots();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Attached file indicator
        if (message.attachedFile != null) _buildFileIndicator(context),

        // Text content
        if (message.text.isNotEmpty)
          message.isUser
              ? Text(
                  message.text,
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 15,
                    height: 1.4,
                  ),
                )
              : MarkdownBody(
                  selectable: true,
                  data: message.text,
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      height: 1.5,
                    ),
                    strong:  TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    h2: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    h3: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    code: TextStyle(
                      backgroundColor: Colors.grey.shade200,
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                    blockquoteDecoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border(
                        left: BorderSide(
                          color: Colors.blue.shade300,
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                ),

        // Image results
        if (message.imageUrls != null && message.imageUrls!.isNotEmpty)
          _buildImageGrid(context),
      ],
    );
  }

  Widget _buildFileIndicator(BuildContext context) {
    final file = message.attachedFile!;
    final isReceipt = file.type == AttachmentType.receipt;
    final isImage = file.type == AttachmentType.image;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: message.isUser
            ? Colors.white.withOpacity(0.2)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isReceipt
                ? Icons.receipt_long
                : isImage
                    ? Icons.image
                    : Icons.picture_as_pdf,
            color: message.isUser ? Colors.white : Colors.blue.shade700,
            size: 20,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              file.name,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    final images = message.imageUrls!;
    final displayImages = images.take(6).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: displayImages.length,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () => _openImageGallery(context, images, i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                displayImages[i],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetadata() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatTime(message.timestamp),
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
          if (message.isEdited) ...[
            const SizedBox(width: 4),
            Text(
              '• edited',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _openImageGallery(
    BuildContext context,
    List<String> images,
    int initialIndex,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (_) => ImageGallerySheet(
        images: images,
        initialIndex: initialIndex,
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _MessageOptionsSheet(
        message: message,
        onEdit: onEdit,
        onDelete: onDelete,
        onCopy: onCopy,
        onAnalyze: onAnalyze,
      ),
    );
  }
}

// ─── Options Sheet ─────────────────────────────────────────────────────────────

class _MessageOptionsSheet extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCopy;
  final VoidCallback? onAnalyze;

  const _MessageOptionsSheet({
    required this.message,
    this.onEdit,
    this.onDelete,
    this.onCopy,
    this.onAnalyze,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            _OptionTile(
              icon: Icons.copy_outlined,
              label: 'Copy',
              onTap: () {
                Navigator.pop(context);
                Clipboard.setData(ClipboardData(text: message.text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Copied to clipboard'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            if (message.isUser) ...[
              _OptionTile(
                icon: Icons.edit_outlined,
                label: 'Edit',
                onTap: () {
                  Navigator.pop(context);
                  onEdit?.call();
                },
              ),
            ],
            if (!message.isUser)
              _OptionTile(
                icon: Icons.analytics_outlined,
                label: 'Re-analyze',
                onTap: () {
                  Navigator.pop(context);
                  onAnalyze?.call();
                },
              ),
            _OptionTile(
              icon: Icons.delete_outline,
              label: 'Delete',
              color: Colors.red,
              onTap: () {
                Navigator.pop(context);
                onDelete?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _OptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tileColor = color ?? Colors.black87;
    return ListTile(
      leading: Icon(icon, color: tileColor),
      title: Text(
        label,
        style: TextStyle(color: tileColor, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

// ─── Arrow Painter ─────────────────────────────────────────────────────────────

class BubbleArrowPainter extends CustomPainter {
  final Color color;
  final bool isUser;

  BubbleArrowPainter(this.color, this.isUser);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isUser) {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}