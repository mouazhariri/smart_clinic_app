// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'home_dashboard_model.dart';

mixin _$HomeDashboardModel {
  String get userNameKey;
  String get bannerTitleKey;
  String get bannerDescriptionKey;
  Map<String, dynamic> toJson();
}

class _HomeDashboardModel extends HomeDashboardModel {
  const _HomeDashboardModel({
    required this.userNameKey,
    required this.bannerTitleKey,
    required this.bannerDescriptionKey,
  }) : super._();

  @override
  final String userNameKey;
  @override
  final String bannerTitleKey;
  @override
  final String bannerDescriptionKey;

  @override
  Map<String, dynamic> toJson() => _$HomeDashboardModelToJson(this);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is _HomeDashboardModel &&
            userNameKey == other.userNameKey &&
            bannerTitleKey == other.bannerTitleKey &&
            bannerDescriptionKey == other.bannerDescriptionKey;
  }

  @override
  int get hashCode => Object.hash(userNameKey, bannerTitleKey, bannerDescriptionKey);
}
