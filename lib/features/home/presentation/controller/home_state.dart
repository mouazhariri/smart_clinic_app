import 'package:equatable/equatable.dart';

import '../../domain/entities/home_dashboard.dart';

class HomeState extends Equatable {
  const HomeState({this.dashboard, this.isLoading = false, this.errorMessage});

  final HomeDashboard? dashboard;
  final bool isLoading;
  final String? errorMessage;

  HomeState copyWith({
    HomeDashboard? dashboard,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      dashboard: dashboard ?? this.dashboard,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [dashboard, isLoading, errorMessage];
}
