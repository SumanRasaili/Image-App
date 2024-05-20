import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vritapp/config/app_url.dart';
import 'package:vritapp/core/api_base.dart';
import 'package:vritapp/core/model/photos_model.dart';

part 'photos_repo.g.dart';

@riverpod
Future<PhotosModel> getAllPhotos(
  GetAllPhotosRef ref, {
  required String? nextPage,
}) async {
  final response = await ApiBase.getRequest(
    path: nextPage ?? AppUrl.pixelUrl,
  );
  print("The json response is ${response.data}");
  print("The json uri is ${response.realUri}");
  return PhotosModel.fromJson(json.decode(response.data));
}

@riverpod
Future<PhotosModel> searchPhotos(SearchPhotosRef ref,
    {String? searchQuery}) async {
  final response = await ApiBase.getRequest(
      path: AppUrl.searchPhotos,
      queryParameters: {if (searchQuery != null) "query": searchQuery});
  return PhotosModel.fromJson(json.decode(response.data));
}
