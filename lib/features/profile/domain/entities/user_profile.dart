import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.fullNameKey,
    required this.emailKey,
    required this.phoneKey,
    required this.languageCode,
    required this.themeKey,
  });

  final String fullNameKey;
  final String emailKey;
  final String phoneKey;
  final String languageCode;
  final String themeKey;

  @override
  List<Object?> get props => [
        fullNameKey,
        emailKey,
        phoneKey,
        languageCode,
        themeKey,
      ];
}
