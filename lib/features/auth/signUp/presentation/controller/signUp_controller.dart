import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/signUp_repository.dart';
import '../../domain/model/signUp_params.dart';
import '../../domain/model/signup_response.dart';
import '../../domain/usecases/signup_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signUp_controller.g.dart';

final signupUseCaseProvider = Provider<SignupUseCase>(
  (ref) => SignupUseCase(ref.watch(signupRepositoryProvider)),
);

@riverpod
class SignUpController extends _$SignUpController {
  @override
  Future<SignupResponseModel?>? build() => null;
  DateTime? selectedDate;
  bool acceptPrivacyPolicy = false;
  String phoneNumber = '';

  void toggleAcceptedPrivacyPolicy() {
    acceptPrivacyPolicy = !acceptPrivacyPolicy;
    state = state; // 🔥 notify listeners
  }

  void setPhone(String value) {
    phoneNumber = value;
    state = state; // 🔥 notify listeners
  }

  void setBirthDate(DateTime date) {
    selectedDate = date;
    // 🔥 force rebuild safely
    ref.invalidateSelf();
    // state = const AsyncData(null);
  }

  Future<void> signUp(SignupParams params) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final signupUseCase = ref.read(signupUseCaseProvider);
      final response = await signupUseCase(params);
      return response.data;
    });
  }
}
