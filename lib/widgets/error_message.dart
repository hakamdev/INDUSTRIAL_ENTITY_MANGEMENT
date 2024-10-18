import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:oqvt_industrial_entity_management/widgets/label.dart';

class XErrorMessage extends StatelessWidget {
  const XErrorMessage({
    super.key,
    required this.message,
    this.icon,
    this.onRetryPressed,
    this.showRetry = true,
  });

  final String message;
  final Icon? icon;
  final VoidCallback? onRetryPressed;
  final bool showRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconTheme(
          data: IconThemeData(
            color: Theme.of(context).colorScheme.error,
            size: 42,
          ),
          child: icon ?? const Icon(Iconsax.wifi_square),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: XLabel(
            label: message,
            maxLines: 4,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(200)),
            align: TextAlign.center,
          ),
        ),
        if (showRetry) const SizedBox(height: 24),
        if (showRetry)
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 140),
            child: FilledButton.tonal(
              onPressed: onRetryPressed,
              style: FilledButton.styleFrom(
                visualDensity: VisualDensity.compact,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text("Retry"),
            ),
          ),
      ],
    );
  }
}
