import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// A medical specialty shown on the home dashboard.
///
/// [labelKey] is the easy_localization key for the displayed name, and [icon]
/// is the material glyph used by the specialty tile.
class Specialty extends Equatable {
  const Specialty({
    required this.id,
    required this.labelKey,
    required this.icon,
  });

  final String id;
  final String labelKey;
  final IconData icon;

  @override
  List<Object?> get props => [id, labelKey];
}
