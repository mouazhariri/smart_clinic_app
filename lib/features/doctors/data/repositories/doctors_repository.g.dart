// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors_repository.dart';

@ProviderFor(doctorsRepository)
final doctorsRepositoryProvider = DoctorsRepositoryProvider._();

final class DoctorsRepositoryProvider extends $FunctionalProvider<
    DoctorsRepository, DoctorsRepository, DoctorsRepository> with $Provider<DoctorsRepository> {
  DoctorsRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'doctorsRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => r'doctors-repository-hash';

  @$internal
  @override
  $ProviderElement<DoctorsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DoctorsRepository create(Ref ref) => doctorsRepository(ref);

  Override overrideWithValue(DoctorsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoctorsRepository>(value),
    );
  }
}
