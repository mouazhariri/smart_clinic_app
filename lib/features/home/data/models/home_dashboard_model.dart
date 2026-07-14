import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/home_dashboard.dart';

part 'home_dashboard_model.freezed.dart';
part 'home_dashboard_model.g.dart';

@freezed
abstract class HomeDashboardModel with _$HomeDashboardModel {
  const HomeDashboardModel._();

  const factory HomeDashboardModel({
    required String userNameKey,
    required String bannerTitleKey,
    required String bannerDescriptionKey,
  }) = _HomeDashboardModel;

  factory HomeDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDashboardModelFromJson(json);

  HomeDashboard toEntity() {
    return HomeDashboard(
      userNameKey: userNameKey,
      bannerTitleKey: bannerTitleKey,
      bannerDescriptionKey: bannerDescriptionKey,
    );
  }
}
