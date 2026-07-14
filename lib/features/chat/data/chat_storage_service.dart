import 'package:hive/hive.dart';
import 'package:smart_clinic_app/src/infrastructure/storage/hive/hive_boxes.dart';
import 'package:uuid/uuid.dart';

import '../domain/chat_message.dart';
import '../domain/chat_session.dart';

class ChatStorageService {
  Box<ChatSession> get _box =>
      Hive.box<ChatSession>(HiveBoxesName.chatSessionsBox);

  // ── Sessions CRUD ──────────────────────────────────────────────────────────

  List<ChatSession> getAllSessions() {
    final sessions = _box.values.toList();
    // ✅ Filter out empty sessions on read too
    sessions.removeWhere((s) => s.messages.isEmpty);
    sessions.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return sessions;
  }

  ChatSession? getSession(String id) => _box.get(id);

  /// ✅ Only creates in memory — does NOT save to Hive yet
  ChatSession createSessionInMemory({String? title}) {
    final id = const Uuid().v4();
    return ChatSession(
      id: id,
      title: title ?? 'New Conversation',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      messages: [],
    );
  }

  /// ✅ Only saves when there are actual messages
  Future<void> saveSessionIfNotEmpty(ChatSession session) async {
    if (session.messages.isEmpty) return; // ← key fix
    await _box.put(session.id, session);
  }

  Future<void> saveSession(ChatSession session) async {
    await _box.put(session.id, session);
  }

  /// ✅ Save messages — skip if empty, delete if cleared
  Future<void> updateSessionMessages(
    String sessionId,
    List<ChatMessage> messages, {
    String? currentTitle,
  }) async {
    // ✅ If no messages — delete the session entirely
    if (messages.isEmpty) {
      await _box.delete(sessionId);
      return;
    }

    // Auto-generate title from first user message
    String title = currentTitle ?? 'New Conversation';
    if (title == 'New Conversation' && messages.isNotEmpty) {
      final firstUserMsg = messages.firstWhere(
        (m) => m.isUser && m.text.isNotEmpty,
        orElse: () => messages.first,
      );
      final text = firstUserMsg.text;
      title = text.length > 40 ? '${text.substring(0, 40)}...' : text;
    }

    // Get existing or create new
    final existing = _box.get(sessionId);
    final session = existing?.copyWith(
          messages: messages,
          updatedAt: DateTime.now(),
          title: title,
        ) ??
        ChatSession(
          id: sessionId,
          title: title,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          messages: messages,
        );

    await _box.put(sessionId, session);
  }

  Future<void> deleteSession(String id) async {
    await _box.delete(id);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  // ── RAG: Search across sessions ───────────────────────────────────────────

  List<ChatMessage> searchMessages(String query) {
    final results = <ChatMessage>[];
    final queryLower = query.toLowerCase();

    for (final session in _box.values) {
      for (final msg in session.messages) {
        if (msg.text.toLowerCase().contains(queryLower) ||
            (msg.extractedText?.toLowerCase().contains(queryLower) ?? false)) {
          results.add(msg);
        }
      }
    }
    return results;
  }

  String buildRagContext(String currentQuery) {
    final relevantMessages = searchMessages(currentQuery);
    if (relevantMessages.isEmpty) return '';

    final buffer = StringBuffer();
    buffer.writeln('=== Relevant Past Medical Context ===');
    final topMessages = relevantMessages.take(5).toList();
    for (final msg in topMessages) {
      final role = msg.isUser ? 'Patient' : 'Doctor AI';
      buffer.writeln('$role: ${msg.text}');
      if (msg.extractedText != null) {
        buffer.writeln('Extracted: ${msg.extractedText}');
      }
    }
    buffer.writeln('=== End of Context ===');
    return buffer.toString();
  }
}