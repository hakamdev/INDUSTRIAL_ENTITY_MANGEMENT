import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oqvt_industrial_entity_management/api/utils/api_exception.dart';
import 'package:oqvt_industrial_entity_management/api/utils/errors.dart';
import 'package:oqvt_industrial_entity_management/api/utils/states.dart';
import 'package:oqvt_industrial_entity_management/providers/auth_provider.dart';
import 'package:oqvt_industrial_entity_management/screens/change_password_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/main_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/onboarding_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/cookies.dart';
import 'package:oqvt_industrial_entity_management/utils/navigation.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';
import 'package:oqvt_industrial_entity_management/widgets/app_logo.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "splash_route";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? loginTimer;

  void navigateToNextScreen(AuthProvider authProvider) async {
    final isLoggedIn = authProvider.user != null;
    final isFirstLogin = authProvider.user?.shouldChangePassword ?? true;
    if (!mounted) return;
    if (authProvider.firstTimeOpeningApp) {
      XNavigator.replace(context, by: OnboardingScreen.routeName);
      return;
    }
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

  double? getLoadingValue(XState state) {
    switch (state) {
      case XState.error:
      case XState.done:
      case XState.empty:
        return 1;
      case XState.initial:
      case XState.loading:
      case XState.loadingMore:
        return null;
    }
  }

  void onDelayedInitUserData([Duration duration = const Duration(seconds: 2)]) {
    loginTimer?.cancel();
    loginTimer = Timer(duration, () => onInitUserData());
  }

  void onInitUserData() async {
    final authProvider = context.read<AuthProvider>();
    authProvider.clearOnlineData();

    try {
      await authProvider.getMe(ip: authProvider.serverIP);
      navigateToNextScreen(authProvider);
    } on ApiException catch (e) {
      if (e.error == XErrors.noCookie || e.error == XErrors.unauthorized) {
        navigateToNextScreen(authProvider);
        return;
      }
      if (mounted) {
        showError(context, error: e.error);
      }
    }
  }

  void initSystemChrome() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initSystemChrome();
      onDelayedInitUserData();
    });
    super.initState();
  }

  @override
  void dispose() {
    loginTimer?.cancel();
    loginTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Container(
        width: double.infinity,
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
                const Spacer(),
                const Spacer(),
                const XAppLogo(logo: "assets/logo_oqvt.png"),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                renderLoadingOrError(context, authProvider),
                const Spacer(),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderLoadingOrError(BuildContext context, AuthProvider authProvider) {
    switch (authProvider.state) {
      case XState.error:
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.sizeOf(context).width * 0.4,
          ),
          child: FilledButton.tonalIcon(
            onPressed: onInitUserData,
            style: FilledButton.styleFrom(
                // backgroundColor: Theme.of(context).colorScheme.error,
                // foregroundColor: Theme.of(context).colorScheme.errorContainer,
                ),
            label: const Text("Retry"),
          ),
        );
      default:
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.4,
          ),
          child: const CircularProgressIndicator(strokeCap: StrokeCap.round),
        );
    }
  }
}
