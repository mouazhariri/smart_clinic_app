// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileMenuItem {

 IconData get icon; String get titleKey; ProfileMenuAction get action; String? get valueKey; bool get isDanger; bool get showChevron;
/// Create a copy of ProfileMenuItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileMenuItemCopyWith<ProfileMenuItem> get copyWith => _$ProfileMenuItemCopyWithImpl<ProfileMenuItem>(this as ProfileMenuItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileMenuItem&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.action, action) || other.action == action)&&(identical(other.valueKey, valueKey) || other.valueKey == valueKey)&&(identical(other.isDanger, isDanger) || other.isDanger == isDanger)&&(identical(other.showChevron, showChevron) || other.showChevron == showChevron));
}


@override
int get hashCode => Object.hash(runtimeType,icon,titleKey,action,valueKey,isDanger,showChevron);

@override
String toString() {
  return 'ProfileMenuItem(icon: $icon, titleKey: $titleKey, action: $action, valueKey: $valueKey, isDanger: $isDanger, showChevron: $showChevron)';
}


}

/// @nodoc
abstract mixin class $ProfileMenuItemCopyWith<$Res>  {
  factory $ProfileMenuItemCopyWith(ProfileMenuItem value, $Res Function(ProfileMenuItem) _then) = _$ProfileMenuItemCopyWithImpl;
@useResult
$Res call({
 IconData icon, String titleKey, ProfileMenuAction action, String? valueKey, bool isDanger, bool showChevron
});




}
/// @nodoc
class _$ProfileMenuItemCopyWithImpl<$Res>
    implements $ProfileMenuItemCopyWith<$Res> {
  _$ProfileMenuItemCopyWithImpl(this._self, this._then);

  final ProfileMenuItem _self;
  final $Res Function(ProfileMenuItem) _then;

/// Create a copy of ProfileMenuItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? icon = null,Object? titleKey = null,Object? action = null,Object? valueKey = freezed,Object? isDanger = null,Object? showChevron = null,}) {
  return _then(_self.copyWith(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ProfileMenuAction,valueKey: freezed == valueKey ? _self.valueKey : valueKey // ignore: cast_nullable_to_non_nullable
as String?,isDanger: null == isDanger ? _self.isDanger : isDanger // ignore: cast_nullable_to_non_nullable
as bool,showChevron: null == showChevron ? _self.showChevron : showChevron // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileMenuItem].
extension ProfileMenuItemPatterns on ProfileMenuItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileMenuItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileMenuItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileMenuItem value)  $default,){
final _that = this;
switch (_that) {
case _ProfileMenuItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileMenuItem value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileMenuItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IconData icon,  String titleKey,  ProfileMenuAction action,  String? valueKey,  bool isDanger,  bool showChevron)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileMenuItem() when $default != null:
return $default(_that.icon,_that.titleKey,_that.action,_that.valueKey,_that.isDanger,_that.showChevron);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IconData icon,  String titleKey,  ProfileMenuAction action,  String? valueKey,  bool isDanger,  bool showChevron)  $default,) {final _that = this;
switch (_that) {
case _ProfileMenuItem():
return $default(_that.icon,_that.titleKey,_that.action,_that.valueKey,_that.isDanger,_that.showChevron);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IconData icon,  String titleKey,  ProfileMenuAction action,  String? valueKey,  bool isDanger,  bool showChevron)?  $default,) {final _that = this;
switch (_that) {
case _ProfileMenuItem() when $default != null:
return $default(_that.icon,_that.titleKey,_that.action,_that.valueKey,_that.isDanger,_that.showChevron);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileMenuItem implements ProfileMenuItem {
  const _ProfileMenuItem({required this.icon, required this.titleKey, required this.action, this.valueKey, this.isDanger = false, this.showChevron = true});
  

@override final  IconData icon;
@override final  String titleKey;
@override final  ProfileMenuAction action;
@override final  String? valueKey;
@override@JsonKey() final  bool isDanger;
@override@JsonKey() final  bool showChevron;

/// Create a copy of ProfileMenuItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileMenuItemCopyWith<_ProfileMenuItem> get copyWith => __$ProfileMenuItemCopyWithImpl<_ProfileMenuItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileMenuItem&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.action, action) || other.action == action)&&(identical(other.valueKey, valueKey) || other.valueKey == valueKey)&&(identical(other.isDanger, isDanger) || other.isDanger == isDanger)&&(identical(other.showChevron, showChevron) || other.showChevron == showChevron));
}


@override
int get hashCode => Object.hash(runtimeType,icon,titleKey,action,valueKey,isDanger,showChevron);

@override
String toString() {
  return 'ProfileMenuItem(icon: $icon, titleKey: $titleKey, action: $action, valueKey: $valueKey, isDanger: $isDanger, showChevron: $showChevron)';
}


}

/// @nodoc
abstract mixin class _$ProfileMenuItemCopyWith<$Res> implements $ProfileMenuItemCopyWith<$Res> {
  factory _$ProfileMenuItemCopyWith(_ProfileMenuItem value, $Res Function(_ProfileMenuItem) _then) = __$ProfileMenuItemCopyWithImpl;
@override @useResult
$Res call({
 IconData icon, String titleKey, ProfileMenuAction action, String? valueKey, bool isDanger, bool showChevron
});




}
/// @nodoc
class __$ProfileMenuItemCopyWithImpl<$Res>
    implements _$ProfileMenuItemCopyWith<$Res> {
  __$ProfileMenuItemCopyWithImpl(this._self, this._then);

  final _ProfileMenuItem _self;
  final $Res Function(_ProfileMenuItem) _then;

/// Create a copy of ProfileMenuItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? icon = null,Object? titleKey = null,Object? action = null,Object? valueKey = freezed,Object? isDanger = null,Object? showChevron = null,}) {
  return _then(_ProfileMenuItem(
icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ProfileMenuAction,valueKey: freezed == valueKey ? _self.valueKey : valueKey // ignore: cast_nullable_to_non_nullable
as String?,isDanger: null == isDanger ? _self.isDanger : isDanger // ignore: cast_nullable_to_non_nullable
as bool,showChevron: null == showChevron ? _self.showChevron : showChevron // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
