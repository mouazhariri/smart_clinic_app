import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_menu_item.dart';

part 'profile_menu_section.freezed.dart';

@freezed
abstract class ProfileMenuSection with _$ProfileMenuSection {
  const factory ProfileMenuSection({
    required String titleKey,
    required List<ProfileMenuItem> items,
  }) = _ProfileMenuSection;
}