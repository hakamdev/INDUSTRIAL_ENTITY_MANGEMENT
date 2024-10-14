import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/api/utils/errors.dart';

void showError(BuildContext context, {required XErrors<String> error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error.message),
      backgroundColor: Theme.of(context).colorScheme.error,
      showCloseIcon: true,
    ),
  );
}

double getLongestSize(BuildContext context) {
  return MediaQuery.sizeOf(context).longestSide;
}

bool isLandscapeOrientation(BuildContext context) {
  return MediaQuery.sizeOf(context).width > MediaQuery.sizeOf(context).height;
}

bool isTablet(BuildContext context) {
  var shortestSize = MediaQuery.sizeOf(context).shortestSide;
  return shortestSize >= 600;
}
