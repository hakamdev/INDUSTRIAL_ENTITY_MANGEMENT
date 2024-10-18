import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/screens/profile_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/constants.dart';
import 'package:oqvt_industrial_entity_management/utils/navigation.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';
import 'package:oqvt_industrial_entity_management/widgets/app_bar.dart';
import 'package:oqvt_industrial_entity_management/widgets/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onPageChanged,
  });

  final void Function(int) onPageChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        // stretch: true,
        // floating: true,
        // snap: true,
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
      body: _AdaptiveHomeScreenGrid(
        cards: [
          XHomeCard(
            title: "Gestion des équipements",
            description:
                "Suivi en temps réel de l'état, de la disponibilité et de la maintenance des équipements du laboratoire.",
            icon: Icons.home_repair_service_outlined,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.primaryContainer,
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () => widget.onPageChanged(1),
          ),
          XHomeCard(
            title: "Gestion des besoins et consommables",
            description:
                "Gestion des stocks, prévisions des besoins, et automatisation des commandes pour assurer une disponibilité continue des ressources nécessaires.",
            icon: Icons.sign_language_outlined,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
            textColor: Theme.of(context).colorScheme.onSecondary,
            onPressed: () => widget.onPageChanged(2),
          ),
          XHomeCard(
            title: "Gestion des activités",
            description:
                "Planification, suivi et compte rendu des missions, avec une coordination automatisée pour vérifier la disponibilité des équipements et consommables nécessaires.",
            icon: Icons.leaderboard_outlined,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            foregroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            textColor: Theme.of(context).colorScheme.onTertiary,
            onPressed: () => widget.onPageChanged(3),
          ),
          XHomeCard(
            title: "Gestion du capital humain",
            description:
                "Suivi des compétences, gestion des plannings et disponibilité du personnel, avec des notifications pour les formations et certifications.",
            icon: Icons.group_outlined,
            backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
            textColor: Theme.of(context).colorScheme.onSecondary,
            onPressed: () => widget.onPageChanged(4),
          ),
        ],
      ),
    );
  }
}

class _AdaptiveHomeScreenGrid extends StatelessWidget {
  const _AdaptiveHomeScreenGrid({super.key, required this.cards});

  final List<Widget> cards;

  Map<String, List<Widget>> divideCards() {
    final oddCards = <Widget>[];
    final evenCards = <Widget>[];

    for (int i = 0; i < cards.length; i++) {
      if (i % 2 == 0) {
        evenCards.add(cards[i]);
      } else {
        oddCards.add(cards[i]);
      }
    }

    return {"odd_cards": oddCards, "even_cards": evenCards};
  }

  List<Widget> addSpacingToCards(
    List<Widget> cards,
    double spacing,
    bool isLandscape,
  ) {
    List<Widget> spacedCards = [];

    for (int i = 0; i < cards.length; i++) {
      spacedCards.add(Expanded(child: cards[i]));
      if (i < cards.length - 1) {
        spacedCards.add(SizedBox(
          height: !isLandscape ? spacing : 0,
          width: isLandscape ? spacing : 0,
        ));
      }
    }
    return spacedCards;
  }

  @override
  Widget build(BuildContext context) {
    final deviceIsTablet = isTablet(context);
    final isLandscape = isLandscapeOrientation(context);

    const double spacing = 16;
    const double largeSpacing = 32;

    if (!deviceIsTablet && !isLandscape) {
      return Padding(
        padding: const EdgeInsets.all(spacing),
        child: Column(
          children: addSpacingToCards(cards, spacing, isLandscape),
        ),
      );
    } else if (!deviceIsTablet && isLandscape) {
      return Padding(
        padding: const EdgeInsets.all(spacing),
        child: Row(
          children: addSpacingToCards(cards, spacing, isLandscape),
        ),
      );
    } else {
      final dividedCards = divideCards();
      final oddCards = dividedCards["odd_cards"] ?? [];
      final evenCards = dividedCards["even_cards"] ?? [];
      return Padding(
        padding: const EdgeInsets.all(largeSpacing),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: addSpacingToCards(evenCards, largeSpacing, false),
              ),
            ),
            const SizedBox(width: largeSpacing),
            Expanded(
              child: Column(
                children: addSpacingToCards(oddCards, largeSpacing, false),
              ),
            ),
          ],
        ),
      );
    }
  }
}
