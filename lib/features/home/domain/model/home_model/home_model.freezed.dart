// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'home_model.dart';

mixin _$HomeModel {
  String get userNameKey;
  String get bannerTitleKey;
  String get bannerDescriptionKey;
  Map<String, dynamic> toJson();
}

class _HomeModel implements HomeModel {
  const _HomeModel({
    required this.userNameKey,
    required this.bannerTitleKey,
    required this.bannerDescriptionKey,
  });

  @override
  final String userNameKey;
  @override
  final String bannerTitleKey;
  @override
  final String bannerDescriptionKey;

  @override
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  @override
  String toString() =>
      'HomeModel(userNameKey: $userNameKey, bannerTitleKey: $bannerTitleKey, bannerDescriptionKey: $bannerDescriptionKey)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _HomeModel &&
          userNameKey == other.userNameKey &&
          bannerTitleKey == other.bannerTitleKey &&
          bannerDescriptionKey == other.bannerDescriptionKey;

  @override
  int get hashCode =>
      Object.hash(userNameKey, bannerTitleKey, bannerDescriptionKey);
}
