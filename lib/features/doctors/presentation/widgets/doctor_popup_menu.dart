import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_clinic_app/src/resourses/color_manager/app_colors.dart';
import 'package:smart_clinic_app/src/resourses/font_manager/app_text_style.dart';

import '../../domain/entities/doctor.dart';

enum _Action { favorite, share, rate, help, report }

class DoctorPopupMenu extends StatefulWidget {
  final Doctor doctor;
  const DoctorPopupMenu({super.key, required this.doctor});

  @override
  State<DoctorPopupMenu> createState() => _DoctorPopupMenuState();
}

class _DoctorPopupMenuState extends State<DoctorPopupMenu> {
  bool _isFavorite = false;

  void _on(_Action a) {
    switch (a) {
      case _Action.favorite:
        setState(() => _isFavorite = !_isFavorite);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            _isFavorite
                ? context.tr('added_to_favorites')
                : context.tr('removed_from_favorites'),
          ),
          duration: const Duration(seconds: 2),
        ));
        break;

      case _Action.share:
        Share.share(
          '${context.tr('check_doctor_profile')}\n'
          '${widget.doctor.name} - ${widget.doctor.specialty}',
        );
        break;

      case _Action.rate:
        _ratingSheet();
        break;

      case _Action.help:
        _helpSheet();
        break;

      case _Action.report:
        _reportSheet();
        break;
    }
  }

  // ─── Bottom Sheets ────────────────────────────────────────────────────────

  void _ratingSheet() {
    int stars = 0;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, set) => Container(
          padding: EdgeInsets.fromLTRB(
              20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _handle(),
              const SizedBox(height: 16),
              Text(
                context.tr('rate_doctor'),
                style: AppTextStyle.tajawalBold18.copyWith(
                    color: AppColors.authTitle),
              ),
              const SizedBox(height: 4),
              Text(
                widget.doctor.name,
                style: AppTextStyle.tajawalRegular14.copyWith(
                    color: AppColors.authSubtitle),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => GestureDetector(
                    onTap: () => set(() => stars = i + 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        i < stars
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: AppColors.ratingYellow,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: context.tr('write_review'),
                  hintStyle: AppTextStyle.tajawalRegular14.copyWith(
                      color: AppColors.authHint),
                  filled: true,
                  fillColor: AppColors.dashNeutralBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(context.tr('rating_submitted'))),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    context.tr('submit_rating'),
                    style: AppTextStyle.tajawalBold16.copyWith(
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _reportSheet() {
    final reasons = [
      context.tr('report_wrong_info'),
      context.tr('report_spam'),
      context.tr('report_inappropriate'),
      context.tr('report_other'),
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _handle()),
            const SizedBox(height: 16),
            Text(
              context.tr('report_doctor'),
              style: AppTextStyle.tajawalBold18.copyWith(
                  color: AppColors.authTitle),
            ),
            const SizedBox(height: 8),
            ...reasons.map(
              (r) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.radio_button_unchecked,
                    color: AppColors.primary),
                title: Text(
                  r,
                  style: AppTextStyle.tajawalRegular14.copyWith(
                      color: AppColors.authTitle),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(context.tr('report_submitted'))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _helpSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _handle(),
            const SizedBox(height: 16),
            Text(
              context.tr('help_support'),
              style: AppTextStyle.tajawalBold18.copyWith(
                  color: AppColors.authTitle),
            ),
            const SizedBox(height: 8),
            _helpTile(Icons.phone_outlined, context.tr('contact_support')),
            _helpTile(
                Icons.chat_bubble_outline, context.tr('live_chat')),
            _helpTile(Icons.email_outlined, context.tr('email_support')),
          ],
        ),
      ),
    );
  }

  Widget _helpTile(IconData icon, String label) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(
          label,
          style: AppTextStyle.tajawalRegular14.copyWith(
              color: AppColors.authTitle),
        ),
        trailing: const Icon(Icons.arrow_back_ios,
            size: 14, color: AppColors.authHint),
        onTap: () => Navigator.pop(context),
      );

  Widget _handle() => Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.dashNeutralBg,
          borderRadius: BorderRadius.circular(2),
        ),
      );

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_Action>(
      // ✅ Styled trigger button matching the screenshot
      icon: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.more_vert, color: AppColors.authTitle, size: 22),
      ),
      // ✅ Popup opens below the button, anchored to its position
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.12),
      onSelected: _on,
      itemBuilder: (_) => [
        // ── Favourite ──────────────────────────────────────────────────────
        _buildItem(
          action: _Action.favorite,
          icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
          label: _isFavorite
              ? context.tr('remove_from_favorites')
              : context.tr('add_to_favorites'),
          iconColor: _isFavorite ? Colors.red : AppColors.authTitle,
          showDivider: true,
        ),

        // ── Share ──────────────────────────────────────────────────────────
        _buildItem(
          action: _Action.share,
          icon: Icons.share_outlined,
          label: context.tr('share_profile'),
          iconColor: AppColors.authTitle,
          showDivider: true,
        ),

        // ── Rate ───────────────────────────────────────────────────────────
        _buildItem(
          action: _Action.rate,
          icon: Icons.star_border_outlined,
          label: context.tr('rate_doctor'),
          iconColor: AppColors.authTitle,
          showDivider: true,
        ),

        // ── Help ───────────────────────────────────────────────────────────
        _buildItem(
          action: _Action.help,
          icon: Icons.headset_mic_outlined,
          label: context.tr('help_support'),
          iconColor: AppColors.authTitle,
          showDivider: true,
        ),

        // ── Report ─────────────────────────────────────────────────────────
        _buildItem(
          action: _Action.report,
          icon: Icons.warning_amber_outlined,
          label: context.tr('report_doctor'),
          iconColor: AppColors.errorRed,
          labelColor: AppColors.errorRed,
          showDivider: false,
        ),
      ],
    );
  }

  // ─── Item builder ─────────────────────────────────────────────────────────

  PopupMenuItem<_Action> _buildItem({
    required _Action action,
    required IconData icon,
    required String label,
    Color iconColor = AppColors.authTitle,
    Color? labelColor,
    required bool showDivider,
  }) {
    return PopupMenuItem<_Action>(
      value: action,
      padding: EdgeInsets.zero,
      // ✅ Using a custom child so we can control layout precisely
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon (on the RIGHT in RTL = leading in Row)
                Icon(icon, size: 24, color: iconColor),
                const SizedBox(width: 16),
                // Text (fills remaining space, right-aligned in RTL)
                Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.tajawalRegular14.copyWith(
                      fontSize: 16,
                      color: labelColor ?? AppColors.authTitle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ✅ Divider between items (except the last one)
          if (showDivider)
            const Divider(
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Color(0xFFEEEEEE),
            ),
        ],
      ),
    );
  }
}