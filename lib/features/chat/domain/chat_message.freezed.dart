// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttachedFile {

@HiveField(0) String get name;@HiveField(1) String get path;@HiveField(2) int get attachmentTypeIndex;@HiveField(3) String? get mimeType;@JsonKey(ignore: true) Uint8List? get bytes;
/// Create a copy of AttachedFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachedFileCopyWith<AttachedFile> get copyWith => _$AttachedFileCopyWithImpl<AttachedFile>(this as AttachedFile, _$identity);

  /// Serializes this AttachedFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttachedFile&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.attachmentTypeIndex, attachmentTypeIndex) || other.attachmentTypeIndex == attachmentTypeIndex)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&const DeepCollectionEquality().equals(other.bytes, bytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,path,attachmentTypeIndex,mimeType,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'AttachedFile(name: $name, path: $path, attachmentTypeIndex: $attachmentTypeIndex, mimeType: $mimeType, bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $AttachedFileCopyWith<$Res>  {
  factory $AttachedFileCopyWith(AttachedFile value, $Res Function(AttachedFile) _then) = _$AttachedFileCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String name,@HiveField(1) String path,@HiveField(2) int attachmentTypeIndex,@HiveField(3) String? mimeType,@JsonKey(ignore: true) Uint8List? bytes
});




}
/// @nodoc
class _$AttachedFileCopyWithImpl<$Res>
    implements $AttachedFileCopyWith<$Res> {
  _$AttachedFileCopyWithImpl(this._self, this._then);

  final AttachedFile _self;
  final $Res Function(AttachedFile) _then;

/// Create a copy of AttachedFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? path = null,Object? attachmentTypeIndex = null,Object? mimeType = freezed,Object? bytes = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,attachmentTypeIndex: null == attachmentTypeIndex ? _self.attachmentTypeIndex : attachmentTypeIndex // ignore: cast_nullable_to_non_nullable
as int,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,bytes: freezed == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttachedFile].
extension AttachedFilePatterns on AttachedFile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttachedFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttachedFile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttachedFile value)  $default,){
final _that = this;
switch (_that) {
case _AttachedFile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttachedFile value)?  $default,){
final _that = this;
switch (_that) {
case _AttachedFile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String name, @HiveField(1)  String path, @HiveField(2)  int attachmentTypeIndex, @HiveField(3)  String? mimeType, @JsonKey(ignore: true)  Uint8List? bytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttachedFile() when $default != null:
return $default(_that.name,_that.path,_that.attachmentTypeIndex,_that.mimeType,_that.bytes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String name, @HiveField(1)  String path, @HiveField(2)  int attachmentTypeIndex, @HiveField(3)  String? mimeType, @JsonKey(ignore: true)  Uint8List? bytes)  $default,) {final _that = this;
switch (_that) {
case _AttachedFile():
return $default(_that.name,_that.path,_that.attachmentTypeIndex,_that.mimeType,_that.bytes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String name, @HiveField(1)  String path, @HiveField(2)  int attachmentTypeIndex, @HiveField(3)  String? mimeType, @JsonKey(ignore: true)  Uint8List? bytes)?  $default,) {final _that = this;
switch (_that) {
case _AttachedFile() when $default != null:
return $default(_that.name,_that.path,_that.attachmentTypeIndex,_that.mimeType,_that.bytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttachedFile extends AttachedFile {
  const _AttachedFile({@HiveField(0) required this.name, @HiveField(1) required this.path, @HiveField(2) required this.attachmentTypeIndex, @HiveField(3) this.mimeType, @JsonKey(ignore: true) this.bytes}): super._();
  factory _AttachedFile.fromJson(Map<String, dynamic> json) => _$AttachedFileFromJson(json);

@override@HiveField(0) final  String name;
@override@HiveField(1) final  String path;
@override@HiveField(2) final  int attachmentTypeIndex;
@override@HiveField(3) final  String? mimeType;
@override@JsonKey(ignore: true) final  Uint8List? bytes;

/// Create a copy of AttachedFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachedFileCopyWith<_AttachedFile> get copyWith => __$AttachedFileCopyWithImpl<_AttachedFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttachedFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachedFile&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.attachmentTypeIndex, attachmentTypeIndex) || other.attachmentTypeIndex == attachmentTypeIndex)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&const DeepCollectionEquality().equals(other.bytes, bytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,path,attachmentTypeIndex,mimeType,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'AttachedFile(name: $name, path: $path, attachmentTypeIndex: $attachmentTypeIndex, mimeType: $mimeType, bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class _$AttachedFileCopyWith<$Res> implements $AttachedFileCopyWith<$Res> {
  factory _$AttachedFileCopyWith(_AttachedFile value, $Res Function(_AttachedFile) _then) = __$AttachedFileCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String name,@HiveField(1) String path,@HiveField(2) int attachmentTypeIndex,@HiveField(3) String? mimeType,@JsonKey(ignore: true) Uint8List? bytes
});




}
/// @nodoc
class __$AttachedFileCopyWithImpl<$Res>
    implements _$AttachedFileCopyWith<$Res> {
  __$AttachedFileCopyWithImpl(this._self, this._then);

  final _AttachedFile _self;
  final $Res Function(_AttachedFile) _then;

/// Create a copy of AttachedFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? path = null,Object? attachmentTypeIndex = null,Object? mimeType = freezed,Object? bytes = freezed,}) {
  return _then(_AttachedFile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,attachmentTypeIndex: null == attachmentTypeIndex ? _self.attachmentTypeIndex : attachmentTypeIndex // ignore: cast_nullable_to_non_nullable
as int,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,bytes: freezed == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,
  ));
}


}


/// @nodoc
mixin _$ChatMessage {

@HiveField(0) String get id;@HiveField(1) String get text;@HiveField(2) bool get isUser;@HiveField(3) bool get isGenerating;@HiveField(4) int get messageTypeIndex;@HiveField(5) List<String>? get imageUrls;@HiveField(6) AttachedFile? get attachedFile;@HiveField(7) DateTime get timestamp;@HiveField(8) bool get isEdited;@HiveField(9) String? get extractedText;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.isUser, isUser) || other.isUser == isUser)&&(identical(other.isGenerating, isGenerating) || other.isGenerating == isGenerating)&&(identical(other.messageTypeIndex, messageTypeIndex) || other.messageTypeIndex == messageTypeIndex)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.attachedFile, attachedFile) || other.attachedFile == attachedFile)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.extractedText, extractedText) || other.extractedText == extractedText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,isUser,isGenerating,messageTypeIndex,const DeepCollectionEquality().hash(imageUrls),attachedFile,timestamp,isEdited,extractedText);

@override
String toString() {
  return 'ChatMessage(id: $id, text: $text, isUser: $isUser, isGenerating: $isGenerating, messageTypeIndex: $messageTypeIndex, imageUrls: $imageUrls, attachedFile: $attachedFile, timestamp: $timestamp, isEdited: $isEdited, extractedText: $extractedText)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String text,@HiveField(2) bool isUser,@HiveField(3) bool isGenerating,@HiveField(4) int messageTypeIndex,@HiveField(5) List<String>? imageUrls,@HiveField(6) AttachedFile? attachedFile,@HiveField(7) DateTime timestamp,@HiveField(8) bool isEdited,@HiveField(9) String? extractedText
});


$AttachedFileCopyWith<$Res>? get attachedFile;

}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? isUser = null,Object? isGenerating = null,Object? messageTypeIndex = null,Object? imageUrls = freezed,Object? attachedFile = freezed,Object? timestamp = null,Object? isEdited = null,Object? extractedText = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isUser: null == isUser ? _self.isUser : isUser // ignore: cast_nullable_to_non_nullable
as bool,isGenerating: null == isGenerating ? _self.isGenerating : isGenerating // ignore: cast_nullable_to_non_nullable
as bool,messageTypeIndex: null == messageTypeIndex ? _self.messageTypeIndex : messageTypeIndex // ignore: cast_nullable_to_non_nullable
as int,imageUrls: freezed == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,attachedFile: freezed == attachedFile ? _self.attachedFile : attachedFile // ignore: cast_nullable_to_non_nullable
as AttachedFile?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,extractedText: freezed == extractedText ? _self.extractedText : extractedText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttachedFileCopyWith<$Res>? get attachedFile {
    if (_self.attachedFile == null) {
    return null;
  }

  return $AttachedFileCopyWith<$Res>(_self.attachedFile!, (value) {
    return _then(_self.copyWith(attachedFile: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String text, @HiveField(2)  bool isUser, @HiveField(3)  bool isGenerating, @HiveField(4)  int messageTypeIndex, @HiveField(5)  List<String>? imageUrls, @HiveField(6)  AttachedFile? attachedFile, @HiveField(7)  DateTime timestamp, @HiveField(8)  bool isEdited, @HiveField(9)  String? extractedText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.text,_that.isUser,_that.isGenerating,_that.messageTypeIndex,_that.imageUrls,_that.attachedFile,_that.timestamp,_that.isEdited,_that.extractedText);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String text, @HiveField(2)  bool isUser, @HiveField(3)  bool isGenerating, @HiveField(4)  int messageTypeIndex, @HiveField(5)  List<String>? imageUrls, @HiveField(6)  AttachedFile? attachedFile, @HiveField(7)  DateTime timestamp, @HiveField(8)  bool isEdited, @HiveField(9)  String? extractedText)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.text,_that.isUser,_that.isGenerating,_that.messageTypeIndex,_that.imageUrls,_that.attachedFile,_that.timestamp,_that.isEdited,_that.extractedText);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String text, @HiveField(2)  bool isUser, @HiveField(3)  bool isGenerating, @HiveField(4)  int messageTypeIndex, @HiveField(5)  List<String>? imageUrls, @HiveField(6)  AttachedFile? attachedFile, @HiveField(7)  DateTime timestamp, @HiveField(8)  bool isEdited, @HiveField(9)  String? extractedText)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.text,_that.isUser,_that.isGenerating,_that.messageTypeIndex,_that.imageUrls,_that.attachedFile,_that.timestamp,_that.isEdited,_that.extractedText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessage extends ChatMessage {
  const _ChatMessage({@HiveField(0) required this.id, @HiveField(1) required this.text, @HiveField(2) required this.isUser, @HiveField(3) this.isGenerating = false, @HiveField(4) this.messageTypeIndex = 0, @HiveField(5) final  List<String>? imageUrls, @HiveField(6) this.attachedFile, @HiveField(7) required this.timestamp, @HiveField(8) this.isEdited = false, @HiveField(9) this.extractedText}): _imageUrls = imageUrls,super._();
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String text;
@override@HiveField(2) final  bool isUser;
@override@JsonKey()@HiveField(3) final  bool isGenerating;
@override@JsonKey()@HiveField(4) final  int messageTypeIndex;
 final  List<String>? _imageUrls;
@override@HiveField(5) List<String>? get imageUrls {
  final value = _imageUrls;
  if (value == null) return null;
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@HiveField(6) final  AttachedFile? attachedFile;
@override@HiveField(7) final  DateTime timestamp;
@override@JsonKey()@HiveField(8) final  bool isEdited;
@override@HiveField(9) final  String? extractedText;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.isUser, isUser) || other.isUser == isUser)&&(identical(other.isGenerating, isGenerating) || other.isGenerating == isGenerating)&&(identical(other.messageTypeIndex, messageTypeIndex) || other.messageTypeIndex == messageTypeIndex)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.attachedFile, attachedFile) || other.attachedFile == attachedFile)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.extractedText, extractedText) || other.extractedText == extractedText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,isUser,isGenerating,messageTypeIndex,const DeepCollectionEquality().hash(_imageUrls),attachedFile,timestamp,isEdited,extractedText);

@override
String toString() {
  return 'ChatMessage(id: $id, text: $text, isUser: $isUser, isGenerating: $isGenerating, messageTypeIndex: $messageTypeIndex, imageUrls: $imageUrls, attachedFile: $attachedFile, timestamp: $timestamp, isEdited: $isEdited, extractedText: $extractedText)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String text,@HiveField(2) bool isUser,@HiveField(3) bool isGenerating,@HiveField(4) int messageTypeIndex,@HiveField(5) List<String>? imageUrls,@HiveField(6) AttachedFile? attachedFile,@HiveField(7) DateTime timestamp,@HiveField(8) bool isEdited,@HiveField(9) String? extractedText
});


@override $AttachedFileCopyWith<$Res>? get attachedFile;

}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? isUser = null,Object? isGenerating = null,Object? messageTypeIndex = null,Object? imageUrls = freezed,Object? attachedFile = freezed,Object? timestamp = null,Object? isEdited = null,Object? extractedText = freezed,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isUser: null == isUser ? _self.isUser : isUser // ignore: cast_nullable_to_non_nullable
as bool,isGenerating: null == isGenerating ? _self.isGenerating : isGenerating // ignore: cast_nullable_to_non_nullable
as bool,messageTypeIndex: null == messageTypeIndex ? _self.messageTypeIndex : messageTypeIndex // ignore: cast_nullable_to_non_nullable
as int,imageUrls: freezed == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,attachedFile: freezed == attachedFile ? _self.attachedFile : attachedFile // ignore: cast_nullable_to_non_nullable
as AttachedFile?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,extractedText: freezed == extractedText ? _self.extractedText : extractedText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttachedFileCopyWith<$Res>? get attachedFile {
    if (_self.attachedFile == null) {
    return null;
  }

  return $AttachedFileCopyWith<$Res>(_self.attachedFile!, (value) {
    return _then(_self.copyWith(attachedFile: value));
  });
}
}

// dart format on
