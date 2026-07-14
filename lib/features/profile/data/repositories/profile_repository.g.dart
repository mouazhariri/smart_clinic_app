// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repository.dart';

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider extends $FunctionalProvider<
    ProfileRepository, ProfileRepository, ProfileRepository> with $Provider<ProfileRepository> {
  ProfileRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => r'profile-repository-hash';

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) => profileRepository(ref);

  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}
