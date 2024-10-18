import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XNotificationsButton extends StatelessWidget {
  const XNotificationsButton({
    super.key,
    required this.notificationsCount,
    this.onPressed,
    this.color,
    this.backgroundColor,
  });

  final int notificationsCount;
  final VoidCallback? onPressed;

  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Color clr = color ?? Theme.of(context).colorScheme.primary;

    return Badge(
      isLabelVisible: notificationsCount > 0,
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
      label: Text("$notificationsCount"),
      child: IconButton.filledTonal(
        onPressed: onPressed,
        icon: const Icon(Iconsax.notification),
        padding: const EdgeInsets.all(12),
        style: IconButton.styleFrom(
          foregroundColor: clr,
          backgroundColor: backgroundColor ?? clr.withAlpha(40),
          shape: const CircleBorder(),
          // RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
          // ContinuousRectangleBorder(
          //   borderRadius: BorderRadius.circular(40)
          // )
        ),
      ),
    );
  }
}
