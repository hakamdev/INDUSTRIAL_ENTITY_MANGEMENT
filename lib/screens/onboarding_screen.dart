import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/providers/auth_provider.dart';
import 'package:oqvt_industrial_entity_management/screens/change_password_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/main_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/cookies.dart';
import 'package:oqvt_industrial_entity_management/utils/navigation.dart';
import 'package:oqvt_industrial_entity_management/widgets/app_logo.dart';
import 'package:oqvt_industrial_entity_management/widgets/label.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = "onboarding_route";

  @override
  State<OnboardingScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardingScreen> {
  void navigateToNextScreen(AuthProvider authProvider) async {
    final isLoggedIn = authProvider.user != null;
    final isFirstLogin = authProvider.user?.shouldChangePassword ?? true;
    if (!mounted) return;
    authProvider.firstTimeOpeningApp = false;
    if (isLoggedIn) {
      if (isFirstLogin) {
        XNavigator.replace(context, by: ChangePasswordScreen.routeName);
      } else {
        XNavigator.replace(context, by: MainScreen.routeName);
      }
    } else {
      logout(context);
    }
  }

  void onGetStartedPressed() {
    final authProvider = context.read<AuthProvider>();
    navigateToNextScreen(authProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.inversePrimary,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 16),
            child: Column(
              children: [
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const XAppLogo(logo: "assets/logo_oqvt.png"),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                XLabel(
                  label: "Welcome to the industrial entity application",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  align: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const XLabel(
                  label:
                      "This app is for managing the laboratory equipment and "
                      "is exclusively reserved for the Industrial entity's "
                      "team.",
                  align: TextAlign.center,
                ),
                const SizedBox(height: 42),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: min(200, MediaQuery.sizeOf(context).width * 0.5),
                    maxWidth: 200,
                  ),
                  child: FilledButton(
                    onPressed: onGetStartedPressed,
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                    ),
                    child: const Text("GET STARTED"),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
