import '../../../../../src/infrastructure/api/response/api_response.dart';
import '../model/signin_response_model.dart';

abstract class SignInRepositoryContract {
  Future<ApiResponse<SigninResponseModel>> signIn(String phone);
}
