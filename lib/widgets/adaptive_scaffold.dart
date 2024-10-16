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
    final isLandscape = isLandscapeOrientation(context);

    return Scaffold(
      appBar: !deviceIsTablet ? appBar : null,
      body: deviceIsTablet && isLandscape
          ? Row(
              children: [
                NavigationRail(
                  // leading: Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  //   child: Image.asset(
                  //     "assets/logo_oqvt.png",
                  //     width: 80,
                  //   ),
                  // ),
                  destinations: railDestinations,
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onDestinationSelected,
                  labelType: NavigationRailLabelType.all,
                  minWidth: 10,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainer,
                  trailing: Expanded(
                    child: Column(
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.error,
                              backgroundColor:
                                  Theme.of(context).colorScheme.errorContainer,
                              padding: const EdgeInsets.all(12)),
                          icon: const Icon(
                            Icons.logout_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (body != null)
                  Expanded(
                    child: Scaffold(
                      appBar: appBar,
                      body: body,
                    ),
                  ),
              ],
            )
          : body,
      floatingActionButton: fab,
      bottomNavigationBar: !deviceIsTablet || !isLandscape
          ? NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              destinations: barDestinations,
            )
          : null,
    );
  }
}
