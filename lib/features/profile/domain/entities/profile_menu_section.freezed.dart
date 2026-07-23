// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_menu_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileMenuSection {

 String get titleKey; List<ProfileMenuItem> get items;
/// Create a copy of ProfileMenuSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileMenuSectionCopyWith<ProfileMenuSection> get copyWith => _$ProfileMenuSectionCopyWithImpl<ProfileMenuSection>(this as ProfileMenuSection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileMenuSection&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,titleKey,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ProfileMenuSection(titleKey: $titleKey, items: $items)';
}


}

/// @nodoc
abstract mixin class $ProfileMenuSectionCopyWith<$Res>  {
  factory $ProfileMenuSectionCopyWith(ProfileMenuSection value, $Res Function(ProfileMenuSection) _then) = _$ProfileMenuSectionCopyWithImpl;
@useResult
$Res call({
 String titleKey, List<ProfileMenuItem> items
});




}
/// @nodoc
class _$ProfileMenuSectionCopyWithImpl<$Res>
    implements $ProfileMenuSectionCopyWith<$Res> {
  _$ProfileMenuSectionCopyWithImpl(this._self, this._then);

  final ProfileMenuSection _self;
  final $Res Function(ProfileMenuSection) _then;

/// Create a copy of ProfileMenuSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleKey = null,Object? items = null,}) {
  return _then(_self.copyWith(
titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ProfileMenuItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileMenuSection].
extension ProfileMenuSectionPatterns on ProfileMenuSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileMenuSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileMenuSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileMenuSection value)  $default,){
final _that = this;
switch (_that) {
case _ProfileMenuSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileMenuSection value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileMenuSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String titleKey,  List<ProfileMenuItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileMenuSection() when $default != null:
return $default(_that.titleKey,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String titleKey,  List<ProfileMenuItem> items)  $default,) {final _that = this;
switch (_that) {
case _ProfileMenuSection():
return $default(_that.titleKey,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String titleKey,  List<ProfileMenuItem> items)?  $default,) {final _that = this;
switch (_that) {
case _ProfileMenuSection() when $default != null:
return $default(_that.titleKey,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileMenuSection implements ProfileMenuSection {
  const _ProfileMenuSection({required this.titleKey, required final  List<ProfileMenuItem> items}): _items = items;
  

@override final  String titleKey;
 final  List<ProfileMenuItem> _items;
@override List<ProfileMenuItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ProfileMenuSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileMenuSectionCopyWith<_ProfileMenuSection> get copyWith => __$ProfileMenuSectionCopyWithImpl<_ProfileMenuSection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileMenuSection&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,titleKey,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ProfileMenuSection(titleKey: $titleKey, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ProfileMenuSectionCopyWith<$Res> implements $ProfileMenuSectionCopyWith<$Res> {
  factory _$ProfileMenuSectionCopyWith(_ProfileMenuSection value, $Res Function(_ProfileMenuSection) _then) = __$ProfileMenuSectionCopyWithImpl;
@override @useResult
$Res call({
 String titleKey, List<ProfileMenuItem> items
});




}
/// @nodoc
class __$ProfileMenuSectionCopyWithImpl<$Res>
    implements _$ProfileMenuSectionCopyWith<$Res> {
  __$ProfileMenuSectionCopyWithImpl(this._self, this._then);

  final _ProfileMenuSection _self;
  final $Res Function(_ProfileMenuSection) _then;

/// Create a copy of ProfileMenuSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? titleKey = null,Object? items = null,}) {
  return _then(_ProfileMenuSection(
titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ProfileMenuItem>,
  ));
}


}

// dart format on
