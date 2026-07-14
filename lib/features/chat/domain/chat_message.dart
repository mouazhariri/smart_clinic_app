
// import 'dart:typed_data';

// enum MessageType {
//   text,
//   image,
//   file,
//   receipt,
// }

// enum AttachmentType {
//   pdf,
//   image,
//   receipt,
//   unknown,
// }

// class AttachedFile {
//   final String name;
//   final String path;
//   final AttachmentType type;
//   final Uint8List? bytes;
//   final String? mimeType;

//   const AttachedFile({
//     required this.name,
//     required this.path,
//     required this.type,
//     this.bytes,
//     this.mimeType,
//   });

//   AttachedFile copyWith({
//     String? name,
//     String? path,
//     AttachmentType? type,
//     Uint8List? bytes,
//     String? mimeType,
//   }) {
//     return AttachedFile(
//       name: name ?? this.name,
//       path: path ?? this.path,
//       type: type ?? this.type,
//       bytes: bytes ?? this.bytes,
//       mimeType: mimeType ?? this.mimeType,
//     );
//   }
// }

// class ChatMessage {
//   final String id;
//   final String text;
//   final bool isUser;
//   final bool isGenerating;
//   final MessageType messageType;
//   final List<String>? imageUrls;
//   final AttachedFile? attachedFile;
//   final DateTime timestamp;
//   final bool isEdited;

//   const ChatMessage({
//     required this.id,
//     required this.text,
//     required this.isUser,
//     this.isGenerating = false,
//     this.messageType = MessageType.text,
//     this.imageUrls,
//     this.attachedFile,
//     required this.timestamp,
//     this.isEdited = false,
//   });

//   ChatMessage copyWith({
//     String? text,
//     bool? isGenerating,
//     MessageType? messageType,
//     List<String>? imageUrls,
//     AttachedFile? attachedFile,
//     bool? isEdited,
//   }) {
//     return ChatMessage(
//       id: id,
//       text: text ?? this.text,
//       isUser: isUser,
//       isGenerating: isGenerating ?? this.isGenerating,
//       messageType: messageType ?? this.messageType,
//       imageUrls: imageUrls ?? this.imageUrls,
//       attachedFile: attachedFile ?? this.attachedFile,
//       timestamp: timestamp,
//       isEdited: isEdited ?? this.isEdited,
//     );
//   }
// }

import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:smart_clinic_app/src/infrastructure/storage/hive/hive_type_ids.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

enum MessageType { text, image, file, receipt }

enum AttachmentType { pdf, image, receipt, unknown }

@freezed
@HiveType(typeId: HiveTypeIds.attachedFileId)
abstract class AttachedFile with _$AttachedFile{
  const factory AttachedFile({
    @HiveField(0) required String name,
    @HiveField(1) required String path,
    @HiveField(2) required int attachmentTypeIndex,
    @HiveField(3) String? mimeType,

    @JsonKey(ignore: true)
    Uint8List? bytes,
  }) = _AttachedFile;

  const AttachedFile._();

  factory AttachedFile.fromJson(Map<String, dynamic> json) =>
      _$AttachedFileFromJson(json);

  AttachmentType get type => AttachmentType.values[attachmentTypeIndex];

  factory AttachedFile.create({
    required String name,
    required String path,
    required AttachmentType type,
    String? mimeType,
    Uint8List? bytes,
  }) {
    return AttachedFile(
      name: name,
      path: path,
      attachmentTypeIndex: type.index,
      mimeType: mimeType,
      bytes: bytes,
    );
  }

 
}

@freezed
@HiveType(typeId: HiveTypeIds.chatMessageId)
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    @HiveField(0) required String id,
    @HiveField(1) required String text,
    @HiveField(2) required bool isUser,
    @HiveField(3) @Default(false) bool isGenerating,
    @HiveField(4) @Default(0)  int messageTypeIndex,
    @HiveField(5) List<String>? imageUrls,
    @HiveField(6) AttachedFile? attachedFile,
    @HiveField(7) required DateTime timestamp,
    @HiveField(8) @Default(false) bool isEdited,
    @HiveField(9) String? extractedText,
  }) = _ChatMessage;

  const ChatMessage._();
  MessageType get messageType => MessageType.values[messageTypeIndex];

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// ✅ Static method — NOT a factory constructor
  static ChatMessage create({
    required String id,
    required String text,
    required bool isUser,
    bool isGenerating = false,
    MessageType messageType = MessageType.text,
    List<String>? imageUrls,
    AttachedFile? attachedFile,
    bool isEdited = false,
    String? extractedText,
  }) {
    return ChatMessage(
      id: id,
      text: text,
      isUser: isUser,
      isGenerating: isGenerating,
      messageTypeIndex: messageType.index,
      imageUrls: imageUrls,
      attachedFile: attachedFile,
      timestamp: DateTime.now(),
      isEdited: isEdited,
      extractedText: extractedText,
    );
  }
}
// @freezed
// @HiveType(typeId: 1)
// class ChatMessage with _$ChatMessage {
//   @HiveField(0)
//   final String id;

//   @HiveField(1)
//   final String text;

//   @HiveField(2)
//   final bool isUser;

//   @HiveField(3)
//   final bool isGenerating;

//   @HiveField(4)
//   final int messageTypeIndex;

//   @HiveField(5)
//   final List<String>? imageUrls;

//   @HiveField(6)
//   final AttachedFile? attachedFile;

//   @HiveField(7)
//   final DateTime timestamp;

//   @HiveField(8)
//   final bool isEdited;

//   @HiveField(9)
//   final String? extractedText; // OCR extracted text

//   const ChatMessage({
//     required this.id,
//     required this.text,
//     required this.isUser,
//     this.isGenerating = false,
//     this.messageTypeIndex = 0,
//     this.imageUrls,
//     this.attachedFile,
//     required this.timestamp,
//     this.isEdited = false,
//     this.extractedText,
//   });

//   MessageType get messageType => MessageType.values[messageTypeIndex];

//   factory ChatMessage.create({
//     required String id,
//     required String text,
//     required bool isUser,
//     bool isGenerating = false,
//     MessageType messageType = MessageType.text,
//     List<String>? imageUrls,
//     AttachedFile? attachedFile,
//     bool isEdited = false,
//     String? extractedText,
//   }) {
//     return ChatMessage(
//       id: id,
//       text: text,
//       isUser: isUser,
//       isGenerating: isGenerating,
//       messageTypeIndex: messageType.index,
//       imageUrls: imageUrls,
//       attachedFile: attachedFile,
//       timestamp: DateTime.now(),
//       isEdited: isEdited,
//       extractedText: extractedText,
//     );
//   }

//   ChatMessage copyWith({
//     String? text,
//     bool? isGenerating,
//     MessageType? messageType,
//     List<String>? imageUrls,
//     AttachedFile? attachedFile,
//     bool? isEdited,
//     String? extractedText,
//   }) {
//     return ChatMessage(
//       id: id,
//       text: text ?? this.text,
//       isUser: isUser,
//       isGenerating: isGenerating ?? this.isGenerating,
//       messageTypeIndex: messageType?.index ?? messageTypeIndex,
//       imageUrls: imageUrls ?? this.imageUrls,
//       attachedFile: attachedFile ?? this.attachedFile,
//       timestamp: timestamp,
//       isEdited: isEdited ?? this.isEdited,
//       extractedText: extractedText ?? this.extractedText,
//     );
//   }
// }