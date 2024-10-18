import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:oqvt_industrial_entity_management/screens/profile_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/constants.dart';
import 'package:oqvt_industrial_entity_management/utils/navigation.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';
import 'package:oqvt_industrial_entity_management/widgets/app_bar.dart';
import 'package:oqvt_industrial_entity_management/widgets/fab.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key, this.viewPadding});

  final EdgeInsets? viewPadding;

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  void onNotificationPressed() async {
    final result = await showNotificationsSheet(
      context,
      title: "Notifications",
    );
  }

  void onProfilePressed() {
    XNavigator.go(
      context,
      to: ProfileScreen.routeName,
      withArgs: kHeroTagProfilePic,
    );
  }

  void onAddPressed() {

  }

  double getBodyHeight() {
    final deviceIsTablet = isTablet(context);
    final isLandscape = isLandscapeOrientation(context);

    if (!deviceIsTablet && isLandscape) {
      return MediaQuery.of(context).size.height -
          (widget.viewPadding?.top ?? 0) -
          (widget.viewPadding?.bottom ?? 0) -
          80 /* NavBar Height */;
    }

    if (deviceIsTablet && isLandscape) {
      return MediaQuery.of(context).size.height -
          (widget.viewPadding?.top ?? 0) -
          (widget.viewPadding?.bottom ?? 0) -
          // 80 /* NavBar Height */ -
          84; /* AppBar Height */
    }

    return MediaQuery.of(context).size.height -
        (widget.viewPadding?.top ?? 0) -
        (widget.viewPadding?.bottom ?? 0) -
        80 /* NavBar Height */ -
        84; /* AppBar Height */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// app bar
          SliverAppBar(
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            stretch: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(84),
              child: Material(
                child: XAppBar(
                  avatarUrl:
                      // "https://avatar.iran.liara.run/public/job/doctor/male",
                      "https://avatar.iran.liara.run/public/boy",
                  name: "Abd Elkebir",
                  healthCenter: "OQVT - Ben Guerir",
                  notificationsCount: 10,
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                  onAvatarPressed: onProfilePressed,
                  onNotificationsPressed: onNotificationPressed,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: getBodyHeight(),
              child: SfCalendar(
                firstDayOfWeek: DateTime.monday,
                view: CalendarView.month,
                headerStyle: CalendarHeaderStyle(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
                // headerHeight: 0,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: XFab(
        label: const Text("Ajouter une planification"),
        icon: const Icon(Iconsax.add5),
        onPressed: onAddPressed,
      ),
    );
  }
}
