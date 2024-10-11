import 'package:flutter/material.dart';

class XNavigator {
  static Future<T?> go<T>(BuildContext context,
      {required String to, Object? withArgs}) {
    return Navigator.of(context).pushNamed<T>(to, arguments: withArgs);
  }

  static Future<T?> replace<T, T0>(BuildContext context,
      {required String by, Object? withArgs}) {
    return Navigator.of(context)
        .pushReplacementNamed<T, T0>(by, arguments: withArgs);
  }
}
