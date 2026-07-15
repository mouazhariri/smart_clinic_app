import 'package:flutter/material.dart';

import 'specialty.dart';

/// Seed catalog of specialties displayed on the home dashboard.
///
/// Kept as a const list so it needs no codegen or network call; the backend
/// catalog can later replace it without touching the presentation layer.
abstract final class SpecialtyCatalog {
  static const List<Specialty> all = [
    Specialty(
      id: 'psychiatry',
      labelKey: 'specialty_psychiatry',
      icon: Icons.psychology_outlined,
    ),
    Specialty(
      id: 'gastroenterology',
      labelKey: 'specialty_gastroenterology',
      icon: Icons.medical_information_outlined,
    ),
    Specialty(
      id: 'gynecology',
      labelKey: 'specialty_gynecology',
      icon: Icons.pregnant_woman_outlined,
    ),
    Specialty(
      id: 'hepatology',
      labelKey: 'specialty_hepatology',
      icon: Icons.bloodtype_outlined,
    ),
    Specialty(
      id: 'pediatrics',
      labelKey: 'specialty_pediatrics',
      icon: Icons.child_care_outlined,
    ),
    Specialty(
      id: 'ent',
      labelKey: 'specialty_ent',
      icon: Icons.hearing_outlined,
    ),
    Specialty(
      id: 'cardiology',
      labelKey: 'specialty_cardiology',
      icon: Icons.favorite_outline,
    ),
    Specialty(
      id: 'spine',
      labelKey: 'specialty_spine',
      icon: Icons.accessibility_new_outlined,
    ),
  ];
}
