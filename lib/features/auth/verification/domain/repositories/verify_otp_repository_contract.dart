import '../../../../../src/infrastructure/api/response/api_response.dart';
import '../model/verify_otp_response_model.dart';

abstract class VerifyOtpRepositoryContract {
  Future<ApiResponse<VerifyOtpResponseModel>> verifyOtp(String phone, String otp);
}
