import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/styles/styles.dart';

class XEquipmentsListTile extends StatelessWidget {
  const XEquipmentsListTile({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.status,
    this.constraints,
    this.onPressed,
  });

  final int index;
  final String title;
  final String subtitle;
  final String status;
  final BoxConstraints? constraints;
  final VoidCallback? onPressed;

  // TODO: might need this don't delete
//   String getDatesString() {
//     if (dates.length > 1) {
//       return """${dates.first.toString().split(" ").first.replaceAll("-", "/")}
// ${dates.last.toString().split(" ").first.replaceAll("-", "/")}""";
//     } else {
//       return dates.first.toString().split(" ").first;
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints ?? const BoxConstraints(maxWidth: 800),
      child: ListTile(
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.tertiary.withAlpha(15),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            "STATUS\n$status",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                  height: 1.7,
                ),
          ),
        ),
        onTap: onPressed,
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.tertiary,
            ),
        subtitleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        contentPadding: const EdgeInsets.only(left: 24, right: 24),
        tileColor: index % 2 == 0 ? XColors.colorBlue.withAlpha(10) : null,
      ),
    );
  }
}
