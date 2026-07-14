// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_repository.dart';

@ProviderFor(appointmentsRepository)
final appointmentsRepositoryProvider = AppointmentsRepositoryProvider._();

final class AppointmentsRepositoryProvider extends $FunctionalProvider<
        AppointmentsRepository, AppointmentsRepository, AppointmentsRepository>
    with $Provider<AppointmentsRepository> {
  AppointmentsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appointmentsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => r'appointments-repository-hash';

  @$internal
  @override
  $ProviderElement<AppointmentsRepository> $createElement(
    $ProviderPointer pointer,
  ) =>
      $ProviderElement(pointer);

  @override
  AppointmentsRepository create(Ref ref) => appointmentsRepository(ref);

  Override overrideWithValue(AppointmentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppointmentsRepository>(value),
    );
  }
}
