import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/providers/auth_provider.dart';
import 'package:oqvt_industrial_entity_management/screens/change_password_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/detail_screens/equipment_details_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/login_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/main_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/onboarding_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/profile_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/settings_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/splash_screen.dart';
import 'package:oqvt_industrial_entity_management/styles/styles.dart';
import 'package:oqvt_industrial_entity_management/utils/path_finder.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await XPathFinder.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'OQVT Industrial Entity Management',
          debugShowCheckedModeBanner: false,
          routes: {
            OnboardingScreen.routeName: (context) => const OnboardingScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            ChangePasswordScreen.routeName: (context) =>
                const ChangePasswordScreen(),
            MainScreen.routeName: (context) => const MainScreen(),
            ProfileScreen.routeName: (context) => const ProfileScreen(),
            SettingsScreen.routeName: (context) => const SettingsScreen(),
            EquipmentDetailsScreen.routeName: (context) =>
                const EquipmentDetailsScreen(),
          },
          theme: buildTheme(Colors.lightBlue, Brightness.light),
          darkTheme: buildTheme(Colors.lightBlue, Brightness.dark),
          home: const SplashScreen(),
        );
      },
    );
  }
}
