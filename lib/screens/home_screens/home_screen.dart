import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';
import 'package:oqvt_industrial_entity_management/widgets/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      body: _AdaptiveHomeScreenGrid(
        cards: [
          XHomeCard(
            title: "Gestion des équipements",
            description:
                "Some very long description, Some very long description, Some very long description, Some very long description, Some very long description, Some very long description, Some very long description, ",
            icon: Icons.home_repair_service_outlined,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.primaryContainer,
            textColor: Theme.of(context).colorScheme.onPrimary,
          ),
          XHomeCard(
            title: "Gestion des besoins et consommables",
            description:
                "Some very long description, Some very long description, Someeferg  er very long description, Some very long description, Some very long description, Some very long description, Some very long description, ",
            icon: Icons.sign_language_outlined,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
            textColor: Theme.of(context).colorScheme.onSecondary,
          ),
          XHomeCard(
            title: "Gestion des activités",
            description:
                "Some very long description, Some very long description, Some very reg erg erg er fw qdqw fr eg w elong description, Some very long description, Some very long description, Some very long description, Some very long description, ",
            icon: Icons.leaderboard_outlined,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            foregroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            textColor: Theme.of(context).colorScheme.onTertiary,
          ),
          XHomeCard(
            title: "Gestion du capital humain",
            description:
                "Some very long description, Some very long description, ew w ef wef we f wg re fe wfew w   Somereg r ge rg erg er g erg very long description, Some very long description, Some very long description, Some very long description, Some very long description, ",
            icon: Icons.group_outlined,
            backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            foregroundColor: Theme.of(context).colorScheme.secondaryContainer,
            textColor: Theme.of(context).colorScheme.onSecondary,
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
