import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_app/model/user_email.dart';
import 'package:chat_app/utils/network_util/endpoints.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/utils/uiUtil/flutter_secure_storage.dart';
import "package:dio/dio.dart";
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final SecureStorage _secureStorage = GetIt.I.get<SecureStorage>();

class ApiClient {
  final Dio _dio = new Dio(
    BaseOptions(
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
    ),
  );
  final _logger = Logger();
  Future sendTokenToServer({required String userToken}) async {
    _dio.options.headers["Authorization"] = "Bearer $userToken";
    _logger.d(userToken);
    try {
      Response response = await _dio.post(baseUrl + "/auth/google/token");
      if (response.statusCode == 200) {
        _secureStorage.writeValue(
            App.SECURE_STORAGE_ACCESS_TOKEN, response.data['accessToken']);
        _secureStorage.writeValue(
            App.SECURE_STORAGE_EMAIL, response.data['email']);
        _secureStorage.writeValue(
            App.SECURE_STORAGE_USER_PHOTO_URL, response.data['photoUrl']);
        _secureStorage.writeValue(App.SECURE_STORAGE_DISPLAY_NAME, response.data['displayName']);
      }
    } catch (error) {
      _logger.e(error);
    }
  }

  Future registerUser({required UserEmail userEmail}) async {
    try {
      Response response =
          await _dio.post(baseUrl + '/auth/register', data: userEmail.toJson());
      _logger.d(response.data);
      if (response.statusCode == 200) {
        _secureStorage.writeValue(
          App.SECURE_STORAGE_ACCESS_TOKEN,
          response.data['accessToken'],
        );
        _secureStorage.writeValue(
          App.SECURE_STORAGE_EMAIL,
          response.data['email'],
        );
      }
    } catch (error) {
      _logger.e(error);
    }
  }

  Future loginUser({required UserEmail userEmail}) async {
    try {
      Response response =
          await _dio.post(baseUrl + '/auth/login', data: userEmail.toJson());
      _logger.d(response.data);
      if (response.statusCode == 200) {
        _secureStorage.writeValue(
            App.SECURE_STORAGE_ACCESS_TOKEN, response.data['accessToken']);
        _secureStorage.writeValue(
            App.SECURE_STORAGE_EMAIL, response.data['email']);
      }
    } catch (error) {
      _logger.e(error);
    }
  }
}
