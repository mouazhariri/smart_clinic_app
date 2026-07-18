import '../../../signIn/data/repositories/sign_in_repository.dart';
import '../../data/repositories/signUp_repository.dart';
import '../../domain/model/signUp_params.dart';
import '../../domain/model/signup_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signUp_controller.g.dart';

@Riverpod(keepAlive: true)
class SignUpController extends _$SignUpController {
  @override
  Future<SignupResponseModel?>? build() => null;

  String phoneNumber = '';

  void setPhone(String value) {
    phoneNumber = value;
  }

  /// Dispatches the OTP to [phone] using the existing OTP endpoint.
  ///
  /// Best-effort: the signup flow must not be blocked if the dispatch call
  /// fails (e.g. network), so errors are swallowed here.
  Future<void> sendOtp(String phone) async {
    phoneNumber = phone;
    try {
      await ref.read(signInRepositoryProvider).signIn(phone);
    } catch (_) {
      // OTP dispatch is best-effort; the verification step still validates input.
    }
  }

  Future<void> signUp(SignupParams params) async {
    phoneNumber = params.mobileNumber;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(signupRepositoryProvider);
      final response = await repo.signUp(params);
      return response.data;
    });
  }
}
