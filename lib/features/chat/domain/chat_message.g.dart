// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttachedFile _$AttachedFileFromJson(Map<String, dynamic> json) =>
    _AttachedFile(
      name: json['name'] as String,
      path: json['path'] as String,
      attachmentTypeIndex: (json['attachmentTypeIndex'] as num).toInt(),
      mimeType: json['mimeType'] as String?,
    );

Map<String, dynamic> _$AttachedFileToJson(_AttachedFile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'attachmentTypeIndex': instance.attachmentTypeIndex,
      'mimeType': instance.mimeType,
    };

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  text: json['text'] as String,
  isUser: json['isUser'] as bool,
  isGenerating: json['isGenerating'] as bool? ?? false,
  messageTypeIndex: (json['messageTypeIndex'] as num?)?.toInt() ?? 0,
  imageUrls: (json['imageUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  attachedFile: json['attachedFile'] == null
      ? null
      : AttachedFile.fromJson(json['attachedFile'] as Map<String, dynamic>),
  timestamp: DateTime.parse(json['timestamp'] as String),
  isEdited: json['isEdited'] as bool? ?? false,
  extractedText: json['extractedText'] as String?,
);

Map<String, dynamic> _$ChatMessageToJson(_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'isUser': instance.isUser,
      'isGenerating': instance.isGenerating,
      'messageTypeIndex': instance.messageTypeIndex,
      'imageUrls': instance.imageUrls,
      'attachedFile': instance.attachedFile,
      'timestamp': instance.timestamp.toIso8601String(),
      'isEdited': instance.isEdited,
      'extractedText': instance.extractedText,
    };
