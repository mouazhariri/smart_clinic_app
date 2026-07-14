import '../../../../../src/infrastructure/api/response/api_response.dart';
import '../model/signUp_params.dart';
import '../model/signup_response.dart';

abstract class SignupRepositoryContract {
  Future<ApiResponse<SignupResponseModel>> signUp(SignupParams params);
}
