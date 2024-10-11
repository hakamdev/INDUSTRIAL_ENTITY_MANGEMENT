import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/api/utils/api_exception.dart';
import 'package:oqvt_industrial_entity_management/api/utils/states.dart';
import 'package:oqvt_industrial_entity_management/models/model_user.dart';
import 'package:oqvt_industrial_entity_management/providers/auth_provider.dart';
import 'package:oqvt_industrial_entity_management/screens/change_password_screen.dart';
import 'package:oqvt_industrial_entity_management/screens/main_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/navigation.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';
import 'package:oqvt_industrial_entity_management/utils/validators.dart';
import 'package:oqvt_industrial_entity_management/widgets/app_logo.dart';
import 'package:oqvt_industrial_entity_management/widgets/label.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login_route";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// KEYS & CONTROLLERS
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// STATE
  String email = "";
  String password = "";

  /// UTILS
  void navigateToNextScreen(ModelUser user) {
    if (user.shouldChangePassword == null ||
        user.shouldChangePassword == true) {
      XNavigator.replace(context, by: ChangePasswordScreen.routeName);
    } else {
      XNavigator.replace(context, by: MainScreen.routeName);
    }
  }

  /// CLICK HANDLERS
  void onLoginPressed() async {
    FocusScope.of(context).unfocus();
    if (!XValidators.validateForm(formKey)) return;
    final authProvider = context.read<AuthProvider>();

    try {
      final user = await authProvider.login(
        ip: authProvider.serverIP,
        data: {
          "email": email,
          "password": password,
        },
      );
      navigateToNextScreen(user);
    } on ApiException catch (e) {
      if (mounted) showError(context, error: e.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Column(
                children: [
                  const XAppLogo(
                    logo: "assets/logo_oqvt.png",
                    size: 150,
                  ),
                  const Spacer(),
                  XLabel(
                    label: "Connexion",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    validator: XValidators.email,
                    enabled: authProvider.state != XState.loading,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    onChanged: (v) {
                      setState(() => email = v.trim());
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "prenom.nom@um6p.ma",
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    enabled: authProvider.state != XState.loading,
                    validator: XValidators.password,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    onChanged: (v) {
                      setState(() => password = v.trim());
                    },
                    onFieldSubmitted: (_) => onLoginPressed(),
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "************",
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: authProvider.state != XState.loading
                            ? onLoginPressed
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onSurface,
                          foregroundColor:
                              Theme.of(context).colorScheme.surface,
                        ),
                        child: authProvider.state != XState.loading
                            ? const Text("Se connecter")
                            : const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(),
                              ),
                      )
                      // : const Align(
                      //     alignment: Alignment.center,
                      //     child: Padding(
                      //       padding: EdgeInsets.all(4.0),
                      //       child: CircularProgressIndicator(),
                      //     ),
                      //   ),
                      ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
