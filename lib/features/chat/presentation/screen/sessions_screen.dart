import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_clinic_app/features/chat/domain/chat_session.dart';
import 'package:smart_clinic_app/features/chat/presentation/controller/chat_controller.dart';
import 'package:smart_clinic_app/features/chat/presentation/screen/chat_screen.dart';

class SessionsScreen extends ConsumerWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionsControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: _buildAppBar(context, ref),
      body: sessionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (sessions) => sessions.isEmpty
            ? _buildEmptyState(context, ref)
            : _buildSessionsList(context, ref, sessions),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _startNewChat(context, ref),
        backgroundColor: const Color(0xFF1565C0),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Chat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ).animate().scale(delay: 300.ms, duration: 400.ms, curve: Curves.elasticOut),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF1565C0),
      foregroundColor: Colors.white,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.medical_services_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Doctor AI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Medical Assistant',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_sweep_outlined, color: Colors.white70),
          tooltip: 'Clear all chats',
          onPressed: () => _showClearAllDialog(context, ref),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.blue.shade200],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 48,
                color: Colors.blue.shade600,
              ),
            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            const SizedBox(height: 24),
            const Text(
              'No Conversations Yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 12),
            Text(
              'Start a new conversation with your AI medical assistant',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => _startNewChat(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text(
                'Start New Conversation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionsList(
    BuildContext context,
    WidgetRef ref,
    List<ChatSession> sessions,
  ) {
    // Group by date
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    final todaySessions = sessions.where((s) =>
        s.updatedAt.day == today.day &&
        s.updatedAt.month == today.month &&
        s.updatedAt.year == today.year).toList();

    final yesterdaySessions = sessions.where((s) =>
        s.updatedAt.day == yesterday.day &&
        s.updatedAt.month == yesterday.month &&
        s.updatedAt.year == yesterday.year).toList();

    final olderSessions = sessions
        .where((s) => !todaySessions.contains(s) && !yesterdaySessions.contains(s))
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        if (todaySessions.isNotEmpty) ...[
          _DateLabel(label: 'Today'),
          ...todaySessions.asMap().entries.map((e) => _SessionTile(
                session: e.value,
                index: e.key,
                onTap: () => _openSession(context, ref, e.value.id),
                onDelete: () => _deleteSession(context, ref, e.value.id),
              )),
        ],
        if (yesterdaySessions.isNotEmpty) ...[
          _DateLabel(label: 'Yesterday'),
          ...yesterdaySessions.asMap().entries.map((e) => _SessionTile(
                session: e.value,
                index: e.key,
                onTap: () => _openSession(context, ref, e.value.id),
                onDelete: () => _deleteSession(context, ref, e.value.id),
              )),
        ],
        if (olderSessions.isNotEmpty) ...[
          _DateLabel(label: 'Earlier'),
          ...olderSessions.asMap().entries.map((e) => _SessionTile(
                session: e.value,
                index: e.key,
                onTap: () => _openSession(context, ref, e.value.id),
                onDelete: () => _deleteSession(context, ref, e.value.id),
              )),
        ],
      ],
    );
  }

  Future<void> _startNewChat(BuildContext context, WidgetRef ref) async {
    await ref.read(chatControllerProvider.notifier).startNewSession();
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChatScreen(sessionId: null)),
    ).then((_) {
      ref.invalidate(sessionsControllerProvider);
    });
    
  // ✅ After returning — refresh to show only non-empty sessions
  if (context.mounted) {
    ref.invalidate(sessionsControllerProvider);
  }


  }

  Future<void> _openSession(
    BuildContext context,
    WidgetRef ref,
    String sessionId,
  ) async {
    await ref.read(chatControllerProvider.notifier).loadSession(sessionId);
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(sessionId: sessionId),),
    ).then((_) {
      ref.invalidate(sessionsControllerProvider);
    });
      if (context.mounted) {
    ref.invalidate(sessionsControllerProvider);
  }
  }

  Future<void> _deleteSession(
    BuildContext context,
    WidgetRef ref,
    String sessionId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Conversation'),
        content: const Text(
            'Are you sure you want to delete this conversation?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(sessionsControllerProvider.notifier).deleteSession(sessionId);
    }
  }

  Future<void> _showClearAllDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear All Chats'),
        content:
            const Text('This will permanently delete all conversations.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(chatStorageServiceProvider).clearAll();
      ref.invalidate(sessionsControllerProvider);
    }
  }
}

// ─── Date Label ───────────────────────────────────────────────────────────────

class _DateLabel extends StatelessWidget {
  final String label;
  const _DateLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─── Session Tile ─────────────────────────────────────────────────────────────

class _SessionTile extends StatelessWidget {
  final ChatSession session;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _SessionTile({
    required this.session,
    required this.index,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(session.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      confirmDismiss: (_) async {
        onDelete();
        return false; // Handle deletion manually
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          onTap: onTap,
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.medical_services_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            session.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                session.lastMessagePreview,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 12,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(session.updatedAt),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const Spacer(),
                  if (session.messages.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${session.messages.length} msgs',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey,
          ),
        ),
      ).animate().fadeIn(
            delay: Duration(milliseconds: index * 50),
            duration: 300.ms,
          ).slideX(begin: 0.1, end: 0),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day) {
      return DateFormat('HH:mm').format(date);
    }
    return DateFormat('MMM d').format(date);
  }
}