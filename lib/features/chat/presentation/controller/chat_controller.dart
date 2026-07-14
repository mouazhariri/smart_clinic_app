// import 'dart:async';
// import 'dart:typed_data';

// import 'package:smart_clinic_app/features/chat/Domain/chat_message.dart';
// import 'package:smart_clinic_app/src/core/ai_services/gemini_service.dart';
// import 'package:smart_clinic_app/src/infrastructure/network/services/dio_client.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:uuid/uuid.dart';

// part 'chat_controller.g.dart';

// // ─── State ────────────────────────────────────────────────────────────────────

// class ChatState {
//   final List<ChatMessage> messages;
//   final bool isLoading;
//   final bool canSend;
//   final List<String> imageResults;
//   final bool isLoadingImages;

//   const ChatState({
//     required this.messages,
//     required this.isLoading,
//     required this.canSend,
//     this.imageResults = const [],
//     this.isLoadingImages = false,
//   });

//   factory ChatState.initial() {
//     return const ChatState(
//       messages: [],
//       isLoading: false,
//       canSend: true,
//     );
//   }

//   ChatState copyWith({
//     List<ChatMessage>? messages,
//     bool? isLoading,
//     bool? canSend,
//     List<String>? imageResults,
//     bool? isLoadingImages,
//   }) {
//     return ChatState(
//       messages: messages ?? this.messages,
//       isLoading: isLoading ?? this.isLoading,
//       canSend: canSend ?? this.canSend,
//       imageResults: imageResults ?? this.imageResults,
//       isLoadingImages: isLoadingImages ?? this.isLoadingImages,
//     );
//   }
// }

// // ─── Provider ─────────────────────────────────────────────────────────────────

// @riverpod
// GeminiService geminiService(Ref ref) {
//   final networkService = ref.watch(networkServiceProvider());
//   return GeminiService(

//     networkService: networkService,
//   );
// }

// // ─── Controller ───────────────────────────────────────────────────────────────

// @riverpod
// class ChatController extends _$ChatController {
//   @override
//   FutureOr<ChatState> build() async {
//     return ChatState.initial();
//   }

//   String? _currentAiMessageId;
//   bool _stopRequested = false;

//   // ── Stop Generation ─────────────────────────────────────────────────────────

//   void stopGeneration() {
//     _stopRequested = true;
//     final current = state.value;
//     if (current == null) return;

//     final messages = [...current.messages];
//     final index = messages.indexWhere((e) => e.id == _currentAiMessageId);
//     if (index != -1) {
//       messages[index] = messages[index].copyWith(isGenerating: false);
//     }

//     state = AsyncData(
//       current.copyWith(messages: messages, isLoading: false, canSend: true),
//     );
//   }

//   // ── Send Text Message ────────────────────────────────────────────────────────

//   Future<void> sendMessage(String text) async {
//     final currentState = state.value ?? ChatState.initial();
//     if (!currentState.canSend) return;

//     final userMessage = ChatMessage(
//       id: const Uuid().v4(),
//       text: text,
//       isUser: true,
//       timestamp: DateTime.now(),
//     );

//     final aiId = const Uuid().v4();
//     _currentAiMessageId = aiId;

//     final aiMessage = ChatMessage(
//       id: aiId,
//       text: '',
//       isUser: false,
//       isGenerating: true,
//       timestamp: DateTime.now(),
//     );

//     state = AsyncData(
//       currentState.copyWith(
//         messages: [...currentState.messages, userMessage, aiMessage],
//         isLoading: true,
//         canSend: false,
//       ),
//     );

//     try {
//       _stopRequested = false;
//       final response =
//           await ref.read(geminiServiceProvider).askDoctor(text);

//       await _streamResponse(aiId: aiId, response: response);
//     } catch (e) {
//       _handleError(currentState);
//     }
//   }

//   // ── Send File for Analysis ───────────────────────────────────────────────────

//   Future<void> sendFileForAnalysis({
//     required Uint8List fileBytes,
//     required String mimeType,
//     required String fileName,
//     required AttachmentType attachmentType,
//     String? userContext,
//   }) async {
//     final currentState = state.value ?? ChatState.initial();
//     if (!currentState.canSend) return;

//     // User file message
//     final userMessage = ChatMessage(
//       id: const Uuid().v4(),
//       text: userContext?.isNotEmpty == true
//           ? userContext!
//           : 'Please analyze this file: $fileName',
//       isUser: true,
//       timestamp: DateTime.now(),
//       messageType: attachmentType == AttachmentType.receipt
//           ? MessageType.receipt
//           : MessageType.file,
//       attachedFile: AttachedFile(
//         name: fileName,
//         path: '',
//         type: attachmentType,
//         bytes: fileBytes,
//         mimeType: mimeType,
//       ),
//     );

//     final aiId = const Uuid().v4();
//     _currentAiMessageId = aiId;

//     final aiMessage = ChatMessage(
//       id: aiId,
//       text: '',
//       isUser: false,
//       isGenerating: true,
//       timestamp: DateTime.now(),
//     );

//     state = AsyncData(
//       currentState.copyWith(
//         messages: [...currentState.messages, userMessage, aiMessage],
//         isLoading: true,
//         canSend: false,
//       ),
//     );

//     try {
//       _stopRequested = false;

//       String response;
//       if (attachmentType == AttachmentType.receipt) {
//         response = await ref.read(geminiServiceProvider).analyzeReceipt(
//               imageBytes: fileBytes,
//               userContext: userContext,
//             );
//       } else {
//         response = await ref.read(geminiServiceProvider).analyzeFile(
//               fileBytes: fileBytes,
//               mimeType: mimeType,
//               fileName: fileName,
//               userContext: userContext,
//             );
//       }

//       await _streamResponse(aiId: aiId, response: response);
//     } catch (e) {
//       _handleError(currentState);
//     }
//   }

//   // ── Search & Send Images ─────────────────────────────────────────────────────

//   Future<void> searchAndSendImages(String prompt) async {
//     final currentState = state.value ?? ChatState.initial();
//     if (!currentState.canSend) return;

//     final userMessage = ChatMessage(
//       id: const Uuid().v4(),
//       text: '🔍 Searching medical images for: $prompt',
//       isUser: true,
//       timestamp: DateTime.now(),
//     );

//     final aiId = const Uuid().v4();
//     _currentAiMessageId = aiId;

//     final loadingMessage = ChatMessage(
//       id: aiId,
//       text: '',
//       isUser: false,
//       isGenerating: true,
//       timestamp: DateTime.now(),
//     );

//     state = AsyncData(
//       currentState.copyWith(
//         messages: [...currentState.messages, userMessage, loadingMessage],
//         isLoading: true,
//         canSend: false,
//       ),
//     );

//     try {
//       final images =
//           await ref.read(geminiServiceProvider).searchAiImages(prompt);

//       final current = state.value ?? ChatState.initial();
//       final messages = [...current.messages];
//       final index = messages.indexWhere((e) => e.id == aiId);

//       if (index != -1) {
//         messages[index] = messages[index].copyWith(
//           text: images.isEmpty
//               ? 'No images found for "$prompt". Try a different search term.'
//               : 'Here are medical images related to **$prompt**:',
//           isGenerating: false,
//           imageUrls: images,
//           messageType: MessageType.image,
//         );
//       }

//       state = AsyncData(
//         current.copyWith(
//           messages: messages,
//           isLoading: false,
//           canSend: true,
//         ),
//       );
//     } catch (e) {
//       _handleError(currentState);
//     }
//   }

//   // ── Edit Message ─────────────────────────────────────────────────────────────

//   Future<void> editMessage({
//     required String messageId,
//     required String newText,
//   }) async {
//     final current = state.value;
//     if (current == null) return;

//     final messages = [...current.messages];
//     final index = messages.indexWhere((e) => e.id == messageId);
//     if (index == -1) return;

//     messages[index] = messages[index].copyWith(
//       text: newText,
//       isEdited: true,
//     );

//     // Remove all subsequent messages
//     final trimmed = messages.sublist(0, index + 1);

//     state = AsyncData(current.copyWith(messages: trimmed));

//     await sendMessage(newText);
//   }

//   // ── Delete Message ────────────────────────────────────────────────────────────

//   void deleteMessage(String messageId) {
//     final current = state.value;
//     if (current == null) return;

//     final messages = current.messages
//         .where((e) => e.id != messageId)
//         .toList();

//     state = AsyncData(current.copyWith(messages: messages));
//   }

//   // ── Clear Chat ────────────────────────────────────────────────────────────────

//   void clearChat() {
//     state = AsyncData(ChatState.initial());
//   }

//   // ── Private Helpers ───────────────────────────────────────────────────────────

//   Future<void> _streamResponse({
//     required String aiId,
//     required String response,
//   }) async {
//     for (int i = 0; i < response.length; i++) {
//       if (_stopRequested) {
//         _currentAiMessageId = null;
//         return;
//       }

//       await Future.delayed(const Duration(milliseconds: 10));

//       if (i % 5 != 0 && i != response.length - 1) continue;

//       final current = state.value ?? ChatState.initial();
//       final messages = [...current.messages];
//       final index = messages.indexWhere((e) => e.id == aiId);
//       if (index == -1) return;

//       messages[index] = messages[index].copyWith(
//         text: response.substring(0, i + 1),
//       );

//       state = AsyncData(current.copyWith(messages: messages));
//     }

//     final current = state.value ?? ChatState.initial();
//     final messages = [...current.messages];
//     final index = messages.indexWhere((e) => e.id == aiId);

//     if (index != -1) {
//       messages[index] = messages[index].copyWith(isGenerating: false);
//     }

//     state = AsyncData(
//       current.copyWith(messages: messages, isLoading: false, canSend: true),
//     );
//   }

//   void _handleError(ChatState previousState) {
//     state = AsyncData(
//       previousState.copyWith(
//         messages: [
//           ...previousState.messages,
//           ChatMessage(
//             id: const Uuid().v4(),
//             text: '⚠️ AI service is busy. Please try again.',
//             isUser: false,
//             timestamp: DateTime.now(),
//           ),
//         ],
//         isLoading: false,
//         canSend: true,
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_clinic_app/features/chat/data/chat_storage_service.dart';
import 'package:smart_clinic_app/features/chat/data/ocr_service.dart';
import 'package:smart_clinic_app/features/chat/domain/chat_message.dart';
import 'package:smart_clinic_app/features/chat/domain/chat_session.dart';
import 'package:smart_clinic_app/src/core/ai_services/gemini_service.dart';
import 'package:smart_clinic_app/src/infrastructure/network/services/dio_client.dart';
import 'package:smart_clinic_app/src/logger/log_services/dev_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'chat_controller.g.dart';

// ─── Service Providers ─────────────────────────────────────────────────────────

@riverpod
ChatStorageService chatStorageService(Ref ref) {
  return ChatStorageService();
}

@riverpod
OcrService ocrService(Ref ref) {
  final service = OcrService();
  ref.onDispose(service.dispose);
  return service;
}

@riverpod
GeminiService geminiService(Ref ref) {
  final networkService = ref.watch(networkServiceProvider());
  return GeminiService(networkService: networkService);
}

// ─── Sessions List Provider ───────────────────────────────────────────────────

@riverpod
class SessionsController extends _$SessionsController {
  @override
  Future<List<ChatSession>> build() async {
    final storage = ref.watch(chatStorageServiceProvider);
    return storage.getAllSessions();
  }

  Future<ChatSession> createNewSession() async {
    final storage = ref.read(chatStorageServiceProvider);
    final session = storage.createSessionInMemory();
    ref.invalidateSelf();
    return session;
  }

  Future<void> deleteSession(String id) async {
    final storage = ref.read(chatStorageServiceProvider);
    await storage.deleteSession(id);
    ref.invalidateSelf();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

// ─── Active Session Provider ──────────────────────────────────────────────────

final activeSessionIdProvider = Provider<String?>((ref) => null);

// ─── Chat State ───────────────────────────────────────────────────────────────

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool canSend;
  final String? sessionId;
  final String sessionTitle;
  final bool isOcrProcessing;

  const ChatState({
    required this.messages,
    required this.isLoading,
    required this.canSend,
    this.sessionId,
    this.sessionTitle = 'New Conversation',
    this.isOcrProcessing = false,
  });

  factory ChatState.initial() =>
      const ChatState(messages: [], isLoading: false, canSend: true);

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? canSend,
    String? sessionId,
    String? sessionTitle,
    bool? isOcrProcessing,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      canSend: canSend ?? this.canSend,
      sessionId: sessionId ?? this.sessionId,
      sessionTitle: sessionTitle ?? this.sessionTitle,
      isOcrProcessing: isOcrProcessing ?? this.isOcrProcessing,
    );
  }
}

// ─── Chat Controller ──────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class ChatController extends _$ChatController {
  @override
  FutureOr<ChatState> build() async {
    // Initialize storage
    // await ref.read(chatStorageServiceProvider).init();
    return ChatState.initial();
  }

  String? _currentAiMessageId;
  bool _stopRequested = false;

  // Conversation history for context
  List<Map<String, String>> get _conversationHistory {
    final messages = state.value?.messages ?? [];
    return messages
        .where((m) => !m.isGenerating && m.text.isNotEmpty)
        .map(
          (m) => {'role': m.isUser ? 'user' : 'assistant', 'content': m.text},
        )
        .toList();
  }

  // ── Load Existing Session ─────────────────────────────────────────────────

  Future<void> loadSession(String sessionId) async {
    Dev.logLine("LOAD SESSION");
    final storage = ref.read(chatStorageServiceProvider);
    final session = storage.getSession(sessionId);

    if (session == null) {
      state = AsyncData(ChatState.initial());
      return;
    }
    // ✅ Filter out any incomplete/generating messages from storage
    final cleanMessages = session.messages
        .where((m) => m.text.isNotEmpty)
        .toList();
    Dev.logList(cleanMessages);

    state = AsyncData(
      ChatState(
        messages: cleanMessages,
        isLoading: false,
        canSend: true,
        sessionId: session.id,
        sessionTitle: session.title,
      ),
    );
  }

  // ── Start New Session ─────────────────────────────────────────────────────

  Future<void> startNewSession() async {
    final storage = ref.read(chatStorageServiceProvider);
    final session = storage.createSessionInMemory();

    state = AsyncData(
      ChatState(
        messages: [],
        isLoading: false,
        canSend: true,
        sessionId: session.id,
        sessionTitle: session.title,
      ),
    );
  }

  // ── Save Current Session ──────────────────────────────────────────────────

  Future<void> _saveCurrentSession(List<ChatMessage> messages) async {
    final current = state.value;
    if (current == null) return;
    if (messages.isEmpty) return;

    final storage = ref.read(chatStorageServiceProvider);
    String sessionId = current.sessionId ?? '';

    if (sessionId.isEmpty) {
      final session = storage.createSessionInMemory();
      sessionId = session.id;

      state = AsyncData(current.copyWith(sessionId: sessionId));
    }

    // Filter out generating messages before saving
    final toSave = messages
        .where((m) => !m.isGenerating || m.text.isNotEmpty)
        .map((m) => m.isGenerating ? m.copyWith(isGenerating: false) : m)
        .toList();

    await storage.updateSessionMessages(sessionId, toSave);

    // Auto-generate title if needed
    if (current.sessionTitle == 'New Conversation' && messages.isNotEmpty) {
      final firstUser = messages.firstWhere(
        (m) => m.isUser,
        orElse: () => messages.first,
      );
      final title = await ref
          .read(geminiServiceProvider)
          .generateSessionTitle(firstUser.text);

      state = AsyncData(state.value!.copyWith(sessionTitle: title));
      await storage.saveSession(
        storage.getSession(sessionId)!.copyWith(title: title),
      );
    }

    // Refresh sessions list
    ref.invalidate(sessionsControllerProvider);
  }

  // ── Stop Generation ───────────────────────────────────────────────────────

  void stopGeneration() {
    _stopRequested = true;
    final current = state.value;
    if (current == null) return;

    final messages = [...current.messages];
    final index = messages.indexWhere((e) => e.id == _currentAiMessageId);
    if (index != -1) {
      messages[index] = messages[index].copyWith(isGenerating: false);
    }

    state = AsyncData(
      current.copyWith(messages: messages, isLoading: false, canSend: true),
    );
    _saveCurrentSession(messages);
  }

  // ── Send Text Message ─────────────────────────────────────────────────────

  Future<void> sendMessage(String text) async {
    final currentState = state.value ?? ChatState.initial();
    if (!currentState.canSend) return;

    final userMessage = ChatMessage.create(
      id: const Uuid().v4(),
      text: text,
      isUser: true,
    );

    final aiId = const Uuid().v4();
    _currentAiMessageId = aiId;

    final aiMessage = ChatMessage.create(
      id: aiId,
      text: '',
      isUser: false,
      isGenerating: true,
    );

    final newMessages = [...currentState.messages, userMessage, aiMessage];

    state = AsyncData(
      currentState.copyWith(
        messages: newMessages,
        isLoading: true,
        canSend: false,
      ),
    );

    try {
      _stopRequested = false;

      // Build RAG context from past conversations
      final ragContext = ref
          .read(chatStorageServiceProvider)
          .buildRagContext(text);

      final response = await ref
          .read(geminiServiceProvider)
          .askDoctor(
            text,
            ragContext: ragContext.isNotEmpty ? ragContext : null,
            conversationHistory: _conversationHistory,
          );

      await _streamResponse(aiId: aiId, response: response);
    } catch (e) {
      _handleError(currentState);
    }
  }

  // ── Send File for Analysis ────────────────────────────────────────────────

  Future<void> sendFileForAnalysis({
    required Uint8List fileBytes,
    required String mimeType,
    required String fileName,
    required AttachmentType attachmentType,
    String? userContext,
  }) async {
    final currentState = state.value ?? ChatState.initial();
    if (!currentState.canSend) return;

    // ── OCR Processing ──────────────────────────────────────────────────────
    state = AsyncData(currentState.copyWith(isOcrProcessing: true));

    String? ocrText;
    try {
      if (mimeType.startsWith('image/')) {
        ocrText = await ref
            .read(ocrServiceProvider)
            .extractTextFromBytes(fileBytes);
      }
    } catch (_) {}

    state = AsyncData(currentState.copyWith(isOcrProcessing: false));

    // ── Build User Message ──────────────────────────────────────────────────
    final userMessage = ChatMessage.create(
      id: const Uuid().v4(),
      text: userContext?.isNotEmpty == true
          ? userContext!
          : 'Please analyze this: $fileName',
      isUser: true,

      messageType: attachmentType == AttachmentType.receipt
          ? MessageType.receipt
          : MessageType.file,
      attachedFile: AttachedFile.create(
        name: fileName,
        path: '',
        type: attachmentType,
        bytes: fileBytes,
        mimeType: mimeType,
      ),
      extractedText: ocrText,
    );

    final aiId = const Uuid().v4();
    _currentAiMessageId = aiId;

    final aiMessage = ChatMessage.create(
      id: aiId,
      text: '',
      isUser: false,
      isGenerating: true,
    );

    final newMessages = [...currentState.messages, userMessage, aiMessage];

    state = AsyncData(
      currentState.copyWith(
        messages: newMessages,
        isLoading: true,
        canSend: false,
      ),
    );

    try {
      _stopRequested = false;

      final ragContext = ref
          .read(chatStorageServiceProvider)
          .buildRagContext(userContext ?? fileName);

      String response;
      if (attachmentType == AttachmentType.receipt) {
        response = await ref
            .read(geminiServiceProvider)
            .analyzeReceipt(
              imageBytes: fileBytes,
              userContext: userContext,
              ocrText: ocrText,
              ragContext: ragContext.isNotEmpty ? ragContext : null,
            );
      } else {
        response = await ref
            .read(geminiServiceProvider)
            .analyzeFile(
              fileBytes: fileBytes,
              mimeType: mimeType,
              fileName: fileName,
              userContext: userContext,
              ocrText: ocrText,
              ragContext: ragContext.isNotEmpty ? ragContext : null,
            );
      }

      await _streamResponse(aiId: aiId, response: response);
    } catch (e) {
      _handleError(currentState);
    }
  }

  // ── Search & Send Images ──────────────────────────────────────────────────

  Future<void> searchAndSendImages(String prompt) async {
    final currentState = state.value ?? ChatState.initial();
    if (!currentState.canSend) return;

    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      text: '🔍 Searching medical images for: **$prompt**',
      isUser: true,
      timestamp: DateTime.now(),
    );

    final aiId = const Uuid().v4();
    _currentAiMessageId = aiId;

    final loadingMessage = ChatMessage.create(
      id: aiId,
      text: '',
      isUser: false,
      isGenerating: true,

      // timestamp: DateTime.now(),
    );

    state = AsyncData(
      currentState.copyWith(
        messages: [...currentState.messages, userMessage, loadingMessage],
        isLoading: true,
        canSend: false,
      ),
    );

    try {
      final images = await ref
          .read(geminiServiceProvider)
          .searchAiImages(prompt);

      final current = state.value ?? ChatState.initial();
      final messages = [...current.messages];
      final index = messages.indexWhere((e) => e.id == aiId);

      if (index != -1) {
        messages[index] = messages[index].copyWith(
          text: images.isEmpty
              ? 'No images found for **"$prompt"**. Try a different search term.'
              : '## Medical Images: $prompt\n\nFound ${images.length} results:',
          isGenerating: false,
          imageUrls: images,
          messageTypeIndex: MessageType.image.index,
        );
      }

      state = AsyncData(
        current.copyWith(messages: messages, isLoading: false, canSend: true),
      );

      await _saveCurrentSession(messages);
    } catch (e) {
      _handleError(currentState);
    }
  }

  // ── Edit Message ──────────────────────────────────────────────────────────

  Future<void> editMessage({
    required String messageId,
    required String newText,
  }) async {
    final current = state.value;
    if (current == null) return;

    final messages = [...current.messages];
    final index = messages.indexWhere((e) => e.id == messageId);
    if (index == -1) return;

    // Mark as edited and trim subsequent messages
    messages[index] = messages[index].copyWith(text: newText, isEdited: true);

    final trimmed = messages.sublist(0, index + 1);
    state = AsyncData(current.copyWith(messages: trimmed, canSend: true));

    await sendMessage(newText);
  }

  // ── Delete Message ────────────────────────────────────────────────────────

  void deleteMessage(String messageId) {
    final current = state.value;
    if (current == null) return;

    final messages = current.messages.where((e) => e.id != messageId).toList();

    state = AsyncData(current.copyWith(messages: messages));
    _saveCurrentSession(messages);
  }

  // ── Clear Chat ────────────────────────────────────────────────────────────

  Future<void> clearChat() async {
    final current = state.value;
    final sessionId = current?.sessionId;

    if (sessionId != null) {
      await ref.read(chatStorageServiceProvider).deleteSession(sessionId);
      ref.invalidate(sessionsControllerProvider);
    }

    state = AsyncData(ChatState.initial());
  }

  // ── Private Helpers ───────────────────────────────────────────────────────

  Future<void> _streamResponse({
    required String aiId,
    required String response,
  }) async {
    for (int i = 0; i < response.length; i++) {
      if (_stopRequested) {
        _currentAiMessageId = null;
        return;
      }

      await Future.delayed(const Duration(milliseconds: 8));
      if (i % 4 != 0 && i != response.length - 1) continue;

      final current = state.value ?? ChatState.initial();
      final messages = [...current.messages];
      final index = messages.indexWhere((e) => e.id == aiId);
      if (index == -1) return;

      messages[index] = messages[index].copyWith(
        text: response.substring(0, i + 1),
      );

      state = AsyncData(current.copyWith(messages: messages));
    }

    final current = state.value ?? ChatState.initial();
    final messages = [...current.messages];
    final index = messages.indexWhere((e) => e.id == aiId);

    if (index != -1) {
      messages[index] = messages[index].copyWith(isGenerating: false);
    }

    state = AsyncData(
      current.copyWith(messages: messages, isLoading: false, canSend: true),
    );

    await _saveCurrentSession(messages);
  }

  void _handleError(ChatState previousState) {
    final errorMessage = ChatMessage.create(
      id: const Uuid().v4(),
      text: '⚠️ Something went wrong. Please try again.',
      isUser: false,
    );

    state = AsyncData(
      previousState.copyWith(
        messages: [...previousState.messages, errorMessage],
        isLoading: false,
        canSend: true,
      ),
    );
  }
}
