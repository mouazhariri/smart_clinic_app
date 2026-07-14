// import 'package:hive/hive.dart';
// import 'chat_message.dart';

// part 'chat_session.g.dart';

// @HiveType(typeId: 0)
// class ChatSession {
//   @HiveField(0)
//   final String id;

//   @HiveField(1)
//   final String title;

//   @HiveField(2)
//   final DateTime createdAt;

//   @HiveField(3)
//   final DateTime updatedAt;

//   @HiveField(4)
//   final List<ChatMessage> messages;

//   @HiveField(5)
//   final String? summary;

//   ChatSession({
//     required this.id,
//     required this.title,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.messages,
//     this.summary,
//   });

//   ChatSession copyWith({
//     String? title,
//     DateTime? updatedAt,
//     List<ChatMessage>? messages,
//     String? summary,
//   }) {
//     return ChatSession(
//       id: id,
//       title: title ?? this.title,
//       createdAt: createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       messages: messages ?? this.messages,
//       summary: summary ?? this.summary,
//     );
//   }

//   String get lastMessagePreview {
//     if (messages.isEmpty) return 'No messages yet';
//     final last = messages.last;
//     final text = last.text;
//     return text.length > 60 ? '${text.substring(0, 60)}...' : text;
//   }
// }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:smart_clinic_app/src/infrastructure/storage/hive/hive_type_ids.dart';

import 'chat_message.dart';

part 'chat_session.freezed.dart';
part 'chat_session.g.dart';

@freezed
@HiveType(typeId: HiveTypeIds.chatSessionId)
abstract class ChatSession with _$ChatSession {
  const ChatSession._();

  const factory ChatSession({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required DateTime createdAt,
    @HiveField(3) required DateTime updatedAt,
    @HiveField(4) required List<ChatMessage> messages,
    @HiveField(5) String? summary,
  }) = _ChatSession;

  factory ChatSession.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionFromJson(json);

  String get lastMessagePreview {
    if (messages.isEmpty) return 'No messages yet';

    final text = messages.last.text;
    return text.length > 60
        ? '${text.substring(0, 60)}...'
        : text;
  }
}