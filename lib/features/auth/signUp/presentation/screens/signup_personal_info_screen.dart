// import 'dart:async';

// import 'package:easy_localization/easy_localization.dart' as local;
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:smart_clinic_app/src/application/router/app_routes.dart';
// import '../../../../../src/resourses/color_manager/app_colors.dart';
// import '../../../../../src/resourses/font_manager/app_text_style.dart';
// import '../../../verification/presentation/widgets/verification_screen_pin.dart';
// import '../widgets/signup_screen/signup_auth_input.dart';
// import '../widgets/signup_screen/signup_field_label.dart';
// import '../widgets/signup_screen/signup_progress_header.dart';

// class SignupPersonalInfoScreen extends StatefulWidget {
//   const SignupPersonalInfoScreen({super.key, required this.phoneNumber, required this.otp});
//   final String phoneNumber;
//   final String otp;

//   @override
//   State<SignupPersonalInfoScreen> createState() => _SignupPersonalInfoScreenState();
// }

// class _SignupPersonalInfoScreenState extends State<SignupPersonalInfoScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _fullNameController = TextEditingController();
//   final _nationalIdController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscure = true;

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _nationalIdController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (!(_formKey.currentState?.validate() ?? false)) return;
//     // TODO: call final signup API with phone, otp, fullName, nationalId, password
//     // context.go(AppRoutes.homeScreen);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.authBackground,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(height: 18),
//                 SignupProgressHeader(stepLabel: context.tr('step_3_of_3'), progress: 1.0),
//                 const SizedBox(height: 30),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(context.tr('personal_info'), style: AppTextStyle.rubikBold22.copyWith(color: AppColors.authTitle, fontSize: 26)),
//                         const SizedBox(height: 10),
//                         Text(context.tr('personal_info_subtitle'), textAlign: TextAlign.end, style: AppTextStyle.rubikRegular14.copyWith(color: AppColors.authSubtitle)),
//                         const SizedBox(height: 24),
//                         SignupFieldLabel(label: context.tr('full_name')),
//                         const SizedBox(height: 8),
//                         SignupAuthInput(controller: _fullNameController, hintText: context.tr('full_name_hint'), validator: (v) => v!.isEmpty ? context.tr('field_required') : null),
//                         const SizedBox(height: 18),
//                         SignupFieldLabel(label: context.tr('national_id_11')),
//                         const SizedBox(height: 8),
//                         SignupAuthInput(controller: _nationalIdController, hintText: '09XXXXXXXXX', keyboardType: TextInputType.number, validator: (v) => v!.length != 11 ? context.tr('national_id_invalid') : null),
//                         Padding(padding: const EdgeInsets.only(top: 6), child: Text(context.tr('national_id_helper'), style: AppTextStyle.rubikRegular12.copyWith(color: AppColors.authHint, fontSize: 10))),
//                         const SizedBox(height: 18),
//                         SignupFieldLabel(label: context.tr('password')),
//                         const SizedBox(height: 8),
//                         SignupAuthInput(controller: _passwordController, hintText: '********',  validator: (v) => v!.length < 6 ? context.tr('password_weak') : null),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: FilledButton(
//                     onPressed: _submit,
//                     style: FilledButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
//                     child: Text(context.tr('create_account'), style: AppTextStyle.rubikSemiBold14.copyWith(color: AppColors.white)),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class VerificationScreen extends StatefulWidget {
//   const VerificationScreen({super.key, required this.phoneNumber});
//   final String phoneNumber; // 9639XXXXXXXX from previous screen

//   @override
//   State<VerificationScreen> createState() => _VerificationScreenState();
// }

// class _VerificationScreenState extends State<VerificationScreen> {
//   final _pinController = TextEditingController();
//   Timer? _timer;
//   int _seconds = 59;
//   bool _isCodeComplete = false;

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   void _startTimer() {
//     _seconds = 59;
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (_seconds == 0) {
//         t.cancel();
//       } else {
//         if (mounted) setState(() => _seconds--);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pinController.dispose();
//     super.dispose();
//   }

//   void _onVerify() {
//     if (_pinController.text.length != 4) return;
//     // TODO: call verify OTP API
//     context.push(
//       AppRoutes.signupPersonalInfoScreen,
//       extra: {
//         'phone': widget.phoneNumber,
//         'otp': _pinController.text,
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.authBackground,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const SizedBox(height: 18),
//               SignupProgressHeader(
//                 stepLabel: context.tr('step_2_of_3'),
//                 progress: 0.66,
//               ),
//               const SizedBox(height: 46),
//               Align(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: Text(
//                   context.tr('confirm_mobile_title'), // تأكيد رقم الموبايل
//                   style: AppTextStyle.rubikBold22.copyWith(color: AppColors.authTitle, fontSize: 26),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Align(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: Text(
//                   '${context.tr('enter_4_digits_code_sent')} +${widget.phoneNumber}',
//                   textAlign: TextAlign.end,
//                   style: AppTextStyle.rubikRegular14.copyWith(color: AppColors.authSubtitle),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Align(
//                 alignment: AlignmentDirectional.centerEnd,
//                 child: Text(context.tr('phone_number'), style: AppTextStyle.rubikRegular12),
//               ),
//               const SizedBox(height: 12),
//               VerificationScreenPin(
//                 controller: _pinController,
//                 onChanged: (v) => setState(() => _isCodeComplete = v.length == 4),
//                 onCompleted: (v) => setState(() => _isCodeComplete = true),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   if (_seconds > 0)
//                     Text(
//                       '${context.tr('resend_code')} (00:${_seconds.toString().padLeft(2, '0')})',
//                       style: AppTextStyle.rubikRegular12.copyWith(color: AppColors.primary),
//                     )
//                   else
//                     InkWell(
//                       onTap: _startTimer,
//                       child: Text(context.tr('resend_code'), style: AppTextStyle.rubikSemiBold12.copyWith(color: AppColors.primary)),
//                     ),
//                   const SizedBox(width: 6),
//                   Text(context.tr('did_not_receive_code'), style: AppTextStyle.rubikRegular12.copyWith(color: AppColors.authHint)),
//                 ],
//               ),
//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: FilledButton(
//                   onPressed: _isCodeComplete ? _onVerify : null,
//                   style: FilledButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     disabledBackgroundColor: AppColors.primary.withOpacity(.45),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                   ),
//                   child: Text(context.tr('confirm_code'), style: AppTextStyle.rubikSemiBold14.copyWith(color: AppColors.white)),
//                 ),
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }