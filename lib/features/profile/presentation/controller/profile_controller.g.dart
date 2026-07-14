// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, ProfileState> {
  ProfileControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'profileControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => r'profile-controller-hash';

  @$internal
  @override
  ProfileController create() => ProfileController();
}

abstract class _$ProfileController extends $AsyncNotifier<ProfileState> {
  FutureOr<ProfileState> build();

  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProfileState>, ProfileState>;
    final element = ref.element
        as $ClassProviderElement<
            AnyNotifier<AsyncValue<ProfileState>, ProfileState>,
            AsyncValue<ProfileState>,
            Object?,
            Object?>;
    element.handleCreate(ref, build);
  }
}
