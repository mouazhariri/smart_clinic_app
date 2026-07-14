import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/dio_client.dart';
import '../../../../src/logger/failure/exceptions/app_exception.dart';
import '../../domain/model/home_model/home_model.dart';
import '../datasources/home_data_source.dart';

part 'home_repository.g.dart';

@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) {
  final networkService = ref.watch(networkServiceProvider());
  return HomeRepository(HomeRemoteDataSource(networkService));
}

class HomeRepository {
  HomeRepository(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  Future<ApiResponse<HomeModel>> getHomeData() async {
    try {
      final result = await _remoteDataSource.getHomeData();
      if (result.hasFailed) {
        throw AppException(message: result.message ?? 'Failed to fetch data');
      }
      return result;
    } catch (e) {
      throw AppException(message: 'Failed to fetch HomeModel: $e');
    }
  }
}
