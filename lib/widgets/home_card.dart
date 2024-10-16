import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';

class XHomeCard extends StatelessWidget {
  const XHomeCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final deviceIsTablet = isTablet(context);
    final deviceIsLandscape = isLandscapeOrientation(context);
    // final isWide = (!deviceIsTablet && !deviceIsLandscape) ||
    //     (deviceIsTablet && deviceIsLandscape);
    final titleStyle = deviceIsTablet
        ? Theme.of(context).textTheme.titleLarge
        : Theme.of(context).textTheme.titleMedium;

    final descStyle = deviceIsTablet
        ? Theme.of(context).textTheme.bodyLarge
        : Theme.of(context).textTheme.bodySmall;

    final padding = deviceIsTablet ? 24.0 : 16.0;
    final textSpacing = deviceIsTablet ? 8.0 : 4.0;
    final iconSize = deviceIsTablet ? 32.0 : 24.0;

    final cardIcon = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: foregroundColor ?? Colors.yellow,
          width: 2,
        ),
      ),
      child: Icon(
        icon,
        color: foregroundColor ?? Colors.yellow,
        size: iconSize,
      ),
    );
    final cardArrowIcon = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: foregroundColor ?? Colors.yellow,
      ),
      child: Icon(
        Icons.arrow_forward_rounded,
        color: backgroundColor,
        size: iconSize,
      ),
    );

    return Material(
      color: backgroundColor ?? Colors.yellow,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(24),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  if (deviceIsTablet)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [cardIcon],
                    ),
                  if (deviceIsTablet) const SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!deviceIsTablet)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: cardIcon,
                          ),
                        if (!deviceIsTablet) const SizedBox(width: 16),
                        Expanded(
                            child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: titleStyle?.copyWith(
                                  color: textColor ?? Colors.yellow,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: textSpacing),
                              Text(
                                description,
                                overflow: TextOverflow.fade,
                                style: descStyle?.copyWith(
                                  color: (textColor ?? Colors.yellow)
                                      .withAlpha(150),
                                ),
                              ),
                            ],
                          ),
                        )),
                        if (!deviceIsTablet && !deviceIsLandscape)
                          const SizedBox(width: 16),
                        if (!deviceIsTablet && !deviceIsLandscape)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [cardArrowIcon],
                          ),
                      ],
                    ),
                  ),
                  if (deviceIsTablet) const SizedBox(height: 12),
                  if (deviceIsTablet)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [cardArrowIcon],
                    ),
                ],
              ),
            )),
      ),
    );
  }
}
