import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../signIn/presentation/controller/sign_in_controller.dart';
import '../../data/repositories/verify_otp_repository.dart';
import '../../domain/usecases/verify_otp_use_case.dart';
import 'verify_otp_state.dart';
import '../../../../../src/application/data/user_information/user_information.dart';
import '../../../../../src/infrastructure/storage/local_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verify_otp_controller.g.dart';

final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>(
  (ref) => VerifyOtpUseCase(ref.watch(verifyOtpRepositoryProvider)),
);

@riverpod
class VerifyOtpController extends _$VerifyOtpController {
  @override
  FutureOr<VerifyOtpState> build() => VerifyOtpState();
  final TextEditingController phoneController = TextEditingController();

  Future<void> verifyOtp(String phone, String otp) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final verifyOtpUseCase = ref.read(verifyOtpUseCaseProvider);
      final response = await verifyOtpUseCase(phone: phone, otp: otp);

      final info = UserInformation(
          // token: '',
          fullName: response.data!.fullName,
          email: response.data!.mobileNo,
          qid: response.data!.mobileNo,
          );

      await ref
          .read(localStorageServiceProvider)
          .saveToken(response.data!.token);
      await ref.read(localStorageServiceProvider).saveUserInfo(info);
      // final token = await ref.read(localStorageServiceProvider).getToken();
      // Dev.logLine(token);
      ref.read(signInControllerProvider.notifier).checkPhoneFilled(false);
      // await ref
      //     .read(notificationsServiceProvider)
      //     .sendDeviceToken(info.mobileNumber ?? "");
      return state.value!.copyWith(verifyOtpResponseModel: response.data);
    });
  }

  Future<void> resendCoe(String phone) async {
    state =
        AsyncData(state.value!.copyWith(signinResponseModel: AsyncLoading()));

    state = AsyncData(state.value!.copyWith(
        signinResponseModel: await AsyncValue.guard(() async {
      final signInUseCase = ref.read(signInUseCaseProvider);
      final response = await signInUseCase(phone);

      return Future.value(response.data);
    })));
    // state = const AsyncLoading();
    // state = await AsyncValue.guard(() async {
    //   final repo = ref.read(signInRepositoryProvider);
    //   final response = await repo.signIn(phone);

    //   return state.value!.copyWith(signinResponseModel: response.data);
    // });
  }
}
