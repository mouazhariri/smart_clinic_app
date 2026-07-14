
// import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:smart_clinic_app/features/chat/Domain/chat_message.dart';
// import 'package:smart_clinic_app/features/chat/domain/chat_message.dart' hide FileType, AttachmentType;
// import 'package:smart_clinic_app/features/chat/presentation/controller/chat_controller.dart';
// import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
// import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class ChatInputBar extends ConsumerStatefulWidget {
//   final TextEditingController textController;
//   final bool isLoading;
//   final bool canSend;
//   final VoidCallback onSend;
//   final VoidCallback onStop;

//   const ChatInputBar({
//     super.key,
//     required this.textController,
//     required this.isLoading,
//     required this.canSend,
//     required this.onSend,
//     required this.onStop,
//   });

//   @override
//   ConsumerState<ChatInputBar> createState() => _ChatInputBarState();
// }

// class _ChatInputBarState extends ConsumerState<ChatInputBar> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool _isListening = false;
//   bool _speechAvailable = false;
//   bool _showImageSearch = false;
//   final TextEditingController _imageSearchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   Future<void> _initSpeech() async {
//     _speechAvailable = await _speechToText.initialize();
//     setState(() {});
//   }

//   Future<void> _toggleListening() async {
//     if (!_speechAvailable) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Speech recognition not available')),
//       );
//       return;
//     }

//     if (_isListening) {
//       await _speechToText.stop();
//       setState(() => _isListening = false);
//     } else {
//       setState(() => _isListening = true);
//       await _speechToText.listen(
//         onResult: (result) {
//           widget.textController.text = result.recognizedWords;
//           if (result.finalResult) {
//             setState(() => _isListening = false);
//           }
//         },
//         listenFor: const Duration(seconds: 60),
//         localeId: 'en_US',
//         cancelOnError: true,
//         partialResults: true,
//       );
//     }
//   }

//   Future<void> _pickPDF() async {
//     try {
//       final result = await FilePicker.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//         withData: true,
//       );

//       if (result == null || result.files.isEmpty) return;

//       final file = result.files.first;
//       if (file.bytes == null) return;

//       await _showContextDialog(
//         fileName: file.name,
//         fileBytes: file.bytes!,
//         mimeType: 'application/pdf',
//         fileType: FileType2.pdf,
//       );
//     } catch (e) {
//       _showError('Failed to pick PDF file');
//     }
//   }

//   Future<void> _pickReceipt() async {
//     try {
//       final picker = ImagePicker();
//       final result = await showModalBottomSheet<XFile?>(
//         context: context,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         builder: (_) => _ReceiptSourcePicker(picker: picker),
//       );

//       if (result == null) return;
//       final bytes = await result.readAsBytes();

//       await _showContextDialog(
//         fileName: result.name,
//         fileBytes: bytes,
//         mimeType: 'image/jpeg',
//         fileType: FileType2.receipt,
//       );
//     } catch (e) {
//       _showError('Failed to pick receipt image');
//     }
//   }

//   Future<void> _pickMedicalImage() async {
//     try {
//       final picker = ImagePicker();
//       final result = await picker.pickImage(source: ImageSource.gallery);
//       if (result == null) return;

//       final bytes = await result.readAsBytes();

//       await _showContextDialog(
//         fileName: result.name,
//         fileBytes: bytes,
//         mimeType: 'image/jpeg',
//         fileType: FileType2.image,
//       );
//     } catch (e) {
//       _showError('Failed to pick image');
//     }
//   }

//   Future<void> _showContextDialog({
//     required String fileName,
//     required Uint8List fileBytes,
//     required String mimeType,
//     required FileType2 fileType,
//   }) async {
//     final contextController = TextEditingController();

//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(
//           children: [
//             Icon(
//               fileType == FileType2.receipt
//                   ? Icons.receipt_long
//                   : fileType == FileType2.pdf
//                       ? Icons.picture_as_pdf
//                       : Icons.image_outlined,
//               color: Colors.blue,
//             ),
//             const SizedBox(width: 8),
//             Flexible(
//               child: Text(
//                 fileName,
//                 style: const TextStyle(fontSize: 16),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Add a note (optional):',
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: contextController,
//               maxLines: 3,
//               decoration: InputDecoration(
//                 hintText: fileType == FileType2.receipt
//                     ? 'e.g. What medications are prescribed?'
//                     : 'e.g. Summarize the key findings...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 contentPadding: const EdgeInsets.all(12),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('Cancel'),
//           ),
//           FilledButton.icon(
//             onPressed: () => Navigator.pop(context, true),
//             icon: const Icon(Icons.send, size: 16),
//             label: const Text('Analyze'),
//           ),
//         ],
//       ),
//     );

//     if (confirmed != true) return;

//     if (!mounted) return;

//     ref.read(chatControllerProvider.notifier).sendFileForAnalysis(
//           fileBytes: fileBytes,
//           mimeType: mimeType,
//           fileName: fileName,
//           attachmentType: _mapFileType(fileType),
//           userContext: contextController.text.trim(),
//         );
//   }

//   AttachmentType _mapFileType(FileType2 type) {
//     switch (type) {
//       case FileType2.pdf:
//         return AttachmentType.pdf;
//       case FileType2.receipt:
//         return AttachmentType.receipt;
//       case FileType2.image:
//         return AttachmentType.image;
//     }
//   }

//   void _showAttachmentOptions() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (_) => _AttachmentOptionsSheet(
//         onPickPDF: () {
//           Navigator.pop(context);
//           _pickPDF();
//         },
//         onPickReceipt: () {
//           Navigator.pop(context);
//           _pickReceipt();
//         },
//         onPickImage: () {
//           Navigator.pop(context);
//           _pickMedicalImage();
//         },
//         onSearchImages: () {
//           Navigator.pop(context);
//           setState(() => _showImageSearch = true);
//         },
//       ),
//     );
//   }

//   void _showError(String message) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _imageSearchController.dispose();
//     _speechToText.stop();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Image search bar
//               if (_showImageSearch)
//                 _ImageSearchBar(
//                   controller: _imageSearchController,
//                   onSearch: (query) {
//                     setState(() => _showImageSearch = false);
//                     ref
//                         .read(chatControllerProvider.notifier)
//                         .searchAndSendImages(query);
//                   },
//                   onClose: () => setState(() => _showImageSearch = false),
//                 ),

//               // Listening indicator
//               if (_isListening)
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 8),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.red.shade200),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.mic, color: Colors.red.shade400, size: 16),
//                       const SizedBox(width: 6),
//                       Text(
//                         'Listening...',
//                         style: TextStyle(
//                           color: Colors.red.shade400,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//               // Input row
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   // Attachment button
//                   _CircleIconButton(
//                     icon: Icons.attach_file,
//                     color: Colors.grey.shade600,
//                     onTap: widget.isLoading ? null : _showAttachmentOptions,
//                   ),

//                   const SizedBox(width: 8),

//                   // Text field
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: _isListening
//                               ? Colors.red.shade300
//                               : Colors.grey.shade300,
//                         ),
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Expanded(
                    //         child: TextField(
                    //           onChanged: (value) => {
                    //   setState(() {
                    //     widget.textController.text = value;
                    //   }),
                    // },
                    //           controller: widget.textController,
                    //           maxLines: 5,
                    //           minLines: 1,
                    //           style: const TextStyle(
                    //             fontFamily: 'Cairo',
                    //             fontSize: 15,
                    //           ),
                    //           textDirection: Directionality.of(context),
                    //           decoration: InputDecoration(
                    //             hintText: _isListening
                    //                 ? 'Speak now...'
                    //                 : 'Ask anything medical...',
                    //             hintStyle: TextStyle(
                    //               color: Colors.grey.shade400,
                    //               fontSize: 14,
                    //             ),
                    //             // border: InputBorder.none,
                    //              enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //     borderSide: const BorderSide(
                    //       color: AppColors.navBorder,
                    //     ),
                    //   ),
                    //   border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //     borderSide: const BorderSide(
                    //       color: AppColors.navBorder,
                    //     ),
                    //   ),
                    //   focusedBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //     borderSide: const BorderSide(color: AppColors.primary),
                    //   ),

                    //             contentPadding: const EdgeInsets.symmetric(
                    //               horizontal: 16,
                    //               vertical: 12,
                    //             ),
                    //           ),
                    //         ),
                    //       ),

//                           // Mic button
//                           _CircleIconButton(
//                             icon: _isListening ? Icons.mic : Icons.mic_none,
//                             color: _isListening
//                                 ? Colors.red
//                                 : Colors.grey.shade500,
//                             onTap: _toggleListening,
//                           ),
//                           const SizedBox(width: 4),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 8),

//                   // Send / Stop button
//                   AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 200),
//                     child: widget.isLoading
//                         ? _CircleIconButton(
//                             key: const ValueKey('stop'),
//                             icon: Icons.stop_rounded,
//                             color: Colors.white,
//                             backgroundColor: Colors.red,
//                             onTap: widget.onStop,
//                           )
//                         : _CircleIconButton(
//                             key: const ValueKey('send'),
//                             icon: Icons.send_rounded,
//                             color: Colors.white,
//                             backgroundColor:
//                                 widget.canSend &&
//                                         widget.textController.text.isNotEmpty
//                                     ? AppColors.primary
//                                     : Colors.grey.shade300,
//                             onTap: widget.canSend &&
//                                     widget.textController.text.isNotEmpty
//                                 ? widget.onSend
//                                 : null,
//                           ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ─── Image Search Bar ─────────────────────────────────────────────────────────

// class _ImageSearchBar extends StatelessWidget {
//   final TextEditingController controller;
//   final ValueChanged<String> onSearch;
//   final VoidCallback onClose;

//   const _ImageSearchBar({
//     required this.controller,
//     required this.onSearch,
//     required this.onClose,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.blue.shade200),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.image_search, color: Colors.blue, size: 20),
//           const SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               controller: controller,
//               autofocus: true,
//               decoration: const InputDecoration(
//                 hintText: 'Search medical images...',
//                 border: InputBorder.none,
//                 isDense: true,
//                 contentPadding: EdgeInsets.zero,
//               ),
//               onSubmitted: onSearch,
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.blue),
//             onPressed: () {
//               if (controller.text.isNotEmpty) {
//                 onSearch(controller.text.trim());
//                 controller.clear();
//               }
//             },
//             constraints: const BoxConstraints(),
//             padding: EdgeInsets.zero,
//           ),
//           const SizedBox(width: 4),
//           IconButton(
//             icon: Icon(Icons.close, color: Colors.grey.shade500, size: 18),
//             onPressed: onClose,
//             constraints: const BoxConstraints(),
//             padding: EdgeInsets.zero,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Attachment Options ───────────────────────────────────────────────────────

// class _AttachmentOptionsSheet extends StatelessWidget {
//   final VoidCallback onPickPDF;
//   final VoidCallback onPickReceipt;
//   final VoidCallback onPickImage;
//   final VoidCallback onSearchImages;

//   const _AttachmentOptionsSheet({
//     required this.onPickPDF,
//     required this.onPickReceipt,
//     required this.onPickImage,
//     required this.onSearchImages,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Attach & Analyze',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 16),
//             GridView.count(
//               shrinkWrap: true,
//               crossAxisCount: 4,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               children: [
//                 _AttachOption(
//                   icon: Icons.picture_as_pdf,
//                   label: 'PDF\nReport',
//                   color: Colors.red,
//                   onTap: onPickPDF,
//                 ),
//                 _AttachOption(
//                   icon: Icons.receipt_long,
//                   label: 'Prescription',
//                   color: Colors.green,
//                   onTap: onPickReceipt,
//                 ),
//                 _AttachOption(
//                   icon: Icons.image_outlined,
//                   label: 'Medical\nImage',
//                   color: Colors.orange,
//                   onTap: onPickImage,
//                 ),
//                 _AttachOption(
//                   icon: Icons.image_search,
//                   label: 'Search\nImages',
//                   color: Colors.blue,
//                   onTap: onSearchImages,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _AttachOption extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback onTap;

//   const _AttachOption({
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 56,
//             // height: 56,
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Icon(icon, color: color, size: 26),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Receipt Source Picker ─────────────────────────────────────────────────────

// class _ReceiptSourcePicker extends StatelessWidget {
//   final ImagePicker picker;

//   const _ReceiptSourcePicker({required this.picker});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Capture Prescription',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             ListTile(
//               leading: const Icon(Icons.camera_alt, color: Colors.blue),
//               title: const Text('Take Photo'),
//               onTap: () async {
//                 final img =
//                     await picker.pickImage(source: ImageSource.camera);
//                 if (context.mounted) Navigator.pop(context, img);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library, color: Colors.green),
//               title: const Text('Choose from Gallery'),
//               onTap: () async {
//                 final img =
//                     await picker.pickImage(source: ImageSource.gallery);
//                 if (context.mounted) Navigator.pop(context, img);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─── Helpers ──────────────────────────────────────────────────────────────────

// class _CircleIconButton extends StatelessWidget {
//   final IconData icon;
//   final Color color;
//   final Color? backgroundColor;
//   final VoidCallback? onTap;

//   const _CircleIconButton({
//     super.key,
//     required this.icon,
//     required this.color,
//     this.backgroundColor,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 42,
//         height: 42,
//         decoration: BoxDecoration(
//           color: backgroundColor ?? Colors.transparent,
//           shape: BoxShape.circle,
//         ),
//         child: Icon(icon, color: color, size: 22),
//       ),
//     );
//   }
// }

// // Internal enum to avoid conflicts with file_picker's FileType
// enum FileType2 { pdf, receipt, image }

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_clinic_app/features/chat/domain/chat_message.dart';
import 'package:smart_clinic_app/features/chat/presentation/controller/chat_controller.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatInputBar extends ConsumerStatefulWidget {
  final TextEditingController textController;
  final bool isLoading;
  final bool canSend;
  final VoidCallback onSend;
  final VoidCallback onStop;

  const ChatInputBar({
    super.key,
    required this.textController,
    required this.isLoading,
    required this.canSend,
    required this.onSend,
    required this.onStop,
  });

  @override
  ConsumerState<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends ConsumerState<ChatInputBar>
    with SingleTickerProviderStateMixin {

  // ── Speech to Text ─────────────────────────────────────────────────────────
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechInitialized = false;
  double _soundLevel = 0;
  late AnimationController _micPulseController;

  // ── Image Search ───────────────────────────────────────────────────────────
  bool _showImageSearch = false;
  final _imageSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _micPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _initSpeech();
  }

  @override
  void dispose() {
    _micPulseController.dispose();
    _imageSearchController.dispose();
    if (_isListening) _speech.stop();
    super.dispose();
  }

  // ── Initialize Speech ──────────────────────────────────────────────────────

  Future<void> _initSpeech() async {
    try {
      // Request mic permission first
      final status = await Permission.microphone.request();
      if (!status.isGranted) return;

      final available = await _speech.initialize(
        onError: (error) {
          debugPrint('Speech error: $error');
          if (mounted) setState(() => _isListening = false);
        },
        onStatus: (status) {
          debugPrint('Speech status: $status');
          if (status == 'done' || status == 'notListening') {
            if (mounted) setState(() => _isListening = false);
          }
        },
        debugLogging: false,
      );

      if (mounted) {
        setState(() => _speechInitialized = available);
      }
    } catch (e) {
      debugPrint('Speech init error: $e');
    }
  }

  // ── Toggle Listening ───────────────────────────────────────────────────────

  Future<void> _toggleListening() async {
    if (!_speechInitialized) {
      await _initSpeech();
      if (!_speechInitialized) {
        _showSnackBar('Speech recognition not available on this device', isError: true);
        return;
      }
    }

    if (_isListening) {
      // Stop listening
      await _speech.stop();
      setState(() {
        _isListening = false;
        _soundLevel = 0;
      });
    } else {
      // Start listening
      final available = await _speech.initialize();
      if (!available) {
        _showSnackBar('Could not start speech recognition', isError: true);
        return;
      }

      setState(() => _isListening = true);

      await _speech.listen(
        onResult: (result) {
          if (mounted) {
            setState(() {
              widget.textController.text = result.recognizedWords;
              // Auto-position cursor at end
              widget.textController.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.textController.text.length),
              );
            });
          }
        },
        onSoundLevelChange: (level) {
          if (mounted) setState(() => _soundLevel = level.clamp(0.0, 10.0));
        },
        listenFor: const Duration(minutes: 2),
        pauseFor: const Duration(seconds: 4),
        localeId: 'en_US',
        cancelOnError: false,
        partialResults: true,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  // ── File Pickers ───────────────────────────────────────────────────────────

  Future<void> _pickPDF() async {
    try {
      final result = await fp.FilePicker.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      if (file.bytes == null) return;

      await _showContextDialog(
        fileName: file.name,
        fileBytes: file.bytes!,
        mimeType: 'application/pdf',
        fileType: _FileCategory.pdf,
      );
    } catch (e) {
      _showSnackBar('Failed to pick PDF', isError: true);
    }
  }

  Future<void> _pickReceipt() async {
    try {
      final picker = ImagePicker();
      final source = await _showImageSourceDialog();
      if (source == null) return;

      final image = await picker.pickImage(
        source: source,
        imageQuality: 90,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (image == null) return;

      final bytes = await image.readAsBytes();
      await _showContextDialog(
        fileName: image.name,
        fileBytes: bytes,
        mimeType: 'image/jpeg',
        fileType: _FileCategory.receipt,
      );
    } catch (e) {
      _showSnackBar('Failed to pick image', isError: true);
    }
  }

  Future<void> _pickMedicalImage() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (image == null) return;

      final bytes = await image.readAsBytes();
      await _showContextDialog(
        fileName: image.name,
        fileBytes: bytes,
        mimeType: 'image/jpeg',
        fileType: _FileCategory.image,
      );
    } catch (e) {
      _showSnackBar('Failed to pick image', isError: true);
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Choose Source',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.camera_alt_rounded, color: Colors.blue.shade600),
              ),
              title: const Text('Camera'),
              subtitle: const Text('Take a new photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.photo_library_rounded, color: Colors.green.shade600),
              ),
              title: const Text('Gallery'),
              subtitle: const Text('Choose from photos'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Context Dialog ─────────────────────────────────────────────────────────

  Future<void> _showContextDialog({
    required String fileName,
    required Uint8List fileBytes,
    required String mimeType,
    required _FileCategory fileType,
  }) async {
    final contextController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _getCategoryColor(fileType).withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(fileType).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getCategoryIcon(fileType),
                    color: _getCategoryColor(fileType),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getCategoryTitle(fileType),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        fileName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add context (optional):',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contextController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: _getHintText(fileType),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: _getCategoryColor(fileType)),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome,
                        color: Colors.blue.shade600, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'OCR will extract text automatically for better analysis',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('Cancel',
                  style: TextStyle(color: Colors.grey.shade600)),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.pop(ctx, true),
              style: FilledButton.styleFrom(
                backgroundColor: _getCategoryColor(fileType),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.analytics_rounded, size: 16),
              label: const Text('Analyze'),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !mounted) return;

    ref.read(chatControllerProvider.notifier).sendFileForAnalysis(
          fileBytes: fileBytes,
          mimeType: mimeType,
          fileName: fileName,
          attachmentType: _mapToAttachmentType(fileType),
          userContext: contextController.text.trim(),
        );

    contextController.dispose();
  }

  // ── Attachment Options Sheet ───────────────────────────────────────────────

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _AttachmentSheet(
        onPickPDF: () { Navigator.pop(context); _pickPDF(); },
        onPickReceipt: () { Navigator.pop(context); _pickReceipt(); },
        onPickImage: () { Navigator.pop(context); _pickMedicalImage(); },
        onSearchImages: () {
          Navigator.pop(context);
          setState(() => _showImageSearch = true);
        },
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  AttachmentType _mapToAttachmentType(_FileCategory cat) {
    switch (cat) {
      case _FileCategory.pdf: return AttachmentType.pdf;
      case _FileCategory.receipt: return AttachmentType.receipt;
      case _FileCategory.image: return AttachmentType.image;
    }
  }

  Color _getCategoryColor(_FileCategory cat) {
    switch (cat) {
      case _FileCategory.pdf: return Colors.red.shade600;
      case _FileCategory.receipt: return Colors.green.shade600;
      case _FileCategory.image: return Colors.orange.shade600;
    }
  }

  IconData _getCategoryIcon(_FileCategory cat) {
    switch (cat) {
      case _FileCategory.pdf: return Icons.picture_as_pdf_rounded;
      case _FileCategory.receipt: return Icons.receipt_long_rounded;
      case _FileCategory.image: return Icons.image_rounded;
    }
  }

  String _getCategoryTitle(_FileCategory cat) {
    switch (cat) {
      case _FileCategory.pdf: return 'PDF Report';
      case _FileCategory.receipt: return 'Prescription';
      case _FileCategory.image: return 'Medical Image';
    }
  }

  String _getHintText(_FileCategory cat) {
    switch (cat) {
      case _FileCategory.pdf: return 'e.g. Summarize abnormal values...';
      case _FileCategory.receipt:
        return 'e.g. What are the side effects?';
      case _FileCategory.image: return 'e.g. What does this scan show?';
    }
  }

  void _showSnackBar(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Image Search Bar ────────────────────────────────────────
              if (_showImageSearch)
                _ImageSearchBar(
                  controller: _imageSearchController,
                  onSearch: (query) {
                    setState(() => _showImageSearch = false);
                    _imageSearchController.clear();
                    ref
                        .read(chatControllerProvider.notifier)
                        .searchAndSendImages(query);
                  },
                  onClose: () => setState(() => _showImageSearch = false),
                ),

              // ── Listening Indicator ─────────────────────────────────────
              if (_isListening)
                _ListeningIndicator(
                  soundLevel: _soundLevel,
                  pulseController: _micPulseController,
                  onStop: _toggleListening,
                ),

              // ── Main Input Row ──────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Attach button
                  _InputIconButton(
                    icon: Icons.add_rounded,
                    backgroundColor: Colors.grey.shade100,
                    iconColor: Colors.grey.shade700,
                    onTap: widget.isLoading ? null : _showAttachmentOptions,
                  ),

                  const SizedBox(width: 8),

                  // Text field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isListening
                              ? Colors.red.shade300
                              : Colors.grey.shade200,
                          width: _isListening ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: 

                            TextField(
                              onChanged: (value) => {
                      setState(() {
                        widget.textController.text = value;
                      }),
                    },
                              controller: widget.textController,
                              maxLines: 5,
                              minLines: 1,
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 15,
                              ),
                              textDirection: Directionality.of(context),
                              decoration: InputDecoration(
                                hintText: _isListening
                                    ? 'Speak now...'
                                    : 'Ask anything medical...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                                // border: InputBorder.none,
                                 enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.navBorder,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.navBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),

                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                           
                          

                          // Mic button inside field
                          Padding(
                            padding: const EdgeInsets.only(right: 6, bottom: 6),
                            child: AnimatedBuilder(
                              animation: _micPulseController,
                              builder: (_, child) {
                                return Transform.scale(
                                  scale: _isListening
                                      ? 1.0 + (_micPulseController.value * 0.15)
                                      : 1.0,
                                  child: child,
                                );
                              },
                              child: GestureDetector(
                                onTap: _toggleListening,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: _isListening
                                        ? Colors.red
                                        : Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _isListening
                                        ? Icons.mic_rounded
                                        : Icons.mic_none_rounded,
                                    color: _isListening
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Send / Stop button
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, anim) {
                      return ScaleTransition(scale: anim, child: child);
                    },
                    child: widget.isLoading
                        ? _InputIconButton(
                            key: const ValueKey('stop'),
                            icon: Icons.stop_rounded,
                            backgroundColor: Colors.red,
                            iconColor: Colors.white,
                            onTap: widget.onStop,
                          )
                        : _InputIconButton(
                            key: const ValueKey('send'),
                            icon: Icons.send_rounded,
                            backgroundColor:
                                widget.canSend &&
                                        widget.textController.text.isNotEmpty
                                    ? const Color(0xFF1565C0)
                                    : Colors.grey.shade300,
                            iconColor: Colors.white,
                            onTap: widget.canSend &&
                                    widget.textController.text.isNotEmpty
                                ? widget.onSend
                                : null,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Listening Indicator ──────────────────────────────────────────────────────

class _ListeningIndicator extends StatelessWidget {
  final double soundLevel;
  final AnimationController pulseController;
  final VoidCallback onStop;

  const _ListeningIndicator({
    required this.soundLevel,
    required this.pulseController,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: pulseController,
            builder: (_, __) => Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(
                    0.5 + pulseController.value * 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            '🎤 Listening...',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          // Sound level bars
          Row(
            children: List.generate(5, (i) {
              final active = soundLevel > (i * 2);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                margin: const EdgeInsets.symmetric(horizontal: 1),
                width: 3,
                height: active ? 16.0 - (i * 1.5) : 4,
                decoration: BoxDecoration(
                  color: active
                      ? Colors.red.shade400
                      : Colors.red.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onStop,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Stop',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Image Search Bar ─────────────────────────────────────────────────────────

class _ImageSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  final VoidCallback onClose;

  const _ImageSearchBar({
    required this.controller,
    required this.onSearch,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.image_search_rounded,
              color: Colors.blue.shade600, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search medical images...',
                hintStyle: TextStyle(
                    color: Colors.blue.shade300, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onSubmitted: onSearch,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search_rounded, color: Colors.blue.shade600),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSearch(controller.text.trim());
              }
            },
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(4),
          ),
          IconButton(
            icon: Icon(Icons.close_rounded,
                color: Colors.grey.shade500, size: 18),
            onPressed: onClose,
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(4),
          ),
        ],
      ),
    );
  }
}

// ─── Attachment Sheet ─────────────────────────────────────────────────────────

class _AttachmentSheet extends StatelessWidget {
  final VoidCallback onPickPDF;
  final VoidCallback onPickReceipt;
  final VoidCallback onPickImage;
  final VoidCallback onSearchImages;

  const _AttachmentSheet({
    required this.onPickPDF,
    required this.onPickReceipt,
    required this.onPickImage,
    required this.onSearchImages,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Attach & Analyze',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Choose what to analyze with AI',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _AttachTile(
                  icon: Icons.picture_as_pdf_rounded,
                  label: 'PDF Report',
                  subtitle: 'Lab results, medical reports',
                  color: Colors.red.shade600,
                  onTap: onPickPDF,
                ),
                const SizedBox(width: 12),
                _AttachTile(
                  icon: Icons.receipt_long_rounded,
                  label: 'Prescription',
                  subtitle: 'Medication receipts',
                  color: Colors.green.shade600,
                  onTap: onPickReceipt,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _AttachTile(
                  icon: Icons.image_rounded,
                  label: 'Medical Image',
                  subtitle: 'X-rays, scans, photos',
                  color: Colors.orange.shade600,
                  onTap: onPickImage,
                ),
                const SizedBox(width: 12),
                _AttachTile(
                  icon: Icons.image_search_rounded,
                  label: 'Search Images',
                  subtitle: 'Find medical visuals',
                  color: Colors.blue.shade600,
                  onTap: onSearchImages,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _AttachTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Input Icon Button ─────────────────────────────────────────────────────────

class _InputIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback? onTap;

  const _InputIconButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }
}

// ─── Internal Enum ────────────────────────────────────────────────────────────

enum _FileCategory { pdf, receipt, image }