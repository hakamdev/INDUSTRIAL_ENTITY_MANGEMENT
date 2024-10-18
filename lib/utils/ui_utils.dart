import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/api/utils/errors.dart';
import 'package:oqvt_industrial_entity_management/sheets/drop_down_list_sheet.dart';
import 'package:oqvt_industrial_entity_management/sheets/meds_filter_sheet.dart';
import 'package:oqvt_industrial_entity_management/sheets/notifications_sheet.dart';
import 'package:oqvt_industrial_entity_management/widgets/snackbar_action_button.dart';

void showError(BuildContext context, {required XErrors<String> error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error.message),
      backgroundColor: Theme.of(context).colorScheme.error,
      showCloseIcon: true,
    ),
  );
}

void showErrorMessage(BuildContext context,
    {required String message, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Theme.of(context).colorScheme.error,
      showCloseIcon: true,
    ),
  );
}

void showRetryError(
  BuildContext context, {
  required XErrors<String> error,
  VoidCallback? onRetry,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(error.message),
          XSnackBarActionButton(
            label: "Retry",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              onRetry?.call();
            },
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      backgroundColor: Theme.of(context).colorScheme.error,
      duration: const Duration(minutes: 60),
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

Future<T1?> showOptionsList<T1>(
  BuildContext context, {
  required String title,
  required List<T1> options,
  String Function(T1)? getOptionText,
  T1? selected,
}) async {
  return showModalBottomSheet<T1>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    // backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    builder: (context) {
      return DropDownListSheet(
        title: title,
        options: options,
        getOptionText: getOptionText,
        selected: selected,
      );
    },
  );
}

Future<T1?> showNotificationsSheet<T1>(
  BuildContext context, {
  required String title,
  // String Function(T1)? getOptionText,
  // T1? selected,
}) async {
  return showModalBottomSheet<T1>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return NotificationsSheet(
        title: title,
      );
    },
  );
}

Future<T1?> showMedFilterSheet<T1>(
  BuildContext context, {
  required String title,
  // String Function(T1)? getOptionText,
  // T1? selected,
}) async {
  return showModalBottomSheet<T1>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return MedsFilterSheet(
        title: title,
      );
    },
  );
}
