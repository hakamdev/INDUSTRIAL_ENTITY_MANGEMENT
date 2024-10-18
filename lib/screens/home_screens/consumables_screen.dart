import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:oqvt_industrial_entity_management/api/utils/states.dart';
import 'package:oqvt_industrial_entity_management/data/fake_data.dart';
import 'package:oqvt_industrial_entity_management/screens/detail_screens/equipment_details_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/profile_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/constants.dart';
import 'package:oqvt_industrial_entity_management/utils/navigation.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';
import 'package:oqvt_industrial_entity_management/widgets/app_bar.dart';
import 'package:oqvt_industrial_entity_management/widgets/error_message.dart';
import 'package:oqvt_industrial_entity_management/widgets/fab.dart';
import 'package:oqvt_industrial_entity_management/widgets/label.dart';
import 'package:oqvt_industrial_entity_management/widgets/equipments_list_tile.dart';
import 'package:oqvt_industrial_entity_management/widgets/search_bar.dart';

class ConsumablesScreen extends StatefulWidget {
  const ConsumablesScreen({super.key, this.viewPadding});

  final EdgeInsets? viewPadding;

  @override
  State<ConsumablesScreen> createState() => _ConsumablesScreenState();
}

class _ConsumablesScreenState extends State<ConsumablesScreen>
    with TickerProviderStateMixin {
  late TabController controller = TabController(length: 2, vsync: this);
  int currentTabIndex = 0;
  XState state = XState.initial;
  List<Map<String, dynamic>> consumables = [];

  void onNotificationPressed() async {
    final result = await showNotificationsSheet(
      context,
      title: "Notifications",
    );
  }

  void onFilterPressed() async {
    final result = await showMedFilterSheet(
      context,
      title: "Filter Equipments",
    );
  }

  void onAddEquipmentPressed() {
    // XNavigator.go(context, to: ServeMedsScreen.routeName);
  }

  void onEquipmentPressed(Map<String, dynamic> item) {
    XNavigator.go(context,
        to: EquipmentDetailsScreen.routeName, withArgs: item);
  }

  void onProfilePressed() {
    XNavigator.go(
      context,
      to: ProfileScreen.routeName,
      withArgs: kHeroTagProfilePic,
    );
  }

  void initData() {
    setState(() => state = XState.loading);
    Future.delayed(const Duration(seconds: 1), () {
      consumables = FakeData.consumables
          .where((c) =>
              c["type"] ==
              (currentTabIndex == 0
                  ? FakeData.CONSUMBALE_TYPE_EPI
                  : FakeData.CONSUMBALE_TYPE_EQUIPMENT))
          .toList();
      setState(() => state = XState.done);
    });
  }

  void onTabSwitched(int index) {
    currentTabIndex = index;
    initData();
  }

  double getBodyHeight() {
    return MediaQuery.of(context).size.height -
        (widget.viewPadding?.top ?? 0) -
        (widget.viewPadding?.bottom ?? 0) -
        80 /* NavBar Height */ -
        84 /* AppBar Height */ -
        88 /* SearchBar Height */ -
        40 /* Label Height */ -
        60;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceIsTablet = isTablet(context);
    final isLandscape = isLandscapeOrientation(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
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
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, top: 16),
                      onAvatarPressed: onProfilePressed,
                      onNotificationsPressed: onNotificationPressed,
                    ),
                  ),
                ),
              ),

              SliverAppBar(
                toolbarHeight: 0,
                backgroundColor: Theme.of(context).colorScheme.surface,
                pinned: deviceIsTablet || !isLandscape,
                floating: !deviceIsTablet && isLandscape,
                stretch: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(88 + 100),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 16, top: 16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          XSearchBar(
                            hintText: "Recherchez des equipments...",
                            onTrailingPressed: onFilterPressed,
                            onChanged: (v) {},
                            onSubmitted: (v) {},
                          ),
                          const SizedBox(height: 16),
                          XLabel(
                            label: "Gestion des consommables",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 16),
                          TabBar(
                            controller: controller,
                            onTap: onTabSwitched,
                            dividerHeight: 0,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            unselectedLabelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                            labelColor: Theme.of(context).colorScheme.onPrimary,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            tabs: const [
                              Tab(height: 42, child: Text("EPI")),
                              Tab(height: 42, child: Text("Equipments")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              renderConditionally(context),

              /// Show when loading equip. only
              if (state == XState.loadingMore)
                const SliverPadding(
                  padding: EdgeInsets.only(top: 16, bottom: 24),
                  sliver: SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: XFab(
          label: const Text("Ajouter un consummable"),
          icon: const Icon(Iconsax.add5),
          onPressed: onAddEquipmentPressed,
        ),
      ),
    );
  }

  Widget renderConditionally(BuildContext context) {
    switch (state) {
      case XState.initial:
      case XState.loading:
        return SliverToBoxAdapter(
          child: Container(
            height: getBodyHeight(),
            constraints: const BoxConstraints(maxWidth: 800),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      case XState.error:
        return SliverToBoxAdapter(
          child: Container(
            height: getBodyHeight(),
            constraints: const BoxConstraints(maxWidth: 800),
            child: Center(
              child: XErrorMessage(
                message:
                    "Hello, this is jack, I don't know what the heck is going on but why?",
                onRetryPressed: () {},
              ),
            ),
          ),
        );
      default:
        return SliverList.separated(
          itemBuilder: (context, index) {
            final item = consumables[index];

            return Center(
              child: XEquipmentsListTile(
                index: index,
                title: item["name"],
                subtitle:
                    "${item["quantity"]} total devices in stock, ${item["available"]} available.",
                status: "${item["in_use"]} IN USE",
                onPressed: () => onEquipmentPressed(item),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: consumables.length,
        );
    }
  }
}
