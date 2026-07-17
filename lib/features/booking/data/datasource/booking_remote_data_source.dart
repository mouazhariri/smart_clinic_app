import '../../../../src/infrastructure/api/endpoint/api_endpoints.dart';
import '../../../../src/infrastructure/api/response/api_response.dart';
import '../../../../src/infrastructure/network/services/network_service.dart';
import '../../../../src/logger/log_services/dev_logger.dart';
import '../request/create_booking_request.dart';
import '../response/available_slots_response.dart';
import '../response/booking_response_model.dart';
import '../response/payment_methods_response.dart';

class BookingRemoteDataSource {
  const BookingRemoteDataSource(this._networkService);

  final NetworkService _networkService;

  Future<ApiResponse<AvailableSlotsResponse>> getDoctorSchedule(String doctorId) async {
    try {
      final response = await _networkService.get(
        '${ApiEndPoints.doctorSchedule}/$doctorId',
      );
      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to load doctor schedule');
      }
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => AvailableSlotsResponse.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      Dev.logError('Error in getDoctorSchedule: $e');
      rethrow;
    }
  }

  Future<ApiResponse<PaymentMethodsResponse>> getPaymentMethods() async {
    try {
      final response = await _networkService.get(ApiEndPoints.paymentMethods);
      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to load payment methods');
      }
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PaymentMethodsResponse.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      Dev.logError('Error in getPaymentMethods: $e');
      rethrow;
    }
  }

  Future<ApiResponse<BookingResponseModel>> createBooking(
    CreateBookingRequest request,
  ) async {
    try {
      final response = await _networkService.post(
        ApiEndPoints.createBooking,
        data: request.toJson(),
      );
      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to create booking');
      }
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => BookingResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      Dev.logError('Error in createBooking: $e');
      rethrow;
    }
  }

  Future<ApiResponse<BookingResponseModel>> confirmBooking(String bookingId) async {
    try {
      final response = await _networkService.post(
        '${ApiEndPoints.confirmBooking}/$bookingId',
      );
      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to confirm booking');
      }
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => BookingResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      Dev.logError('Error in confirmBooking: $e');
      rethrow;
    }
  }

  Future<ApiResponse<void>> cancelBooking(String bookingId) async {
    try {
      final response = await _networkService.delete(
        '${ApiEndPoints.cancelBooking}/$bookingId',
      );
      if (response.data == null || response.statusCode != 200) {
        throw Exception('Failed to cancel booking');
      }
      return ApiResponse.fromJson(
        response.data as Map<String, dynamic>,
        (_) {},
      );
    } catch (e) {
      Dev.logError('Error in cancelBooking: $e');
      rethrow;
    }
  }
}
