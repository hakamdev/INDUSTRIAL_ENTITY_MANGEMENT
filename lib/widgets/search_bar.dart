import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XSearchBar extends StatelessWidget {
  const XSearchBar({
    super.key,
    required this.hintText,
    this.leadingIcon,
    this.trailingIcon,
    this.showTrailing = true,
    this.onChanged,
    this.onSubmitted,
    this.onTrailingPressed,
    this.padding,
  });

  final String hintText;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final bool showTrailing;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTrailingPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: hintText,
      autoFocus: false,
      leading: leadingIcon ?? const Icon(Iconsax.search_normal_1),
      trailing: showTrailing
          ? [
              IconButton(
                onPressed: onTrailingPressed,
                icon: trailingIcon ?? const Icon(Iconsax.sort),
              ),
            ]
          : null,
      padding: padding != null
          ? WidgetStatePropertyAll(padding!)
          : const WidgetStatePropertyAll(EdgeInsets.only(left: 16, right: 8)),
      elevation: const WidgetStatePropertyAll(0),
      hintStyle: WidgetStatePropertyAll(
        Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(120)),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
