// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DoctorsController)
final doctorsControllerProvider = DoctorsControllerProvider._();

final class DoctorsControllerProvider
    extends $AsyncNotifierProvider<DoctorsController, DoctorsState> {
  DoctorsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doctorsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doctorsControllerHash();

  @$internal
  @override
  DoctorsController create() => DoctorsController();
}

String _$doctorsControllerHash() => r'4f91ec5d08d645f6808ed6c48c69ef7701d1d3d6';

abstract class _$DoctorsController extends $AsyncNotifier<DoctorsState> {
  FutureOr<DoctorsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DoctorsState>, DoctorsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DoctorsState>, DoctorsState>,
              AsyncValue<DoctorsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
