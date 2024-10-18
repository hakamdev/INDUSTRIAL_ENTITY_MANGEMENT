import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/widgets/label.dart';

class NotificationsSheet extends StatelessWidget {
  const NotificationsSheet({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            XLabel(
              label: title,
              maxLines: 1,
              align: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}