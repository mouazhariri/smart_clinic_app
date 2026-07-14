

// import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:smart_clinic_app/features/chat/Domain/chat_message.dart';
// import 'package:smart_clinic_app/features/chat/presentation/controller/chat_controller.dart';
// import 'package:smart_clinic_app/features/chat/presentation/widgets/chat_bubble.dart';
// import 'package:smart_clinic_app/features/chat/presentation/widgets/chat_input_bar.dart';
// import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';

// class ChatScreen extends ConsumerStatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   ConsumerState<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final _textController = TextEditingController();
//   final _scrollController = ScrollController();
//   bool _showJumpButton = false;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     ref.listenManual(chatControllerProvider, (_, __) {
//       WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
//     });
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (!_scrollController.hasClients) return;
//     final distanceFromBottom = _scrollController.position.maxScrollExtent -
//         _scrollController.position.pixels;
//     final shouldShow = distanceFromBottom > 200;
//     if (shouldShow != _showJumpButton) {
//       setState(() => _showJumpButton = shouldShow);
//     }
//   }

//   Future<void> _scrollToBottom() async {
//     if (!_scrollController.hasClients) return;
//     await Future.delayed(const Duration(milliseconds: 50));
//     if (!_scrollController.hasClients) return;
//     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//   }

//   void _jumpToBottom() {
//     if (!_scrollController.hasClients) return;
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   void _sendMessage() {
//     final text = _textController.text.trim();
//     if (text.isEmpty) return;
//     ref.read(chatControllerProvider.notifier).sendMessage(text);
//     _textController.clear();
//     setState(() {});
//   }

//   Future<void> _showEditDialog(ChatMessage msg) async {
//     final editController = TextEditingController(text: msg.text);
//     await showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Row(
//           children: [
//             Icon(Icons.edit_outlined, color: Colors.blue),
//             SizedBox(width: 8),
//             Text('Edit Message'),
//           ],
//         ),
//         content: TextField(
//           controller: editController,
//           maxLines: 5,
//           autofocus: true,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: Navigator.of(context).pop,
//             child: Text(context.tr('cancel')),
//           ),
//           FilledButton.icon(
//             onPressed: () {
//               final newText = editController.text.trim();
//               if (newText.isEmpty) return;
//               ref.read(chatControllerProvider.notifier).editMessage(
//                     messageId: msg.id,
//                     newText: newText,
//                   );
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.send, size: 16),
//             label: const Text('Send'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showClearChatDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Clear Chat'),
//         content: const Text(
//           'Are you sure you want to clear all messages?',
//         ),
//         actions: [
//           TextButton(
//             onPressed: Navigator.of(context).pop,
//             child: Text(context.tr('cancel')),
//           ),
//           FilledButton(
//             style: FilledButton.styleFrom(backgroundColor: AppColors.errorRed),
//             onPressed: () {
//               ref.read(chatControllerProvider.notifier).clearChat();
//               Navigator.pop(context);
//             },
//             child: const Text('Clear'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final messages = ref.watch(
//       chatControllerProvider.select((v) => v.value?.messages),
//     );
//     final isLoading = ref.watch(
//       chatControllerProvider.select((v) => v.value?.isLoading ?? false),
//     );
//     final canSend = ref.watch(
//       chatControllerProvider.select((v) => v.value?.canSend ?? false),
//     );

//     // Auto-scroll when loading
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (isLoading) _jumpToBottom();
//     });

//     return Scaffold(
//       backgroundColor: AppColors.authBackground,
//       appBar: _buildAppBar(messages),
//       floatingActionButton: _buildJumpButton(),
//       body: Column(
//         children: [
//           Expanded(
//             child: messages == null || messages.isEmpty
//                 ? _buildEmptyState()
//                 : _buildMessageList(messages, isLoading),
//           ),
//           ChatInputBar(
//             textController: _textController,
//             isLoading: isLoading,
//             canSend: canSend,
//             onSend: _sendMessage,
//             onStop: () =>
//                 ref.read(chatControllerProvider.notifier).stopGeneration(),
//           ),
//         ],
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(List<ChatMessage>? messages) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: AppColors.white,
//       surfaceTintColor: AppColors.white,
//       title: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.secondPrimary, AppColors.secondPrimary],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.medical_services_rounded,
//               color: AppColors.white,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Doctor AI',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//               Text(
//                 'Medical Assistant',
//                 style: TextStyle(
//                   fontSize: 11,
//                   color: AppColors.authHint,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         if (messages != null && messages.isNotEmpty)
//           IconButton(
//             icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.grey),
//             tooltip: 'Clear chat',
//             onPressed: _showClearChatDialog,
//           ),
//         const SizedBox(width: 4),
//       ],
//     );
//   }

//   Widget _buildJumpButton() {
//     return AnimatedScale(
//       duration: const Duration(milliseconds: 200),
//       scale: _showJumpButton ? 1.0 : 0.0,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 70),
//         child: FloatingActionButton.small(
//           backgroundColor: AppColors.white,
//           elevation: 4,
//           onPressed: _jumpToBottom,
//           child: const Icon(
//             Icons.keyboard_arrow_down_rounded,
//             color: Colors.blue,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 90,
//               height: 90,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primaryBg, AppColors.primaryBg],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.medical_services_rounded,
//                 size: 44,
//                 color: AppColors.primary,
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Doctor AI Assistant',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Ask me anything about symptoms, medications, or medical reports. I can also analyze your prescriptions and lab results.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textSecondary,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 32),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               alignment: WrapAlignment.center,
//               children: [
//                 _SuggestionChip(
//                   label: '💊 Explain medication',
//                   onTap: () {
//                     _textController.text = 'Explain what ibuprofen is used for';
//                     setState(() {});
//                   },
//                 ),
//                 _SuggestionChip(
//                   label: '🩺 Check symptoms',
//                   onTap: () {
//                     _textController.text =
//                         'I have headache and fever, what could it be?';
//                     setState(() {});
//                   },
//                 ),
//                 _SuggestionChip(
//                   label: '📋 Analyze report',
//                   onTap: () {
//                     _textController.text = 'How do I read a CBC blood test?';
//                     setState(() {});
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageList(
//     List<ChatMessage> messages,
//     bool isLoading,
//   ) {
//     return ListView.builder(
//       controller: _scrollController,
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       itemCount: messages.length,
//       itemBuilder: (_, index) {
//         final msg = messages[index];
//         final showDateDivider = _shouldShowDateDivider(messages, index);

//         return Column(
//           children: [
//             if (showDateDivider) _DateDivider(date: msg.timestamp),
//             Align(
//               alignment:
//                   msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: msg.isUser ? 60 : 12,
//                   right: msg.isUser ? 12 : 60,
//                   bottom: 4,
//                 ),
//                 child: ChatBubble(
//                   message: msg,
//                   onEdit: msg.isUser ? () => _showEditDialog(msg) : null,
//                   onDelete: () => ref
//                       .read(chatControllerProvider.notifier)
//                       .deleteMessage(msg.id),
//                   onAnalyze: !msg.isUser
//                       ? () {
//                           // Re-send the previous user message
//                           final msgIndex = messages.indexOf(msg);
//                           if (msgIndex > 0 && messages[msgIndex - 1].isUser) {
//                             ref
//                                 .read(chatControllerProvider.notifier)
//                                 .sendMessage(messages[msgIndex - 1].text);
//                           }
//                         }
//                       : null,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   bool _shouldShowDateDivider(List<ChatMessage> messages, int index) {
//     if (index == 0) return true;
//     final current = messages[index].timestamp;
//     final previous = messages[index - 1].timestamp;
//     return current.day != previous.day ||
//         current.month != previous.month ||
//         current.year != previous.year;
//   }
// }

// // ─── Date Divider ─────────────────────────────────────────────────────────────

// class _DateDivider extends StatelessWidget {
//   final DateTime date;

//   const _DateDivider({required this.date});

//   String _formatDate() {
//     final now = DateTime.now();
//     if (date.day == now.day &&
//         date.month == now.month &&
//         date.year == now.year) {
//       return 'today';
//     }
//     final yesterday = now.subtract(const Duration(days: 1));
//     if (date.day == yesterday.day &&
//         date.month == yesterday.month &&
//         date.year == yesterday.year) {
//       return 'yesterday';
//     }
//     return '${date.day}/${date.month}/${date.year}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Row(
//         children: [
//           Expanded(child: Divider(color: AppColors.authInputBorder)),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Text(
//               context.tr(_formatDate()),
//               style: TextStyle(
//                 fontSize: 12,
//                 color: AppColors.authHint,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Expanded(child: Divider(color: AppColors.authInputBorder)),
//         ],
//       ),
//     );
//   }
// }

// // ─── Suggestion Chip ──────────────────────────────────────────────────────────

// class _SuggestionChip extends StatelessWidget {
//   final String label;
//   final VoidCallback onTap;

//   const _SuggestionChip({required this.label, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: AppColors.primaryBg),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.black.withOpacity(0.04),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: AppColors.secondPrimary,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_clinic_app/features/chat/domain/chat_message.dart';
// import 'package:smart_clinic_app/features/chat/domain/chat_message.dart';
import 'package:smart_clinic_app/features/chat/presentation/controller/chat_controller.dart';
import 'package:smart_clinic_app/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:smart_clinic_app/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:smart_clinic_app/src/logger/log_services/dev_logger.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String? sessionId; // null = new chat

  const ChatScreen({super.key, this.sessionId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool _showJumpButton = false;
  bool _isInitialized = false; // ← prevent double init

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    ref.listenManual(chatControllerProvider, (_, __) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    });
      WidgetsBinding.instance.addPostFrameCallback((_) {
      _initSession();
    });
  }
 Future<void> _initSession() async {
    if (_isInitialized) return;
    _isInitialized = true;

    final notifier = ref.read(chatControllerProvider.notifier);

    if (widget.sessionId != null) {
      Dev.logLine("loadSession");

      // ✅ Load existing session
      await notifier.loadSession(widget.sessionId!);
    } else {
      Dev.logLine("startNewSession");
      // ✅ Start new session
      await notifier.startNewSession();
    }
  }
  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final distanceFromBottom = _scrollController.position.maxScrollExtent -
        _scrollController.position.pixels;
    final shouldShow = distanceFromBottom > 200;
    if (shouldShow != _showJumpButton) {
      setState(() => _showJumpButton = shouldShow);
    }
  }

  Future<void> _scrollToBottom() async {
    if (!_scrollController.hasClients) return;
    await Future.delayed(const Duration(milliseconds: 50));
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void _jumpToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    ref.read(chatControllerProvider.notifier).sendMessage(text);
    _textController.clear();
    setState(() {});
  }

  // ── Professional Edit Dialog ─────────────────────────────────────────────

  Future<void> _showEditDialog(ChatMessage msg) async {
    final editController = TextEditingController(text: msg.text);
    String currentText = msg.text;

    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: context.tr('edit_message'),
      barrierColor: AppColors.textSecondary,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (ctx, anim, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: anim,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
      pageBuilder: (ctx, _, __) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                color: AppColors.transparent,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Handle ────────────────────────────────────────
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.authInputBorder,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ── Header ────────────────────────────────────────
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.authLightBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.edit_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr('edit_message'),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    context.tr('conversation_restart_notice'),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ── Text Field ────────────────────────────────────
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.authBackground,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.authDivider),
                          ),
                          child: TextField(
                            controller: editController,
                            maxLines: 6,
                            minLines: 3,
                            autofocus: true,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                            ),
                            decoration: InputDecoration(
                              hintText: context.tr('edit_message_hint'),
                              hintStyle: TextStyle(color: AppColors.authIcon),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            onChanged: (v) {
                              setDialogState(() => currentText = v);
                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        // ── Character count ───────────────────────────────
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            context.tr('characters_count', args: [currentText.length.toString()]),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.authIcon,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Warning ───────────────────────────────────────
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.stockMedBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.stockMedBg),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: AppColors.stockMedText, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  context.tr('edit_message_warning'),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.stockMedText,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Actions ───────────────────────────────────────
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide(
                                      color: AppColors.authInputBorder),
                                ),
                                child: Text(
                                  context.tr('cancel'),
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: FilledButton.icon(
                                onPressed: editController.text.trim().isEmpty
                                    ? null
                                    : () {
                                        final newText =
                                            editController.text.trim();
                                        Navigator.pop(context);
                                        ref
                                            .read(chatControllerProvider
                                                .notifier)
                                            .editMessage(
                                              messageId: msg.id,
                                              newText: newText,
                                            );
                                      },
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: const Icon(Icons.send_rounded, size: 18),
                                label: Text(
                                  context.tr('send_edited_message'),
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    editController.dispose();
  }

  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(context.tr('clear_conversation')),
        content: Text(context.tr('delete_conversation_warning')),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(context.tr('cancel')),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.errorRed),
            onPressed: () {
              ref.read(chatControllerProvider.notifier).clearChat();
              Navigator.pop(context);
              Navigator.pop(context); // Go back to sessions
            },
            child: Text(context.tr('delete')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final chatState = ref.watch(chatControllerProvider);
   // ✅ STEP 1: Watch the async state — never call requireValue
    final chatAsync = ref.watch(chatControllerProvider);

    // ✅ STEP 2: Handle loading FIRST before accessing value
    if (chatAsync.isLoading) {
      return _buildLoadingScaffold();
    }

    // ✅ STEP 3: Handle error state
    if (chatAsync.hasError) {
      return _buildErrorScaffold(chatAsync.error.toString());
    }

    // ✅ STEP 4: Now safe to access value
    final chatState = chatAsync.value;
    if (chatState == null) {
      return _buildLoadingScaffold();
    }
    final messages = chatState.messages;
    final isLoading = chatState.isLoading;
    final canSend = chatState.canSend;
    final sessionTitle = chatState.sessionTitle;
    final isOcrProcessing = chatState.isOcrProcessing;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading) _jumpToBottom();
    });

  // Dev.logLine("IN CHAT SCREEN MESSAGE IS ");
  // Dev. logList(messages);
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      appBar: _buildAppBar(sessionTitle, messages),
      floatingActionButton: _buildJumpButton(),
      body: Column(
        children: [
          // OCR processing banner
          if (isOcrProcessing)
            _OcrProcessingBanner().animate().slideY(begin: -1, end: 0),

          Expanded(
            child:  messages.isEmpty
                ? _buildEmptyState()
                : _buildMessageList(messages, isLoading),
          ),
          ChatInputBar(
            textController: _textController,
            isLoading: isLoading,
            canSend: canSend,
            onSend: _sendMessage,
            onStop: () =>
                ref.read(chatControllerProvider.notifier).stopGeneration(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    String sessionTitle,
    List<ChatMessage>? messages,
  ) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sessionTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.successGreen,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                context.tr('ai_medical_assistant'),
                style: TextStyle(fontSize: 11, color: AppColors.white70),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (messages != null && messages.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.white70),
            onPressed: _showClearChatDialog,
          ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildJumpButton() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: _showJumpButton ? 1.0 : 0.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.small(
          backgroundColor: AppColors.white,
          elevation: 4,
          onPressed: _jumpToBottom,
          child: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryBg, AppColors.primaryBg],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.medical_services_rounded,
              size: 50,
              color: AppColors.white,
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),

          const SizedBox(height: 24),
          Text(
            context.tr('how_can_i_help'),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 12),
          Text(
            context.tr('ask_medical_assistant_hint'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
          ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: 32),

          // Quick Suggestions
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _SuggestionChip(
                icon: '💊',
                label: context.tr('explain_medication'),
                onTap: () {
                  _textController.text = 'What is ibuprofen used for?';
                  setState(() {});
                },
              ),
              _SuggestionChip(
                icon: '🩺',
                label: context.tr('check_symptoms'),
                onTap: () {
                  _textController.text =
                      'I have headache and fever, what could it be?';
                  setState(() {});
                },
              ),
              _SuggestionChip(
                icon: '🔬',
                label: context.tr('lab_results'),
                onTap: () {
                  _textController.text = 'How do I read a CBC blood test?';
                  setState(() {});
                },
              ),
              _SuggestionChip(
                icon: '🏥',
                label: context.tr('emergency_signs'),
                onTap: () {
                  _textController.text =
                      'What are warning signs I should go to ER?';
                  setState(() {});
                },
              ),
            ],
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildMessageList(List<ChatMessage> messages, bool isLoading) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: messages.length,
      itemBuilder: (_, index) {
        final msg = messages[index];
        final showDateDivider = _shouldShowDateDivider(messages, index);

        return Column(
          children: [
            if (showDateDivider) _DateDivider(date: msg.timestamp),
            Align(
              alignment:
                  msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: msg.isUser ? 60 : 12,
                  right: msg.isUser ? 12 : 60,
                  bottom: 4,
                ),
                child: ChatBubble(
                  message: msg,
                  onEdit: msg.isUser ? () => _showEditDialog(msg) : null,
                  onDelete: () => ref
                      .read(chatControllerProvider.notifier)
                      .deleteMessage(msg.id),
                  onAnalyze: !msg.isUser
                      ? () {
                          final msgIndex = messages.indexOf(msg);
                          if (msgIndex > 0 && messages[msgIndex - 1].isUser) {
                            ref
                                .read(chatControllerProvider.notifier)
                                .sendMessage(messages[msgIndex - 1].text);
                          }
                        }
                      : null,
                ).animate().fadeIn(
                      duration: 300.ms,
                    ).slideY(begin: 0.1, end: 0),
              ),
            ),
          ],
        );
      },
    );
  }

  // ── Loading Scaffold ───────────────────────────────────────────────────────

  Widget _buildLoadingScaffold() {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr('loading'),
          style: TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 3,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.tr('loading_conversation'),
              style: TextStyle(
                color: AppColors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Error Scaffold ─────────────────────────────────────────────────────────

  Widget _buildErrorScaffold(String error) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(context.tr('error')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: AppColors.errorRed, size: 64),
              const SizedBox(height: 16),
              Text(
                context.tr('something_went_wrong_please_try_again_later'),
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () =>
                    ref.invalidate(chatControllerProvider),
                icon: const Icon(Icons.refresh),
                label: Text(context.tr('retry')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldShowDateDivider(List<ChatMessage> messages, int index) {
    if (index == 0) return true;
    final curr = messages[index].timestamp;
    final prev = messages[index - 1].timestamp;
    return curr.day != prev.day ||
        curr.month != prev.month ||
        curr.year != prev.year;
  }
}

// ─── OCR Processing Banner ─────────────────────────────────────────────────────

class _OcrProcessingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.metricOrange,
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.metricOrangeIcon,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            context.tr('extracting_text_ocr'),
            style: TextStyle(
              color: AppColors.metricOrangeIcon,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Date Divider ─────────────────────────────────────────────────────────────

class _DateDivider extends StatelessWidget {
  final DateTime date;
  const _DateDivider({required this.date});

  String _formatDate(BuildContext context) {
    final now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) return context.tr('today');
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.day == yesterday.day &&
        date.month == yesterday.month &&
        date.year == yesterday.year) return context.tr('yesterday');
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.authInputBorder)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
_formatDate(context),
              style: TextStyle(
                fontSize: 12,
                color: AppColors.authHint,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Divider(color: AppColors.authInputBorder)),
        ],
      ),
    );
  }
}

// ─── Suggestion Chip ──────────────────────────────────────────────────────────

class _SuggestionChip extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _SuggestionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryBg),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.secondPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
