import 'package:flutter/material.dart';

NavigationRailDestination XRailDestination({
  required BuildContext context,
  required String label,
  required IconData icon,
  IconData? selectedIcon,
  double? iconSize,
  String? tooltip,
  bool enabled = true,
}) {
  Color? color = enabled
      ? Theme.of(context).navigationBarTheme.iconTheme?.resolve({})?.color
      : Theme.of(context)
          .navigationBarTheme
          .iconTheme
          ?.resolve({WidgetState.disabled})?.color;

  Color? selectedColor = enabled
      ? Theme.of(context)
          .navigationBarTheme
          .iconTheme
          ?.resolve({WidgetState.selected})?.color
      : Theme.of(context)
          .navigationBarTheme
          .iconTheme
          ?.resolve({WidgetState.selected, WidgetState.disabled})?.color;

  return NavigationRailDestination(
    icon: Icon(
      icon,
      size: iconSize ?? 24,
      color: color,
    ),
    selectedIcon: selectedIcon != null
        ? Icon(
            selectedIcon,
            size: iconSize ?? 24,
            color: selectedColor,
          )
        : null,
    label: Text(label),
    disabled: !enabled,
  );
}
