import 'package:dio/dio.dart';

/// Parameters collected across the 3-step signup flow.
///
/// Step 1 → [mobileNumber], Step 2 → [otp], Step 3 → [fullName]/[qid]/[password].
class SignupParams {
  const SignupParams({
    required this.fullName,
    required this.mobileNumber,
    required this.qid,
    required this.password,
    this.otp,
  });

  final String fullName;
  final String mobileNumber;
  final String qid;
  final String password;
  final String? otp;

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'mobile_no': mobileNumber,
      'qid': qid,
      'password': password,
      if (otp != null) 'otp': otp,
    };
  }

  FormData toFormData() => FormData.fromMap(toMap());
}
