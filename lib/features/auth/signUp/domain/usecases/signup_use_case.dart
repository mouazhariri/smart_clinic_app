import '../../../../../src/infrastructure/api/response/api_response.dart';
import '../model/signUp_params.dart';
import '../model/signup_response.dart';
import '../repositories/signup_repository_contract.dart';

class SignupUseCase {
  const SignupUseCase(this._repository);

  final SignupRepositoryContract _repository;

  Future<ApiResponse<SignupResponseModel>> call(SignupParams params) {
    return _repository.signUp(params);
  }
}
