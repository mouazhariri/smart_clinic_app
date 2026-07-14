import 'package:dio/dio.dart';

import '../../../../src/infrastructure/network/services/network_service.dart';
import '../models/doctor_model.dart';

abstract class DoctorsRemoteDataSource {
  Future<List<DoctorModel>> getDoctors();
  Future<DoctorModel> getDoctorById(String id);
}

class DoctorsRemoteDataSourceImpl implements DoctorsRemoteDataSource {
  const DoctorsRemoteDataSourceImpl(this._networkService);

  final NetworkService<Response> _networkService;

  @override
  Future<List<DoctorModel>> getDoctors() async {
    final response = await _networkService.get('/doctors');
    final data = response.data as Map<String, dynamic>;
    final items = data['data'] as List<dynamic>;
    return items
        .map((item) => DoctorModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<DoctorModel> getDoctorById(String id) async {
    final response = await _networkService.get('/doctors/$id');
    final data = response.data as Map<String, dynamic>;
    return DoctorModel.fromJson(data['data'] as Map<String, dynamic>);
  }
}
