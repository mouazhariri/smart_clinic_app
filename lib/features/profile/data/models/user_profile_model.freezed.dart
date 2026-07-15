// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileModel {

 String get fullNameKey; String get emailKey; String get phoneKey; String get languageCode; String get themeKey;
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileModelCopyWith<UserProfileModel> get copyWith => _$UserProfileModelCopyWithImpl<UserProfileModel>(this as UserProfileModel, _$identity);

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileModel&&(identical(other.fullNameKey, fullNameKey) || other.fullNameKey == fullNameKey)&&(identical(other.emailKey, emailKey) || other.emailKey == emailKey)&&(identical(other.phoneKey, phoneKey) || other.phoneKey == phoneKey)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.themeKey, themeKey) || other.themeKey == themeKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullNameKey,emailKey,phoneKey,languageCode,themeKey);

@override
String toString() {
  return 'UserProfileModel(fullNameKey: $fullNameKey, emailKey: $emailKey, phoneKey: $phoneKey, languageCode: $languageCode, themeKey: $themeKey)';
}


}

/// @nodoc
abstract mixin class $UserProfileModelCopyWith<$Res>  {
  factory $UserProfileModelCopyWith(UserProfileModel value, $Res Function(UserProfileModel) _then) = _$UserProfileModelCopyWithImpl;
@useResult
$Res call({
 String fullNameKey, String emailKey, String phoneKey, String languageCode, String themeKey
});




}
/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._self, this._then);

  final UserProfileModel _self;
  final $Res Function(UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullNameKey = null,Object? emailKey = null,Object? phoneKey = null,Object? languageCode = null,Object? themeKey = null,}) {
  return _then(_self.copyWith(
fullNameKey: null == fullNameKey ? _self.fullNameKey : fullNameKey // ignore: cast_nullable_to_non_nullable
as String,emailKey: null == emailKey ? _self.emailKey : emailKey // ignore: cast_nullable_to_non_nullable
as String,phoneKey: null == phoneKey ? _self.phoneKey : phoneKey // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,themeKey: null == themeKey ? _self.themeKey : themeKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileModel].
extension UserProfileModelPatterns on UserProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullNameKey,  String emailKey,  String phoneKey,  String languageCode,  String themeKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.fullNameKey,_that.emailKey,_that.phoneKey,_that.languageCode,_that.themeKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullNameKey,  String emailKey,  String phoneKey,  String languageCode,  String themeKey)  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel():
return $default(_that.fullNameKey,_that.emailKey,_that.phoneKey,_that.languageCode,_that.themeKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullNameKey,  String emailKey,  String phoneKey,  String languageCode,  String themeKey)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.fullNameKey,_that.emailKey,_that.phoneKey,_that.languageCode,_that.themeKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileModel extends UserProfileModel {
  const _UserProfileModel({required this.fullNameKey, required this.emailKey, required this.phoneKey, required this.languageCode, required this.themeKey}): super._();
  factory _UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);

@override final  String fullNameKey;
@override final  String emailKey;
@override final  String phoneKey;
@override final  String languageCode;
@override final  String themeKey;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileModelCopyWith<_UserProfileModel> get copyWith => __$UserProfileModelCopyWithImpl<_UserProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileModel&&(identical(other.fullNameKey, fullNameKey) || other.fullNameKey == fullNameKey)&&(identical(other.emailKey, emailKey) || other.emailKey == emailKey)&&(identical(other.phoneKey, phoneKey) || other.phoneKey == phoneKey)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.themeKey, themeKey) || other.themeKey == themeKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullNameKey,emailKey,phoneKey,languageCode,themeKey);

@override
String toString() {
  return 'UserProfileModel(fullNameKey: $fullNameKey, emailKey: $emailKey, phoneKey: $phoneKey, languageCode: $languageCode, themeKey: $themeKey)';
}


}

/// @nodoc
abstract mixin class _$UserProfileModelCopyWith<$Res> implements $UserProfileModelCopyWith<$Res> {
  factory _$UserProfileModelCopyWith(_UserProfileModel value, $Res Function(_UserProfileModel) _then) = __$UserProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String fullNameKey, String emailKey, String phoneKey, String languageCode, String themeKey
});




}
/// @nodoc
class __$UserProfileModelCopyWithImpl<$Res>
    implements _$UserProfileModelCopyWith<$Res> {
  __$UserProfileModelCopyWithImpl(this._self, this._then);

  final _UserProfileModel _self;
  final $Res Function(_UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullNameKey = null,Object? emailKey = null,Object? phoneKey = null,Object? languageCode = null,Object? themeKey = null,}) {
  return _then(_UserProfileModel(
fullNameKey: null == fullNameKey ? _self.fullNameKey : fullNameKey // ignore: cast_nullable_to_non_nullable
as String,emailKey: null == emailKey ? _self.emailKey : emailKey // ignore: cast_nullable_to_non_nullable
as String,phoneKey: null == phoneKey ? _self.phoneKey : phoneKey // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,themeKey: null == themeKey ? _self.themeKey : themeKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
