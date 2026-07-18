import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/dio_client.dart';
import '../../../../src/logger/failure/exceptions/app_exception.dart';
import '../datasource/booking_remote_data_source.dart';
import '../request/create_booking_request.dart';
import '../response/available_slots_response.dart';
import '../response/booking_response_model.dart';
import '../response/payment_methods_response.dart';

part 'booking_repository.g.dart';

@Riverpod(keepAlive: true)
BookingRepository bookingRepository(Ref ref) {
  final networkService = ref.watch(networkServiceProvider());
  return BookingRepository(
    remoteDataSource: BookingRemoteDataSource(networkService),
  );
}

class BookingRepository {
  BookingRepository({required BookingRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final BookingRemoteDataSource _remoteDataSource;

  Future<ApiResponse<AvailableSlotsResponse>> getDoctorSchedule(
    String doctorId,
  ) async {
    try {
      final result = await _remoteDataSource.getDoctorSchedule(doctorId);
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to fetch doctor schedule',
        );
      }
      return result;
    } catch (e) {
      throw AppException(message: 'Failed to fetch doctor schedule');
    }
  }

  Future<ApiResponse<PaymentMethodsResponse>> getPaymentMethods() async {
    try {
      final result = await _remoteDataSource.getPaymentMethods();
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to load payment methods',
        );
      }
      return result;
    } catch (e) {
      throw AppException(message: 'Failed to load payment methods');
    }
  }

  Future<ApiResponse<BookingResponseModel>> createBooking(
    CreateBookingRequest request,
  ) async {
    try {
      final result = await _remoteDataSource.createBooking(request);
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to create booking',
        );
      }
      return result;
    } catch (e) {
      throw AppException(message: 'Failed to create booking');
    }
  }

  Future<ApiResponse<BookingResponseModel>> confirmBooking(
    String bookingId,
  ) async {
    try {
      final result = await _remoteDataSource.confirmBooking(bookingId);
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to confirm booking',
        );
      }
      return result;
    } catch (e) {
      throw AppException(message: 'Failed to confirm booking');
    }
  }

  Future<ApiResponse<void>> cancelBooking(String bookingId) async {
    try {
      final result = await _remoteDataSource.cancelBooking(bookingId);
      if (result.hasFailed) {
        throw AppException(
          message: result.message ?? 'Failed to cancel booking',
        );
      }
      return result;
    } catch (e) {
      throw AppException(message: 'Failed to cancel booking');
    }
  }
}
