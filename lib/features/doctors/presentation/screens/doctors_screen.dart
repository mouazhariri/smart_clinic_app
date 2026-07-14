import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/shared_widgets/app_loader.dart';
import '../../../../src/resourses/color_manager/app_colors.dart';
import '../../../../src/resourses/font_manager/app_text_style.dart';
import '../controller/doctors_controller.dart';
import '../widgets/doctor_card_widget.dart';
import '../widgets/smart_clinic_app_bar.dart';

class DoctorsScreen extends ConsumerWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doctorsControllerProvider);
    final controller = ref.read(doctorsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          SmartClinicAppBar(
            title: context.tr('doctors'),
            subtitle: context.tr('find_your_doctor'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: context.tr('search_doctor'),
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          Expanded(
            child: state.isLoading
                ? const Center(child: AppLoader())
                : state.filteredDoctors.isEmpty
                    ? Center(
                        child: Text(
                          context.tr('no_doctors_found'),
                          style: AppTextStyle.interMedium16,
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                        itemCount: state.filteredDoctors.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return DoctorCardWidget(
                            doctor: state.filteredDoctors[index],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
