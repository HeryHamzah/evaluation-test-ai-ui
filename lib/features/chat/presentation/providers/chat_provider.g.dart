// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiServiceHash() => r'd76dea2a3d4afd840c19952cd59fe889ce36151d';

/// Provides the [ApiService] instance.
///
/// Copied from [apiService].
@ProviderFor(apiService)
final apiServiceProvider = AutoDisposeProvider<ApiService>.internal(
  apiService,
  name: r'apiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiServiceRef = AutoDisposeProviderRef<ApiService>;
String _$chatRepositoryHash() => r'2510dea53c9a6c169909bda0000d913c88c634b0';

/// Provides the [ChatRepository] instance.
///
/// Copied from [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = AutoDisposeProvider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRepositoryRef = AutoDisposeProviderRef<ChatRepository>;
String _$chatHash() => r'07138ea4150db447e2f7e6144b25cec2c0cf2ef3';

/// Manages the state of the chat interface.
///
/// This [AsyncNotifier] holds the list of [MessageModel]s and handles
/// sending messages to the backend. It supports optimistic UI updates
/// to make the chat feel responsive.
///
/// Copied from [Chat].
@ProviderFor(Chat)
final chatProvider =
    AutoDisposeAsyncNotifierProvider<Chat, List<MessageModel>>.internal(
      Chat.new,
      name: r'chatProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chatHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Chat = AutoDisposeAsyncNotifier<List<MessageModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
