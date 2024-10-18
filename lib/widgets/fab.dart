import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/styles/styles.dart';

class XFab extends StatelessWidget {
  const XFab({
    super.key,
    required this.label,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.heroTag,
    this.onPressed,
  });

  final Text label;
  final Icon icon;
  final Object? heroTag;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: label,
      icon: icon,
      heroTag: heroTag,
      extendedTextStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.w600),
      backgroundColor: backgroundColor ??
          (Theme.of(context).brightness == Brightness.light
              ? XColors.colorBlue
              : Theme.of(context).colorScheme.inversePrimary),
      foregroundColor: foregroundColor ?? Colors.white,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
    );
  }
}
