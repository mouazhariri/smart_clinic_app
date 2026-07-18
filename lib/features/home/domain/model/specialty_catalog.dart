import 'package:flutter/material.dart';
import 'package:smart_clinic_app/gen/assets.gen.dart';

import 'specialty.dart';

/// Seed catalog of specialties displayed on the home dashboard.
///
/// Kept as a const list so it needs no codegen or network call; the backend
/// catalog can later replace it without touching the presentation layer.
abstract final class SpecialtyCatalog {
  static final List<Specialty> all = [
    Specialty(
      id: 'psychiatry',
      labelKey: 'specialty_psychiatry',
      icon: Assets.icons.brainIc.path,
    ),
    Specialty(
      id: 'gastroenterology',
      labelKey: 'specialty_gastroenterology',
      icon: Assets.icons.reinsIc.path
    ),
    Specialty(
      id: 'gynecology',
      labelKey: 'specialty_gynecology',
      icon: Assets.icons.womenIc.path,
    ),
    Specialty(
      id: 'hepatology',
      labelKey: 'specialty_hepatology',
      icon: Assets.icons.liverIc.path
    ),
    Specialty(
      id: 'pediatrics',
      labelKey: 'specialty_pediatrics',
      icon: Assets.icons.babiesIc.path,
    ),
    Specialty(
      id: 'ent',
      labelKey: 'specialty_ent',
      icon:Assets.icons.earsIc.path,
    ),
    Specialty(
      id: 'cardiology',
      labelKey: 'specialty_cardiology',
      icon: Assets.icons.heartIc.path,
    ),
    Specialty(
      id: 'spine',
      labelKey: 'specialty_spine',
      icon: Assets.icons.spineIc.path,
    ),
  ];
}
