import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:oqvt_industrial_entity_management/api/utils/api_exception.dart';
import 'package:oqvt_industrial_entity_management/api/utils/api_refresh_interceptor.dart';
import 'package:oqvt_industrial_entity_management/api/utils/errors.dart';
import 'package:oqvt_industrial_entity_management/utils/cookies.dart';

import '../models/model_user.dart';

class UserApi {
  UserApi._() {
    final options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
    );
    dio = Dio(options);
  }

  void _initInterceptors() {
    final cookieJar = initCookies();
    final cookieManager = CookieManager(cookieJar);
    dio.interceptors.add(cookieManager);
    dio.interceptors.add(ApiRefreshInterceptor(cookieManager));
    initialized = true;
  }

  static UserApi? _instance;
  bool initialized = false;
  late Dio dio;

  static UserApi get instance {
    _instance ??= UserApi._();
    return _instance!;
  }

  Future<T> handleErrors<T>(int? statusCode) async {
    switch (statusCode) {
      case 400:
        return Future.error(const ApiException(XErrors.noCookie));
      case 401:
        return Future.error(const ApiException(XErrors.unauthorized));
      default:
        return Future.error(const ApiException(XErrors.other));
    }
  }

  /// Call to change current password at first login
  ///
  /// Expected data:
  /// ```
  /// {
  ///   "newPassword": "string",
  ///   "confirmNewPassword": "string",
  /// }
  /// ```
  Future<bool> changePasswordFirstLogin(
    String ip, {
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
  }) async {
    if (!initialized) {
      _initInterceptors();
    }
    try {
      final response = await dio.post(
        "$ip/api/v1/auth/changePassword",
        cancelToken: cancelToken,
        data: data,
      );
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
      return Future.error(const ApiException(XErrors.other));
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          return Future.error(const ApiException(XErrors.noInternet));
        default:
          return handleErrors<bool>(e.response?.statusCode);
      }
    } on FormatException {
      return Future.error(const ApiException(XErrors.invalidResponseData));
    } catch (e) {
      return Future.error(const ApiException(XErrors.other));
    }
  }

  Future<ModelUser?> getMe(
    String ip, {
    CancelToken? cancelToken,
  }) async {
    if (!initialized) {
      _initInterceptors();
    }
    try {
      final response = await dio.get(
        "$ip/api/v1/users/me",
        cancelToken: cancelToken,
      );
      if (response.statusCode == HttpStatus.ok) {
        return ModelUser.fromJson(response.data["user"] ?? {});
      }
      return Future.error(const ApiException(XErrors.other));
    } on DioException catch (e) {
      print(e.error);
      print(e.type);
      print(e.message);

      switch (e.type) {
        case DioExceptionType.connectionError:
          return Future.error(const ApiException(XErrors.noInternet));
        default:
          return handleErrors<ModelUser>(e.response?.statusCode);
      }
    } on FormatException {
      return Future.error(const ApiException(XErrors.invalidResponseData));
    } catch (e) {
      return Future.error(const ApiException(XErrors.other));
    }
  }
}
