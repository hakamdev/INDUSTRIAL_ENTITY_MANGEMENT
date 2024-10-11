import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/api/auth_api.dart';
import 'package:oqvt_industrial_entity_management/api/user_api.dart';
import 'package:oqvt_industrial_entity_management/api/utils/api_exception.dart';
import 'package:oqvt_industrial_entity_management/api/utils/errors.dart';
import 'package:oqvt_industrial_entity_management/api/utils/states.dart';
import 'package:oqvt_industrial_entity_management/models/model_user.dart';

class AuthProvider extends ChangeNotifier {
  final String serverIP = "http://10.16.180.54";
  XState _state = XState.initial;
  final CancelToken _cancelToken = CancelToken();
  ModelUser? _user;
  bool _firstTimeOpeningApp = true;

  ModelUser? get user => _user;

  XState get state => _state;

  bool get firstTimeOpeningApp => _firstTimeOpeningApp;

  set user(ModelUser? user) {
    _user = user;
    notifyListeners();
  }

  set state(XState state) {
    _state = state;
    notifyListeners();
  }

  set firstTimeOpeningApp(bool value) {
    _firstTimeOpeningApp = false;
  }

  /// Call with credentials to login.
  ///
  /// Expected data:
  /// ```
  /// {
  ///   "email": "string",
  ///   "password": "string"
  /// }
  /// ```
  Future<ModelUser> login({
    required String ip,
    required Map<String, dynamic> data,
  }) async {
    if (_state == XState.loading) {
      Future.error(const ApiException(XErrors.alreadyLoading));
    }
    state = XState.loading;

    try {
      final user = await AuthApi.instance.login(
        ip,
        cancelToken: _cancelToken,
        data: data,
      );
      if (user != null) {
        this.user = user;
        state = XState.done;
        return user;
      } else {
        state = XState.error;
        return Future.error(const ApiException(XErrors.other));
      }
    } on ApiException catch (e) {
      state = XState.error;
      return Future.error(e);
    }
  }

  /// Call when authenticated to get user data.
  ///
  Future<ModelUser> getMe({
    required String ip,
  }) async {
    if (_state == XState.loading) {
      return Future.error(const ApiException(XErrors.alreadyLoading));
    }
    state = XState.loading;

    try {
      final user = await UserApi.instance.getMe(ip, cancelToken: _cancelToken);
      if (user != null) {
        this.user = user;
        state = XState.done;
        return user;
      } else {
        state = XState.error;
        return Future.error(const ApiException(XErrors.other));
      }
    } on ApiException catch (e) {
      state = XState.error;
      return Future.error(e);
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
  Future<bool> changePassword({
    required String ip,
    required Map<String, dynamic> data,
  }) async {
    if (_state == XState.loading) return false;
    state = XState.loading;

    try {
      final success = await UserApi.instance.changePasswordFirstLogin(
        ip,
        cancelToken: _cancelToken,
        data: data,
      );
      if (success) {
        state = XState.done;
        return success;
      } else {
        state = XState.error;
        return Future.error(const ApiException(XErrors.other));
      }
    } on ApiException catch (e) {
      state = XState.error;
      return Future.error(e);
    }
  }

  /// Call to cancel any current http requests
  /// Typically called in dispose method.
  void cancel() {
    if (_cancelToken.isCancelled) return;
    _cancelToken.cancel();
  }

  /// Call when logging out to clear current user data
  void clearOnlineData() {
    _user = null;
    notifyListeners();
  }
}
