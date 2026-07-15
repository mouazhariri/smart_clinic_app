// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoctorModel {

 String get id; String get name; String get specialty; String get about; String get imageUrl; double get rating; int get reviewsCount; int get experienceYears; int get patientsCount; List<DateTime> get availableDates; List<String> get availableTimes; String get clinicAddress; double get consultationFee;
/// Create a copy of DoctorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorModelCopyWith<DoctorModel> get copyWith => _$DoctorModelCopyWithImpl<DoctorModel>(this as DoctorModel, _$identity);

  /// Serializes this DoctorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.about, about) || other.about == about)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.patientsCount, patientsCount) || other.patientsCount == patientsCount)&&const DeepCollectionEquality().equals(other.availableDates, availableDates)&&const DeepCollectionEquality().equals(other.availableTimes, availableTimes)&&(identical(other.clinicAddress, clinicAddress) || other.clinicAddress == clinicAddress)&&(identical(other.consultationFee, consultationFee) || other.consultationFee == consultationFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,specialty,about,imageUrl,rating,reviewsCount,experienceYears,patientsCount,const DeepCollectionEquality().hash(availableDates),const DeepCollectionEquality().hash(availableTimes),clinicAddress,consultationFee);

@override
String toString() {
  return 'DoctorModel(id: $id, name: $name, specialty: $specialty, about: $about, imageUrl: $imageUrl, rating: $rating, reviewsCount: $reviewsCount, experienceYears: $experienceYears, patientsCount: $patientsCount, availableDates: $availableDates, availableTimes: $availableTimes, clinicAddress: $clinicAddress, consultationFee: $consultationFee)';
}


}

/// @nodoc
abstract mixin class $DoctorModelCopyWith<$Res>  {
  factory $DoctorModelCopyWith(DoctorModel value, $Res Function(DoctorModel) _then) = _$DoctorModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String specialty, String about, String imageUrl, double rating, int reviewsCount, int experienceYears, int patientsCount, List<DateTime> availableDates, List<String> availableTimes, String clinicAddress, double consultationFee
});




}
/// @nodoc
class _$DoctorModelCopyWithImpl<$Res>
    implements $DoctorModelCopyWith<$Res> {
  _$DoctorModelCopyWithImpl(this._self, this._then);

  final DoctorModel _self;
  final $Res Function(DoctorModel) _then;

/// Create a copy of DoctorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? specialty = null,Object? about = null,Object? imageUrl = null,Object? rating = null,Object? reviewsCount = null,Object? experienceYears = null,Object? patientsCount = null,Object? availableDates = null,Object? availableTimes = null,Object? clinicAddress = null,Object? consultationFee = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,patientsCount: null == patientsCount ? _self.patientsCount : patientsCount // ignore: cast_nullable_to_non_nullable
as int,availableDates: null == availableDates ? _self.availableDates : availableDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,availableTimes: null == availableTimes ? _self.availableTimes : availableTimes // ignore: cast_nullable_to_non_nullable
as List<String>,clinicAddress: null == clinicAddress ? _self.clinicAddress : clinicAddress // ignore: cast_nullable_to_non_nullable
as String,consultationFee: null == consultationFee ? _self.consultationFee : consultationFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DoctorModel].
extension DoctorModelPatterns on DoctorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoctorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoctorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoctorModel value)  $default,){
final _that = this;
switch (_that) {
case _DoctorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoctorModel value)?  $default,){
final _that = this;
switch (_that) {
case _DoctorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String specialty,  String about,  String imageUrl,  double rating,  int reviewsCount,  int experienceYears,  int patientsCount,  List<DateTime> availableDates,  List<String> availableTimes,  String clinicAddress,  double consultationFee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoctorModel() when $default != null:
return $default(_that.id,_that.name,_that.specialty,_that.about,_that.imageUrl,_that.rating,_that.reviewsCount,_that.experienceYears,_that.patientsCount,_that.availableDates,_that.availableTimes,_that.clinicAddress,_that.consultationFee);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String specialty,  String about,  String imageUrl,  double rating,  int reviewsCount,  int experienceYears,  int patientsCount,  List<DateTime> availableDates,  List<String> availableTimes,  String clinicAddress,  double consultationFee)  $default,) {final _that = this;
switch (_that) {
case _DoctorModel():
return $default(_that.id,_that.name,_that.specialty,_that.about,_that.imageUrl,_that.rating,_that.reviewsCount,_that.experienceYears,_that.patientsCount,_that.availableDates,_that.availableTimes,_that.clinicAddress,_that.consultationFee);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String specialty,  String about,  String imageUrl,  double rating,  int reviewsCount,  int experienceYears,  int patientsCount,  List<DateTime> availableDates,  List<String> availableTimes,  String clinicAddress,  double consultationFee)?  $default,) {final _that = this;
switch (_that) {
case _DoctorModel() when $default != null:
return $default(_that.id,_that.name,_that.specialty,_that.about,_that.imageUrl,_that.rating,_that.reviewsCount,_that.experienceYears,_that.patientsCount,_that.availableDates,_that.availableTimes,_that.clinicAddress,_that.consultationFee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoctorModel extends DoctorModel {
  const _DoctorModel({required this.id, required this.name, required this.specialty, required this.about, required this.imageUrl, required this.rating, required this.reviewsCount, required this.experienceYears, required this.patientsCount, required final  List<DateTime> availableDates, required final  List<String> availableTimes, required this.clinicAddress, this.consultationFee = 0}): _availableDates = availableDates,_availableTimes = availableTimes,super._();
  factory _DoctorModel.fromJson(Map<String, dynamic> json) => _$DoctorModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String specialty;
@override final  String about;
@override final  String imageUrl;
@override final  double rating;
@override final  int reviewsCount;
@override final  int experienceYears;
@override final  int patientsCount;
 final  List<DateTime> _availableDates;
@override List<DateTime> get availableDates {
  if (_availableDates is EqualUnmodifiableListView) return _availableDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableDates);
}

 final  List<String> _availableTimes;
@override List<String> get availableTimes {
  if (_availableTimes is EqualUnmodifiableListView) return _availableTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableTimes);
}

@override final  String clinicAddress;
@override@JsonKey() final  double consultationFee;

/// Create a copy of DoctorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorModelCopyWith<_DoctorModel> get copyWith => __$DoctorModelCopyWithImpl<_DoctorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoctorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.about, about) || other.about == about)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.patientsCount, patientsCount) || other.patientsCount == patientsCount)&&const DeepCollectionEquality().equals(other._availableDates, _availableDates)&&const DeepCollectionEquality().equals(other._availableTimes, _availableTimes)&&(identical(other.clinicAddress, clinicAddress) || other.clinicAddress == clinicAddress)&&(identical(other.consultationFee, consultationFee) || other.consultationFee == consultationFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,specialty,about,imageUrl,rating,reviewsCount,experienceYears,patientsCount,const DeepCollectionEquality().hash(_availableDates),const DeepCollectionEquality().hash(_availableTimes),clinicAddress,consultationFee);

@override
String toString() {
  return 'DoctorModel(id: $id, name: $name, specialty: $specialty, about: $about, imageUrl: $imageUrl, rating: $rating, reviewsCount: $reviewsCount, experienceYears: $experienceYears, patientsCount: $patientsCount, availableDates: $availableDates, availableTimes: $availableTimes, clinicAddress: $clinicAddress, consultationFee: $consultationFee)';
}


}

/// @nodoc
abstract mixin class _$DoctorModelCopyWith<$Res> implements $DoctorModelCopyWith<$Res> {
  factory _$DoctorModelCopyWith(_DoctorModel value, $Res Function(_DoctorModel) _then) = __$DoctorModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String specialty, String about, String imageUrl, double rating, int reviewsCount, int experienceYears, int patientsCount, List<DateTime> availableDates, List<String> availableTimes, String clinicAddress, double consultationFee
});




}
/// @nodoc
class __$DoctorModelCopyWithImpl<$Res>
    implements _$DoctorModelCopyWith<$Res> {
  __$DoctorModelCopyWithImpl(this._self, this._then);

  final _DoctorModel _self;
  final $Res Function(_DoctorModel) _then;

/// Create a copy of DoctorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? specialty = null,Object? about = null,Object? imageUrl = null,Object? rating = null,Object? reviewsCount = null,Object? experienceYears = null,Object? patientsCount = null,Object? availableDates = null,Object? availableTimes = null,Object? clinicAddress = null,Object? consultationFee = null,}) {
  return _then(_DoctorModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,specialty: null == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,patientsCount: null == patientsCount ? _self.patientsCount : patientsCount // ignore: cast_nullable_to_non_nullable
as int,availableDates: null == availableDates ? _self._availableDates : availableDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,availableTimes: null == availableTimes ? _self._availableTimes : availableTimes // ignore: cast_nullable_to_non_nullable
as List<String>,clinicAddress: null == clinicAddress ? _self.clinicAddress : clinicAddress // ignore: cast_nullable_to_non_nullable
as String,consultationFee: null == consultationFee ? _self.consultationFee : consultationFee // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
