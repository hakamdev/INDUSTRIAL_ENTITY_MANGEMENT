import 'package:flutter/material.dart';

class XLabel extends StatelessWidget {
  const XLabel({
    super.key,
    required this.label,
    this.style,
    this.maxLines,
    this.align,
  });

  final String label;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        label,
        style: style,
        textAlign: align,
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
      ),
    );
  }
}
