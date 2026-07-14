// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SplashController)
final splashControllerProvider = SplashControllerProvider._();

final class SplashControllerProvider
    extends $AsyncNotifierProvider<SplashController, ScreenDestination> {
  SplashControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splashControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splashControllerHash();

  @$internal
  @override
  SplashController create() => SplashController();
}

String _$splashControllerHash() => r'415cb52b429e2d30d43d31a4f3859cd7b3495881';

abstract class _$SplashController extends $AsyncNotifier<ScreenDestination> {
  FutureOr<ScreenDestination> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ScreenDestination>, ScreenDestination>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ScreenDestination>, ScreenDestination>,
              AsyncValue<ScreenDestination>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
