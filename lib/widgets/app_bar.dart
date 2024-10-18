import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/styles/styles.dart';
import 'package:oqvt_industrial_entity_management/utils/constants.dart';
import 'package:oqvt_industrial_entity_management/widgets/label.dart';
import 'package:oqvt_industrial_entity_management/widgets/notifications_button.dart';

class XAppBar extends StatelessWidget {
  const XAppBar({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.healthCenter,
    required this.notificationsCount,
    this.onAvatarPressed,
    this.onNotificationsPressed,
    this.avatarSize,
    this.padding,
  });

  final String avatarUrl;
  final String name;
  final String healthCenter;
  final int notificationsCount;
  final VoidCallback? onAvatarPressed;
  final VoidCallback? onNotificationsPressed;

  final double? avatarSize;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(24),
      child: Row(
        children: [
          InkWell(
            onTap: onAvatarPressed,
            customBorder: const CircleBorder(),
            child: Hero(
              tag: kHeroTagProfilePic,
              child: CircleAvatar(
                radius: avatarSize ?? 28,
                backgroundColor: Colors.black,
                foregroundImage: NetworkImage(avatarUrl),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text.rich(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Bonjour",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(150),
                          ),
                        ),
                        const TextSpan(text: " "),
                        TextSpan(text: "$name,"),
                        const TextSpan(text: " 👋"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                XLabel(
                  label: healthCenter,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          XNotificationsButton(
            notificationsCount: notificationsCount,
            color: XColors.colorBlue,
            onPressed: onNotificationsPressed,
          ),
        ],
      ),
    );
  }
}
