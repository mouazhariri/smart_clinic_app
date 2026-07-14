// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_controller.dart';

@ProviderFor(AppointmentsController)
final appointmentsControllerProvider = AppointmentsControllerProvider._();

final class AppointmentsControllerProvider
    extends $AsyncNotifierProvider<AppointmentsController, AppointmentsState> {
  AppointmentsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appointmentsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => r'appointments-controller-hash';

  @$internal
  @override
  AppointmentsController create() => AppointmentsController();
}

abstract class _$AppointmentsController
    extends $AsyncNotifier<AppointmentsState> {
  FutureOr<AppointmentsState> build();

  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppointmentsState>, AppointmentsState>;
    final element = ref.element
        as $ClassProviderElement<
            AnyNotifier<AsyncValue<AppointmentsState>, AppointmentsState>,
            AsyncValue<AppointmentsState>,
            Object?,
            Object?>;
    element.handleCreate(ref, build);
  }
}
