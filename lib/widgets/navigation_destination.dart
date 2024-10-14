import 'package:flutter/material.dart';

class XNavigationDestination extends StatelessWidget {
  const XNavigationDestination({
    super.key,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.iconSize,
    this.tooltip,
    this.enabled = true,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;

  final double? iconSize;
  final String? tooltip;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
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

    return NavigationDestination(
      icon: Icon(
        icon,
        size: iconSize ?? 24,
        color: color,
      ),
      selectedIcon: selectedIcon != null
          ? Icon(
              selectedIcon!,
              size: iconSize ?? 24,
              color: selectedColor,
            )
          : null,
      label: label,
      enabled: enabled,
      tooltip: tooltip ?? label,
    );
  }
}
