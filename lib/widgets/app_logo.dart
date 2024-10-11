import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/utils/constants.dart';

class XAppLogo extends StatelessWidget {
  const XAppLogo({
    super.key,
    required this.logo,
    this.size,
    this.heroTag,
  });

  final String logo;
  final double? size;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag ?? kLogoHeroTag,
      child: Image.asset(logo, height: size),
    );
  }
}
