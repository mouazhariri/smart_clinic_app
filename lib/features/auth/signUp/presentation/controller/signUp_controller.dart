import '../../data/repositories/signUp_repository.dart';
import '../../domain/model/signUp_params.dart';
import '../../domain/model/signup_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signUp_controller.g.dart';

@Riverpod(keepAlive: true)
class SignUpController extends _$SignUpController {
  @override
  Future<SignupResponseModel?>? build() => null;
  DateTime? selectedDate;
  bool acceptPrivacyPolicy = false;
  String phoneNumber = '';

  void toggleAcceptedPrivacyPolicy() {
    acceptPrivacyPolicy = !acceptPrivacyPolicy;
    state = state;
  }

  void setPhone(String value) {
    phoneNumber = value;
    state = state;
  }

  void setBirthDate(DateTime date) {
    selectedDate = date;
    ref.invalidateSelf();
  }

  Future<void> signUp(SignupParams params) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(signupRepositoryProvider);
      final response = await repo.signUp(params);
      return response.data;
    });
  }
}
