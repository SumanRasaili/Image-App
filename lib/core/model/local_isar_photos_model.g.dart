// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'local_isar_photos_model.dart';

// // **************************************************************************
// // IsarCollectionGenerator
// // **************************************************************************

// // coverage:ignore-file
// // ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

// extension GetPhotosCollectionCollection on Isar {
//   IsarCollection<PhotosCollection> get photosCollections => this.collection();
// }

// const PhotosCollectionSchema = CollectionSchema(
//   name: r'PhotosCollection',
//   id: 1339455402348346223,
//   properties: {
//     r'imageUrl': PropertySchema(
//       id: 0,
//       name: r'imageUrl',
//       type: IsarType.string,
//     ),
//     r'title': PropertySchema(
//       id: 1,
//       name: r'title',
//       type: IsarType.string,
//     )
//   },
//   estimateSize: _photosCollectionEstimateSize,
//   serialize: _photosCollectionSerialize,
//   deserialize: _photosCollectionDeserialize,
//   deserializeProp: _photosCollectionDeserializeProp,
//   idName: r'id',
//   indexes: {},
//   links: {},
//   embeddedSchemas: {},
//   getId: _photosCollectionGetId,
//   getLinks: _photosCollectionGetLinks,
//   attach: _photosCollectionAttach,
//   version: '3.1.0+1',
// );

// int _photosCollectionEstimateSize(
//   PhotosCollection object,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   var bytesCount = offsets.last;
//   {
//     final value = object.imageUrl;
//     if (value != null) {
//       bytesCount += 3 + value.length * 3;
//     }
//   }
//   {
//     final value = object.title;
//     if (value != null) {
//       bytesCount += 3 + value.length * 3;
//     }
//   }
//   return bytesCount;
// }

// void _photosCollectionSerialize(
//   PhotosCollection object,
//   IsarWriter writer,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   writer.writeString(offsets[0], object.imageUrl);
//   writer.writeString(offsets[1], object.title);
// }

// PhotosCollection _photosCollectionDeserialize(
//   Id id,
//   IsarReader reader,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   final object = PhotosCollection();
//   object.id = id;
//   object.imageUrl = reader.readStringOrNull(offsets[0]);
//   object.title = reader.readStringOrNull(offsets[1]);
//   return object;
// }

// P _photosCollectionDeserializeProp<P>(
//   IsarReader reader,
//   int propertyId,
//   int offset,
//   Map<Type, List<int>> allOffsets,
// ) {
//   switch (propertyId) {
//     case 0:
//       return (reader.readStringOrNull(offset)) as P;
//     case 1:
//       return (reader.readStringOrNull(offset)) as P;
//     default:
//       throw IsarError('Unknown property with id $propertyId');
//   }
// }

// Id _photosCollectionGetId(PhotosCollection object) {
//   return object.id ?? Isar.autoIncrement;
// }

// List<IsarLinkBase<dynamic>> _photosCollectionGetLinks(PhotosCollection object) {
//   return [];
// }

// void _photosCollectionAttach(
//     IsarCollection<dynamic> col, Id id, PhotosCollection object) {
//   object.id = id;
// }

// extension PhotosCollectionQueryWhereSort
//     on QueryBuilder<PhotosCollection, PhotosCollection, QWhere> {
//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterWhere> anyId() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(const IdWhereClause.any());
//     });
//   }
// }

// extension PhotosCollectionQueryWhere
//     on QueryBuilder<PhotosCollection, PhotosCollection, QWhereClause> {
//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterWhereClause> idEqualTo(
//       Id id) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: id,
//         upper: id,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterWhereClause>
//       idNotEqualTo(Id id) {
//     return QueryBuilder.apply(this, (query) {
//       if (query.whereSort == Sort.asc) {
//         return query
//             .addWhereClause(
//               IdWhereClause.lessThan(upper: id, includeUpper: false),
//             )
//             .addWhereClause(
//               IdWhereClause.greaterThan(lower: id, includeLower: false),
//             );
//       } else {
//         return query
//             .addWhereClause(
//               IdWhereClause.greaterThan(lower: id, includeLower: false),
//             )
//             .addWhereClause(
//               IdWhereClause.lessThan(upper: id, includeUpper: false),
//             );
//       }
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterWhereClause>
//       idGreaterThan(Id id, {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.greaterThan(lower: id, includeLower: include),
//       );
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterWhereClause>
//       idLessThan(Id id, {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.lessThan(upper: id, includeUpper: include),
//       );
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterWhereClause> idBetween(
//     Id lowerId,
//     Id upperId, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: lowerId,
//         includeLower: includeLower,
//         upper: upperId,
//         includeUpper: includeUpper,
//       ));
//     });
//   }
// }

// extension PhotosCollectionQueryFilter
//     on QueryBuilder<PhotosCollection, PhotosCollection, QFilterCondition> {
//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       idIsNull() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(const FilterCondition.isNull(
//         property: r'id',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       idIsNotNull() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(const FilterCondition.isNotNull(
//         property: r'id',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       idEqualTo(Id? value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       idGreaterThan(
//     Id? value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       idLessThan(
//     Id? value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       idBetween(
//     Id? lower,
//     Id? upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'id',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlIsNull() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(const FilterCondition.isNull(
//         property: r'imageUrl',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlIsNotNull() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(const FilterCondition.isNotNull(
//         property: r'imageUrl',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlEqualTo(
//     String? value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'imageUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlGreaterThan(
//     String? value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'imageUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlLessThan(
//     String? value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'imageUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlBetween(
//     String? lower,
//     String? upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'imageUrl',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'imageUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'imageUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'imageUrl',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'imageUrl',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'imageUrl',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       imageUrlIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'imageUrl',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleIsNull() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(const FilterCondition.isNull(
//         property: r'title',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleIsNotNull() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(const FilterCondition.isNotNull(
//         property: r'title',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleEqualTo(
//     String? value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'title',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleGreaterThan(
//     String? value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'title',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleLessThan(
//     String? value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'title',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleBetween(
//     String? lower,
//     String? upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'title',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'title',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'title',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleContains(String value, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'title',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleMatches(String pattern, {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'title',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'title',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterFilterCondition>
//       titleIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'title',
//         value: '',
//       ));
//     });
//   }
// }

// extension PhotosCollectionQueryObject
//     on QueryBuilder<PhotosCollection, PhotosCollection, QFilterCondition> {}

// extension PhotosCollectionQueryLinks
//     on QueryBuilder<PhotosCollection, PhotosCollection, QFilterCondition> {}

// extension PhotosCollectionQuerySortBy
//     on QueryBuilder<PhotosCollection, PhotosCollection, QSortBy> {
//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy>
//       sortByImageUrl() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'imageUrl', Sort.asc);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy>
//       sortByImageUrlDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'imageUrl', Sort.desc);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy> sortByTitle() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'title', Sort.asc);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy>
//       sortByTitleDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'title', Sort.desc);
//     });
//   }
// }

// extension PhotosCollectionQuerySortThenBy
//     on QueryBuilder<PhotosCollection, PhotosCollection, QSortThenBy> {
//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy> thenById() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.asc);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy>
//       thenByIdDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.desc);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy>
//       thenByImageUrl() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'imageUrl', Sort.asc);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy>
//       thenByImageUrlDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'imageUrl', Sort.desc);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy> thenByTitle() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'title', Sort.asc);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QAfterSortBy>
//       thenByTitleDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'title', Sort.desc);
//     });
//   }
// }

// extension PhotosCollectionQueryWhereDistinct
//     on QueryBuilder<PhotosCollection, PhotosCollection, QDistinct> {
//   QueryBuilder<PhotosCollection, PhotosCollection, QDistinct>
//       distinctByImageUrl({bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<PhotosCollection, PhotosCollection, QDistinct> distinctByTitle(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
//     });
//   }
// }

// extension PhotosCollectionQueryProperty
//     on QueryBuilder<PhotosCollection, PhotosCollection, QQueryProperty> {
//   QueryBuilder<PhotosCollection, int, QQueryOperations> idProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'id');
//     });
//   }

//   QueryBuilder<PhotosCollection, String?, QQueryOperations> imageUrlProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'imageUrl');
//     });
//   }

//   QueryBuilder<PhotosCollection, String?, QQueryOperations> titleProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'title');
//     });
//   }
// }
