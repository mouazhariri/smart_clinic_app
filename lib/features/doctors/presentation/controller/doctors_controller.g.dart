// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors_controller.dart';

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
  String debugGetCreateSourceHash() => r'doctors-controller-hash';

  @$internal
  @override
  DoctorsController create() => DoctorsController();
}

abstract class _$DoctorsController extends $AsyncNotifier<DoctorsState> {
  FutureOr<DoctorsState> build();

  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DoctorsState>, DoctorsState>;
    final element = ref.element
        as $ClassProviderElement<
            AnyNotifier<AsyncValue<DoctorsState>, DoctorsState>,
            AsyncValue<DoctorsState>,
            Object?,
            Object?>;
    element.handleCreate(ref, build);
  }
}
