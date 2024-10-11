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
