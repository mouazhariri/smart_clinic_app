import '../../../../../src/infrastructure/api/response/api_response.dart';
import '../model/verify_otp_response_model.dart';
import '../repositories/verify_otp_repository_contract.dart';

class VerifyOtpUseCase {
  const VerifyOtpUseCase(this._repository);

  final VerifyOtpRepositoryContract _repository;

  Future<ApiResponse<VerifyOtpResponseModel>> call({
    required String phone,
    required String otp,
  }) {
    return _repository.verifyOtp(phone, otp);
  }
}
