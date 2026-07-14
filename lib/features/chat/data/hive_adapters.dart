import 'package:hive/hive.dart';
import 'package:smart_clinic_app/src/infrastructure/storage/hive/hive_type_ids.dart';
import '../domain/chat_message.dart';
import '../domain/chat_session.dart';

// ── AttachedFile Adapter (typeId: 12) ─────────────────────────────────────────

class AttachedFileHiveAdapter extends TypeAdapter<AttachedFile> {
  @override
  final int typeId = HiveTypeIds.attachedFileId; // 12

  @override
  AttachedFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttachedFile(
      name: fields[0] as String? ?? '',
      path: fields[1] as String? ?? '',
      attachmentTypeIndex: fields[2] as int? ?? 0,
      mimeType: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AttachedFile obj) {
    writer.writeByte(4);
    writer.writeByte(0);
    writer.write(obj.name);
    writer.writeByte(1);
    writer.write(obj.path);
    writer.writeByte(2);
    writer.write(obj.attachmentTypeIndex);
    writer.writeByte(3);
    writer.write(obj.mimeType);
  }
}

// ── ChatMessage Adapter (typeId: 11) ──────────────────────────────────────────

class ChatMessageHiveAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = HiveTypeIds.chatMessageId; // 11

  @override
  ChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessage(
      id: fields[0] as String? ?? '',
      text: fields[1] as String? ?? '',
      isUser: fields[2] as bool? ?? false,
      isGenerating: false,
      messageTypeIndex: fields[4] as int? ?? 0,
      imageUrls: (fields[5] as List?)?.cast<String>(),
      attachedFile: fields[6] as AttachedFile?,
      timestamp: fields[7] as DateTime? ?? DateTime.now(),
      isEdited: fields[8] as bool? ?? false,
      extractedText: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer.writeByte(9); // 9 fields (skip isGenerating field 3)
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.text);
    writer.writeByte(2);
    writer.write(obj.isUser);
    writer.writeByte(4);
    writer.write(obj.messageTypeIndex);
    writer.writeByte(5);
    writer.write(obj.imageUrls);
    writer.writeByte(6);
    writer.write(obj.attachedFile);
    writer.writeByte(7);
    writer.write(obj.timestamp);
    writer.writeByte(8);
    writer.write(obj.isEdited);
    writer.writeByte(9);
    writer.write(obj.extractedText);
  }
}

// ── ChatSession Adapter (typeId: 10) ──────────────────────────────────────────

class ChatSessionHiveAdapter extends TypeAdapter<ChatSession> {
  @override
  final int typeId = HiveTypeIds.chatSessionId; // 10

  @override
  ChatSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatSession(
      id: fields[0] as String? ?? '',
      title: fields[1] as String? ?? 'Conversation',
      createdAt: fields[2] as DateTime? ?? DateTime.now(),
      updatedAt: fields[3] as DateTime? ?? DateTime.now(),
      messages: (fields[4] as List?)?.cast<ChatMessage>() ?? [],
      summary: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatSession obj) {
    writer.writeByte(6);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.title);
    writer.writeByte(2);
    writer.write(obj.createdAt);
    writer.writeByte(3);
    writer.write(obj.updatedAt);
    writer.writeByte(4);
    writer.write(obj.messages);
    writer.writeByte(5);
    writer.write(obj.summary);
  }
}