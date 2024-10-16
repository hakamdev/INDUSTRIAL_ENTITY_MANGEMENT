import 'package:flutter/material.dart';
import 'package:oqvt_industrial_entity_management/api/utils/api_exception.dart';
import 'package:oqvt_industrial_entity_management/api/utils/states.dart';
import 'package:oqvt_industrial_entity_management/providers/auth_provider.dart';
import 'package:oqvt_industrial_entity_management/screens/main_screen.dart';
import 'package:oqvt_industrial_entity_management/utils/cookies.dart';
import 'package:oqvt_industrial_entity_management/utils/navigation.dart';
import 'package:oqvt_industrial_entity_management/utils/ui_utils.dart';
import 'package:oqvt_industrial_entity_management/utils/validators.dart';
import 'package:oqvt_industrial_entity_management/widgets/app_logo.dart';
import 'package:oqvt_industrial_entity_management/widgets/label.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String routeName = "change_password_route";

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  /// KEYS & CONTROLLERS
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  /// STATE
  String password1 = "";
  String password2 = "";

  /// UTILS
  void navigateToNextScreen(bool success) {
    if (success) {
      XNavigator.replace(context, by: MainScreen.routeName);
    }
  }

  /// CLICK HANDLERS
  void onChangePasswordPressed() async {
    FocusScope.of(context).unfocus();
    if (!XValidators.validateForm(formKey)) return;
    final authProvider = context.read<AuthProvider>();

    try {
      final success = await authProvider.changePassword(
        ip: authProvider.serverIP,
        data: {
          "newPassword": password1,
          "confirmNewPassword": password2,
        },
      );
      navigateToNextScreen(success);
    } on ApiException catch (e) {
      if (mounted) showError(context, error: e.error);
    }
  }

  void onLogoutPressed() {
    // TODO: add dialog
    logout(context);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: _ChangePasswordAdaptiveForm(
          formKey: formKey,
          appLogo: const XAppLogo(
            logo: "assets/logo_oqvt.png",
            size: 200,
          ),
          label: XLabel(
            label: "Connexion",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          emailTextField: TextFormField(
            controller: password1Controller,
            enabled: authProvider.state != XState.loading,
            validator: XValidators.password,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            obscureText: true,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (v) {
              setState(() => password1 = v.trim());
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "************",
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 1.5,
                ),
              ),
            ),
          ),
          passwordTextField: TextFormField(
            controller: password2Controller,
            enabled: authProvider.state != XState.loading,
            validator: (val) => XValidators.matchingPasswords(val, password1),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            obscureText: true,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (v) {
              setState(() => password2 = v.trim());
            },
            onFieldSubmitted: (_) => onChangePasswordPressed(),
            decoration: InputDecoration(
              labelText: "Repeat Password",
              hintText: "************",
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 1.5,
                ),
              ),
            ),
          ),
          loginButton: FilledButton(
            onPressed: authProvider.state != XState.loading
                ? onChangePasswordPressed
                : null,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              foregroundColor: Theme.of(context).colorScheme.surface,
            ),
            child: authProvider.state != XState.loading
                ? const Text("Update password")
                : const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }
}

class _ChangePasswordAdaptiveForm extends StatelessWidget {
  const _ChangePasswordAdaptiveForm({
    super.key,
    required this.formKey,
    required this.appLogo,
    required this.label,
    required this.emailTextField,
    required this.passwordTextField,
    required this.loginButton,
  });

  final GlobalKey<FormState> formKey;
  final Widget appLogo;
  final Widget label;
  final Widget emailTextField;
  final Widget passwordTextField;
  final Widget loginButton;

  Widget getViewByOrientation(BuildContext context) {
    final isLandscape = isLandscapeOrientation(context);
    if (isLandscape) return getLandscapeView(context);
    return getPortraitView(context);
  }

  Widget getPortraitView(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: getLongestSize(context),
            minHeight: getLongestSize(context),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(child: appLogo),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        constraints:
                            const BoxConstraints(maxWidth: 500, maxHeight: 500),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Column(
                          children: [
                            const Spacer(),
                            label,
                            const SizedBox(height: 24),
                            emailTextField,
                            const SizedBox(height: 24),
                            passwordTextField,
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: loginButton,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLandscapeView(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height,
            minHeight: MediaQuery.sizeOf(context).height,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Row(
                  children: [
                    Expanded(child: appLogo),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        constraints:
                            const BoxConstraints(maxWidth: 500, maxHeight: 500),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Column(
                          children: [
                            const Spacer(),
                            label,
                            const SizedBox(height: 24),
                            emailTextField,
                            const SizedBox(height: 24),
                            passwordTextField,
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: loginButton,
                              // FilledButton(
                              //   onPressed: authProvider.state != XState.loading
                              //       ? onLoginPressed
                              //       : null,
                              //   style: FilledButton.styleFrom(
                              //     backgroundColor:
                              //     Theme.of(context).colorScheme.onSurface,
                              //     foregroundColor:
                              //     Theme.of(context).colorScheme.surface,
                              //   ),
                              //   child: authProvider.state != XState.loading
                              //       ? const Text("Se connecter")
                              //       : const SizedBox(
                              //     height: 24,
                              //     width: 24,
                              //     child: CircularProgressIndicator(),
                              //   ),
                              // ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getViewByOrientation(context);
  }
}
