import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/home_local_data_source.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_home_dashboard_use_case.dart';
import 'home_state.dart';

final homeLocalDataSourceProvider = Provider<HomeLocalDataSource>(
  (ref) => const HomeLocalDataSourceImpl(),
);

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepositoryImpl(ref.watch(homeLocalDataSourceProvider)),
);

final getHomeDashboardUseCaseProvider = Provider<GetHomeDashboardUseCase>(
  (ref) => GetHomeDashboardUseCase(ref.watch(homeRepositoryProvider)),
);

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) => HomeController(ref.watch(getHomeDashboardUseCaseProvider))..loadDashboard(),
);

class HomeController extends StateNotifier<HomeState> {
  HomeController(this._getHomeDashboardUseCase) : super(const HomeState());

  final GetHomeDashboardUseCase _getHomeDashboardUseCase;

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true);
    try {
      final dashboard = await _getHomeDashboardUseCase();
      state = state.copyWith(dashboard: dashboard, isLoading: false);
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'something_went_wrong_please_try_again_later',
      );
    }
  }
}
