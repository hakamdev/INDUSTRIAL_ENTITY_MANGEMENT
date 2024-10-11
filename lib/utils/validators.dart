import 'package:flutter/cupertino.dart';

class XValidators {
  static bool validateForm(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  static String? email(String? email) {
    String value = email ?? "";
    var error = _checkEmpty("Email", value);
    if (error != null) return error;

    error = !RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value.trim().toLowerCase())
        ? "Email is not valid"
        : null;
    if (error != null) return error;
    return null;
  }

  static String? password(String? pass) {
    String value = pass ?? "";
    var error = _checkEmpty("Password", value);
    if (error != null) return error;
    error = _checkMinLength("Password", value, min: 4);
    if (error != null) return error;
    return null;
  }

  static String? matchingPasswords(
    String? repeatPass,
    String? pass,
  ) {
    String value = pass ?? "";
    String value2 = repeatPass ?? "";
    var error = password(value2);
    if (error != null) return error;
    if (value != value2) return "Passwords don't match";
    return null;
  }

  static String? _checkEmpty(String fieldName, String value) {
    return value.isEmpty ? "$fieldName can't be empty" : null;
  }

  static String? _checkMinLength(
    String fieldName,
    String value, {
    required int min,
  }) {
    return value.length < min
        ? "$fieldName must be at least $min characters long"
        : null;
  }

  static String? _checkMaxLength(
    String fieldName,
    String value, {
    required int max,
  }) {
    return value.length < max
        ? "$fieldName must be a maximum of $max characters"
        : null;
  }

  static String? _checkMinMaxLength(
    String fieldName,
    String value, {
    required int min,
    required int max,
  }) {
    return value.length < min
        ? "$fieldName must be between $min and $max characters long"
        : null;
  }

  static String? _checkAllDigits(String fieldName, String value) {
    return !RegExp(r'^[0-9]+$').hasMatch(value.trim())
        ? "$fieldName must contain digits only"
        : null;
  }

  static String? _checkAllAlpha(String fieldName, String value) {
    return !RegExp(r'^[A-Za-z]+$').hasMatch(value.trim())
        ? "$fieldName must contain digits only"
        : null;
  }
}
