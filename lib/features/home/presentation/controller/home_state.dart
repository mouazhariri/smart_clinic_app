import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/home_model/home_model.dart';

class HomeState {
  const HomeState({required this.homeModel});

  factory HomeState.init() {
    return const HomeState(homeModel: AsyncData(null));
  }

  final AsyncValue<HomeModel?> homeModel;

  HomeState copyWith({AsyncValue<HomeModel?>? homeModel}) {
    return HomeState(homeModel: homeModel ?? this.homeModel);
  }
}
