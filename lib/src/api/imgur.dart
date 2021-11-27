import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/auth.dart';
import '../models/imgur_gallery.dart';

const String BASE_API_URL = 'https://api.imgur.com/3/';
const String BASE_WEBSITE_URL = 'https://imgur.com/';
const String IMGUR_APP_ID = '573eadd2dde4a44';
const String IMGUR_AUTH_URL = 'https://api.imgur.com/oauth2/authorize';

enum ImgurSortOption {
  time, viral, top
}

enum ImgurWindowOption {
 all, day, week, month, year
}

String? _accessToken;
String? _refreshToken;
String? _username;

void setAuth(Auth auth) {
  _accessToken = auth.accessToken;
  _refreshToken = auth.refreshToken;
  _username = auth.username;
}

Future<ImgurGallery?> getAccountImages() async {
  final Uri uri = Uri.parse('$BASE_API_URL/account/me/images');
  final Response response = await get(uri, headers: _headers());
  return _galleryFromResponse(response);
}

Future<ImgurGallery?> getFavoriteImages() async {
  final Uri uri = Uri.parse('$BASE_API_URL/account/me/favorites');
  final Response response = await get(uri, headers: _headers());
  return _galleryFromResponse(response);
}

Future<ImgurGallery?> getHotImages(
  ImgurSortOption sort,
  ImgurWindowOption window
) async {
  final String options = '${describeEnum(sort)}/${describeEnum(window)}';
  final Uri uri = Uri.parse('$BASE_API_URL/gallery/hot/$options/1');
  final Response response = await get(uri, headers: _headers());
  return _galleryFromResponse(response);
}

Future<ImgurGallery?> searchImages(
  String search,
  ImgurSortOption sort,
  ImgurWindowOption window
) async {
  final String options = '${describeEnum(sort)}/${describeEnum(window)}';
  final Uri uri = Uri.parse('$BASE_API_URL/gallery/search/$options/1');
  uri.queryParameters['q'] = search;
  final Response response = await get(uri, headers: _headers());
  return _galleryFromResponse(response);
}

Future<void> logout() async {
  final Uri uri = Uri.parse('$BASE_WEBSITE_URL/logout');
  uri.queryParameters['client_id'] = IMGUR_APP_ID;
  await post(uri);
}

Map<String, String> _headers() => <String, String>{
  'Authorization': 'Bearer $_accessToken'
};

ImgurGallery? _galleryFromResponse(Response response) {
  if (response.statusCode == 200) {
    final dynamic json = jsonDecode(response.body);
    return ImgurGallery.fromJson(json as Map<String, dynamic>);
  }
  return null;
}
