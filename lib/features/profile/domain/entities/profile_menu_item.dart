import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile_menu_action.dart';

part 'profile_menu_item.freezed.dart';

@freezed
abstract class ProfileMenuItem with _$ProfileMenuItem {
  const factory ProfileMenuItem({
    required IconData icon,
    required String titleKey,
    required ProfileMenuAction action,
    @Default(false) bool isDanger,
    @Default(true) bool showChevron,
  }) = _ProfileMenuItem;
}