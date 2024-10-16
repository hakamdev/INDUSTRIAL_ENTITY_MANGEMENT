import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:oqvt_industrial_entity_management/api/utils/api_exception.dart';
import 'package:oqvt_industrial_entity_management/api/utils/errors.dart';
import 'package:oqvt_industrial_entity_management/models/model_user.dart';
import 'package:oqvt_industrial_entity_management/utils/cookies.dart';

class AuthApi {
  AuthApi._() {
    final options = BaseOptions();
    dio = Dio(options);
  }

  void _initInterceptors() {
    final cookieJar = initCookies();
    dio.interceptors.add(CookieManager(cookieJar));
    initialized = true;
  }

  static AuthApi? _instance;
  bool initialized = false;
  late Dio dio;

  static AuthApi get instance {
    _instance ??= AuthApi._();
    return _instance!;
  }

  Future<T?> handleErrors<T>(int? statusCode) async {
    switch (statusCode) {
      case 400:
        return Future.error(const ApiException(XErrors.invalidRequestData));
      case 401:
        return Future.error(const ApiException(XErrors.wrongCredentials));
      default:
        return Future.error(const ApiException(XErrors.other));
    }
  }

  /// Call with credentials to login.</br>
  ///
  /// Expected data:
  /// ```
  /// {
  ///   "email": "string",
  ///   "password": "string"
  /// }
  /// ```
  Future<ModelUser?> login(
    String ip, {
    required Map<String, dynamic> data,
    CancelToken? cancelToken,
  }) async {
    if (!initialized) {
      _initInterceptors();
    }
    try {
      final response = await dio.post(
        "$ip/health_center/api/v1/auth/login",
        cancelToken: cancelToken,
        data: data,
      );
      if (response.statusCode == HttpStatus.ok) {
        return ModelUser.fromJson(response.data["user"] ?? {});
      }
      return Future.error(const ApiException(XErrors.other));
    } on DioException catch (e) {
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
