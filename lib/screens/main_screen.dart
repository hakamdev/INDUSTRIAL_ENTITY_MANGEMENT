import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/widgets/adaptive_scaffold.dart';
import 'package:oqvt_industrial_entity_management/widgets/navigation_destination.dart';
import 'package:oqvt_industrial_entity_management/widgets/rail_destination.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = "main_route";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return XAdaptiveScaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Container(),
      barDestinations: const [
        XNavigationDestination(
          label: "Home",
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
        ),
        XNavigationDestination(
          label: "Equipments",
          icon: Icons.equalizer,
          selectedIcon: Icons.equalizer,
        ),
        XNavigationDestination(
          label: "Consomm...",
          icon: Icons.equalizer,
          selectedIcon: Icons.equalizer,
        ),
        XNavigationDestination(
          label: "Activities",
          icon: Icons.equalizer,
          selectedIcon: Icons.equalizer,
        ),
        XNavigationDestination(
          label: "People",
          icon: Icons.equalizer,
          selectedIcon: Icons.equalizer,
        ),
      ],
      railDestinations: [
        XRailDestination(
          context: context,
          label: "Home",
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
        ),
        XRailDestination(
          context: context,
          label: "Equipments",
          icon: Icons.equalizer,
          selectedIcon: Icons.equalizer,
        ),
        XRailDestination(
          context: context,
          label: "Consomm...",
          icon: Icons.equalizer,
          selectedIcon: Icons.equalizer,
        ),
        XRailDestination(
          context: context,
          label: "Activities",
          icon: Icons.equalizer,
          selectedIcon: Icons.equalizer,
        ),
        XRailDestination(
          context: context,
          label: "People",
          icon: Icons.equalizer,
          selectedIcon: Icons.equalizer,
        ),
      ],
      selectedIndex: currentScreenIndex,
      onDestinationSelected: (index) =>
          setState(() => currentScreenIndex = index),
    );
  }
}
