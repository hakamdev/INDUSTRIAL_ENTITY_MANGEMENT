import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';

class XAdaptiveScaffold extends StatelessWidget {
  const XAdaptiveScaffold({
    super.key,
    required this.barDestinations,
    required this.railDestinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.appBar,
    this.body,
    this.fab,
  });

  final List<Widget> barDestinations;
  final List<NavigationRailDestination> railDestinations;
  final int selectedIndex;
  final void Function(int) onDestinationSelected;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? fab;

  @override
  Widget build(BuildContext context) {
    final deviceIsTablet = isTablet(context);

    return Scaffold(
      appBar: appBar,
      body: deviceIsTablet
          ? Row(
              children: [
                NavigationRail(
                  destinations: railDestinations,
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onDestinationSelected,
                ),
                if (body != null) Expanded(child: body!),
              ],
            )
          : body,
      floatingActionButton: fab,
      bottomNavigationBar: !deviceIsTablet
          ? NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              destinations: barDestinations,
            )
          : null,
    );
  }
}
