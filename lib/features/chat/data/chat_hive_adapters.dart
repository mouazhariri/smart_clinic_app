import 'package:hive/hive.dart';
import 'package:smart_clinic_app/src/infrastructure/storage/hive/hive_type_ids.dart';
import '../domain/chat_message.dart';
import '../domain/chat_session.dart';

// ── AttachedFile Adapter ───────────────────────────────────────────────────────

class AttachedFileHiveAdapter extends TypeAdapter<AttachedFile> {
  @override
  final int typeId = HiveTypeIds.attachedFileId;

  @override
  AttachedFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttachedFile(
      name: fields[0] as String,
      path: fields[1] as String,
      attachmentTypeIndex: fields[2] as int,
      mimeType: fields[3] as String?,
      // bytes not persisted
    );
  }

  @override
  void write(BinaryWriter writer, AttachedFile obj) {
    writer.writeByte(4); // number of fields
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

// ── ChatMessage Adapter ────────────────────────────────────────────────────────

class ChatMessageHiveAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = HiveTypeIds.chatMessageId;

  @override
  ChatMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessage(
      id: fields[0] as String,
      text: fields[1] as String,
      isUser: fields[2] as bool,
      isGenerating: false, // never restore generating state
      messageTypeIndex: fields[4] as int? ?? 0,
      imageUrls: (fields[5] as List?)?.cast<String>(),
      attachedFile: fields[6] as AttachedFile?,
      timestamp: fields[7] as DateTime,
      isEdited: fields[8] as bool? ?? false,
      extractedText: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    // Only write non-generating messages with content
    writer.writeByte(9); // number of fields (skip field 3 = isGenerating)
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

// ── ChatSession Adapter ────────────────────────────────────────────────────────

class ChatSessionAdapter extends TypeAdapter<ChatSession> {
  @override
  final int typeId = HiveTypeIds.chatSessionId;

  @override
  ChatSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatSession(
      id: fields[0] as String,
      title: fields[1] as String,
      createdAt: fields[2] as DateTime,
      updatedAt: fields[3] as DateTime,
      messages: (fields[4] as List).cast<ChatMessage>(),
      summary: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatSession obj) {
    writer.writeByte(6); // number of fields
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