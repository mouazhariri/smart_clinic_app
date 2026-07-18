import 'package:flutter/material.dart';

import '../widgets/smart_clinic_bottom_navigation.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  final int currentIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: SmartClinicBottomNavigation(currentIndex: currentIndex),
    );
  }
}
