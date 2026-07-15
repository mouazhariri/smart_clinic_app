// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(doctorsRepository)
final doctorsRepositoryProvider = DoctorsRepositoryProvider._();

final class DoctorsRepositoryProvider
    extends
        $FunctionalProvider<
          DoctorsRepository,
          DoctorsRepository,
          DoctorsRepository
        >
    with $Provider<DoctorsRepository> {
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
  String debugGetCreateSourceHash() => _$doctorsRepositoryHash();

  @$internal
  @override
  $ProviderElement<DoctorsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DoctorsRepository create(Ref ref) {
    return doctorsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DoctorsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoctorsRepository>(value),
    );
  }
}

String _$doctorsRepositoryHash() => r'e56a4a73bd826f7d7f1456112f1575d10b84343a';
