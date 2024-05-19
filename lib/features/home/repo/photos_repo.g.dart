// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllPhotosHash() => r'b9791a47baf21ffcce4a7f5d7646f1f3c836e323';

/// See also [getAllPhotos].
@ProviderFor(getAllPhotos)
final getAllPhotosProvider = AutoDisposeFutureProvider<PhotosModel>.internal(
  getAllPhotos,
  name: r'getAllPhotosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllPhotosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllPhotosRef = AutoDisposeFutureProviderRef<PhotosModel>;
String _$searchPhotosHash() => r'13964452d9a9cb8b5bffb3c78a7159dfe699587b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchPhotos].
@ProviderFor(searchPhotos)
const searchPhotosProvider = SearchPhotosFamily();

/// See also [searchPhotos].
class SearchPhotosFamily extends Family<AsyncValue<PhotosModel>> {
  /// See also [searchPhotos].
  const SearchPhotosFamily();

  /// See also [searchPhotos].
  SearchPhotosProvider call({
    String? searchQuery,
  }) {
    return SearchPhotosProvider(
      searchQuery: searchQuery,
    );
  }

  @override
  SearchPhotosProvider getProviderOverride(
    covariant SearchPhotosProvider provider,
  ) {
    return call(
      searchQuery: provider.searchQuery,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchPhotosProvider';
}

/// See also [searchPhotos].
class SearchPhotosProvider extends AutoDisposeFutureProvider<PhotosModel> {
  /// See also [searchPhotos].
  SearchPhotosProvider({
    String? searchQuery,
  }) : this._internal(
          (ref) => searchPhotos(
            ref as SearchPhotosRef,
            searchQuery: searchQuery,
          ),
          from: searchPhotosProvider,
          name: r'searchPhotosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchPhotosHash,
          dependencies: SearchPhotosFamily._dependencies,
          allTransitiveDependencies:
              SearchPhotosFamily._allTransitiveDependencies,
          searchQuery: searchQuery,
        );

  SearchPhotosProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchQuery,
  }) : super.internal();

  final String? searchQuery;

  @override
  Override overrideWith(
    FutureOr<PhotosModel> Function(SearchPhotosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchPhotosProvider._internal(
        (ref) => create(ref as SearchPhotosRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchQuery: searchQuery,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PhotosModel> createElement() {
    return _SearchPhotosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchPhotosProvider && other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchQuery.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchPhotosRef on AutoDisposeFutureProviderRef<PhotosModel> {
  /// The parameter `searchQuery` of this provider.
  String? get searchQuery;
}

class _SearchPhotosProviderElement
    extends AutoDisposeFutureProviderElement<PhotosModel> with SearchPhotosRef {
  _SearchPhotosProviderElement(super.provider);

  @override
  String? get searchQuery => (origin as SearchPhotosProvider).searchQuery;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
