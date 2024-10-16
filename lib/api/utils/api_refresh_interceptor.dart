import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ApiRefreshInterceptor extends Interceptor {
  late Dio dio;
  CookieManager cookieManager;

  ApiRefreshInterceptor(this.cookieManager) {
    dio = Dio();
    dio.interceptors.add(cookieManager);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await _refreshAccessToken(err.requestOptions);
        handler.resolve(await _retry(err.requestOptions));
      } on DioException catch (e) {
        super.onError(e, handler);
      }
    } else {
      super.onError(err, handler);
    }
  }

  Future<dynamic> _refreshAccessToken(RequestOptions options) async {
    final ip = options.path.split("/").sublist(0, 3).join("/");
    var response = await dio.post("$ip/health_center/api/v1/auth/refresh");
    if (response.statusCode == HttpStatus.ok) {
      return response;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options) async {
    final newOptions = Options(method: options.method);

    return dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: newOptions,
    );
  }
}
