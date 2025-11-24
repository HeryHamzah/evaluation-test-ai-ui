// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentRepositoryHash() =>
    r'8c7cad8e2799db37beb2d4dd2b8f7a7c278ea8a3';

/// Provides the [DocumentRepository] instance.
///
/// Copied from [documentRepository].
@ProviderFor(documentRepository)
final documentRepositoryProvider =
    AutoDisposeProvider<DocumentRepository>.internal(
      documentRepository,
      name: r'documentRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentRepositoryRef = AutoDisposeProviderRef<DocumentRepository>;
String _$uploadHash() => r'e11186b17d36998612cb9d5d06b1a89e1614509c';

/// Manages the state of document upload and indexing.
///
/// This [AutoDisposeNotifier] tracks the current [UploadStatus] and
/// exposes methods to trigger the upload flow.
///
/// Copied from [Upload].
@ProviderFor(Upload)
final uploadProvider =
    AutoDisposeNotifierProvider<Upload, UploadStatus>.internal(
      Upload.new,
      name: r'uploadProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$uploadHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Upload = AutoDisposeNotifier<UploadStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
