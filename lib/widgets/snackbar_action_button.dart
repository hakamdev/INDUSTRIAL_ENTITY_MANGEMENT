import 'package:flutter/material.dart';

class XSnackBarActionButton extends StatelessWidget {
  const XSnackBarActionButton({
    super.key,
    required this.label,
    this.icon,
    this.foregroundColor,
    this.backgroundColor,
    this.onPressed,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor ??
            Theme.of(context).colorScheme.onError.withAlpha(200),
        backgroundColor: backgroundColor ??
            Theme.of(context).colorScheme.onError.withAlpha(80),
        // TODO:
        // textStyle: XTheme.defaultFont(
        //   textStyle: Theme.of(context).textTheme.bodyMedium,
        //   fontWeight: FontWeight.w600,
        // ),
        visualDensity: VisualDensity.compact,
      ),
      label: Text(label),
      icon: Icon(icon ?? Icons.replay_rounded, size: 20),
    );
  }
}
