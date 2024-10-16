import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/screens/home_screens/activities_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/home_screens/consumables_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/home_screens/equipments_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/home_screens/home_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/home_screens/people_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/string_extension.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';
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

  final screens = [];

  List<Map<String, dynamic>> tabs = [
    {
      "label": "Home",
      "icon": Icons.home_outlined,
      "selected_icon": Icons.home,
    },
    {
      "label": "Equipments",
      "icon": Icons.home_repair_service_outlined,
      "selected_icon": Icons.home_repair_service,
    },
    {
      "label": "Consommables",
      "icon": Icons.sign_language_outlined,
      "selected_icon": Icons.sign_language,
    },
    {
      "label": "Activities",
      "icon": Icons.leaderboard_outlined,
      "selected_icon": Icons.leaderboard,
    },
    {
      "label": "People",
      "icon": Icons.group_outlined,
      "selected_icon": Icons.group,
    },
  ];

  Widget getScreen1(BuildContext context) {
    return const HomeScreen();
  }

  Widget getScreen2(BuildContext context) {
    return const EquipmentsScreen();
  }

  Widget getScreen3(BuildContext context) {
    return const ConsumablesScreen();
  }

  Widget getScreen4(BuildContext context) {
    return const ActivitiesScreen();
  }

  Widget getScreen5(BuildContext context) {
    return const PeopleScreen();
  }

  @override
  void initState() {
    screens
        .addAll([getScreen1, getScreen2, getScreen3, getScreen4, getScreen5]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceIsTablet = isTablet(context);
    final isLandscape = isLandscapeOrientation(context);

    return XAdaptiveScaffold(
      body: screens[currentScreenIndex](context),
      barDestinations: [
        for (final tab in tabs)
          XNavigationDestination(
            label: (tab["label"] as String).ellipsis(
                (deviceIsTablet && !isLandscape) ||
                        (!deviceIsTablet && isLandscape)
                    ? 15
                    : 10),
            icon: tab["icon"],
            selectedIcon: tab["selected_icon"] ?? tab["icon"],
          ),
      ],
      railDestinations: [
        for (final tab in tabs)
          XRailDestination(
            context: context,
            label: (tab["label"] as String).ellipsis(),
            icon: tab["icon"],
            selectedIcon: tab["selected_icon"] ?? tab["icon"],
          ),
      ],
      selectedIndex: currentScreenIndex,
      onDestinationSelected: (index) =>
          setState(() => currentScreenIndex = index),
    );
  }
}
