// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatStorageService)
final chatStorageServiceProvider = ChatStorageServiceProvider._();

final class ChatStorageServiceProvider
    extends
        $FunctionalProvider<
          ChatStorageService,
          ChatStorageService,
          ChatStorageService
        >
    with $Provider<ChatStorageService> {
  ChatStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatStorageServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatStorageServiceHash();

  @$internal
  @override
  $ProviderElement<ChatStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChatStorageService create(Ref ref) {
    return chatStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatStorageService>(value),
    );
  }
}

String _$chatStorageServiceHash() =>
    r'647a447cd1b4447fab0147a317d05e47691ec16a';

@ProviderFor(ocrService)
final ocrServiceProvider = OcrServiceProvider._();

final class OcrServiceProvider
    extends $FunctionalProvider<OcrService, OcrService, OcrService>
    with $Provider<OcrService> {
  OcrServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ocrServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ocrServiceHash();

  @$internal
  @override
  $ProviderElement<OcrService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OcrService create(Ref ref) {
    return ocrService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OcrService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OcrService>(value),
    );
  }
}

String _$ocrServiceHash() => r'740655c9849954ffe2102d8e3a940a3a78885449';

@ProviderFor(geminiService)
final geminiServiceProvider = GeminiServiceProvider._();

final class GeminiServiceProvider
    extends $FunctionalProvider<GeminiService, GeminiService, GeminiService>
    with $Provider<GeminiService> {
  GeminiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geminiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geminiServiceHash();

  @$internal
  @override
  $ProviderElement<GeminiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GeminiService create(Ref ref) {
    return geminiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeminiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeminiService>(value),
    );
  }
}

String _$geminiServiceHash() => r'cedb8320d0ef89eb7801f7131302746db82876d9';

@ProviderFor(SessionsController)
final sessionsControllerProvider = SessionsControllerProvider._();

final class SessionsControllerProvider
    extends $AsyncNotifierProvider<SessionsController, List<ChatSession>> {
  SessionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionsControllerHash();

  @$internal
  @override
  SessionsController create() => SessionsController();
}

String _$sessionsControllerHash() =>
    r'c47280b2dae1309b5d4dfef396a7870fc242dd17';

abstract class _$SessionsController extends $AsyncNotifier<List<ChatSession>> {
  FutureOr<List<ChatSession>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ChatSession>>, List<ChatSession>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ChatSession>>, List<ChatSession>>,
              AsyncValue<List<ChatSession>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ChatController)
final chatControllerProvider = ChatControllerProvider._();

final class ChatControllerProvider
    extends $AsyncNotifierProvider<ChatController, ChatState> {
  ChatControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatControllerHash();

  @$internal
  @override
  ChatController create() => ChatController();
}

String _$chatControllerHash() => r'564446a2d63463a9418620fc0034e99f57044b53';

abstract class _$ChatController extends $AsyncNotifier<ChatState> {
  FutureOr<ChatState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ChatState>, ChatState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChatState>, ChatState>,
              AsyncValue<ChatState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
