import '../../../../../src/infrastructure/api/response/api_response.dart';
import '../model/signin_response_model.dart';
import '../repositories/sign_in_repository_contract.dart';

class SignInUseCase {
  const SignInUseCase(this._repository);

  final SignInRepositoryContract _repository;

  Future<ApiResponse<SigninResponseModel>> call(String phone) {
    return _repository.signIn(phone);
  }
}
