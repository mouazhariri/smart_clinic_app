// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
  String debugGetCreateSourceHash() => _$appointmentsControllerHash();

  @$internal
  @override
  AppointmentsController create() => AppointmentsController();
}

String _$appointmentsControllerHash() =>
    r'1661c4b622385d480bbecb7d21b7f7cf5fc604ff';

abstract class _$AppointmentsController
    extends $AsyncNotifier<AppointmentsState> {
  FutureOr<AppointmentsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AppointmentsState>, AppointmentsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppointmentsState>, AppointmentsState>,
              AsyncValue<AppointmentsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
