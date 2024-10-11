import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/providers/auth_provider.dart';
import 'package:oqvt_industrial_entity_management/screens/login_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/navigation.dart';
import 'package:oqvt_industrial_entity_management/utils/path_finder.dart';
import 'package:provider/provider.dart';

CookieJar initCookies() {
  final cookieJar = PersistCookieJar(
    storage: FileStorage("${XPathFinder.documentsDir.path}/.cookies"),
  );
  return cookieJar;
}

Future logout(BuildContext context) async {
  // final settingsProvider = context.read<SettingsProvider>();
  final authProvider = context.read<AuthProvider>();
  final cookieJar = initCookies();
  await cookieJar.deleteAll();
  // authProvider.clearOnlineData();

  // UserApi.instance.initialized = false;
  // AuthApi.instance.initialized = false;

  if (!context.mounted) return;
  XNavigator.replace(context, by: LoginScreen.routeName);
}
