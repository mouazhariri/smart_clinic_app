import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/home_repository.dart';
import '../../domain/model/home_model/home_model.dart';
import 'home_state.dart';

part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
  @override
  FutureOr<HomeState> build() async {
    Future<void>.microtask(() async { await getHomeData(); });
    return HomeState.init();
  }

  Future<HomeModel?> getHomeData() async {
    try {
      state = AsyncData(state.value!.copyWith(homeModel: const AsyncLoading()));
      final repo = ref.read(homeRepositoryProvider);
      final response = await repo.getHomeData();

      if (response.hasFailed) {
        state = AsyncData(
          state.value!.copyWith(
            homeModel: AsyncError(
              response.message ?? 'Something went wrong',
              StackTrace.fromString(response.message ?? ''),
            ),
          ),
        );
        return null;
      }

      state = AsyncData(
        state.value!.copyWith(homeModel: AsyncData(response.data)),
      );
      return response.data;
    } catch (e, st) {
      state = AsyncData(state.value!.copyWith(homeModel: AsyncError(e, st)));
      return null;
    }
  }
}
