import 'package:equatable/equatable.dart';

class HomeDashboard extends Equatable {
  const HomeDashboard({
    required this.userNameKey,
    required this.bannerTitleKey,
    required this.bannerDescriptionKey,
  });

  final String userNameKey;
  final String bannerTitleKey;
  final String bannerDescriptionKey;

  @override
  List<Object?> get props => [userNameKey, bannerTitleKey, bannerDescriptionKey];
}
