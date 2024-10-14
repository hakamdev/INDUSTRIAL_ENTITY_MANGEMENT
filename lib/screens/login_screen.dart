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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        body: _LoginAdaptiveForm(
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
            controller: emailController,
            validator: XValidators.email,
            enabled: authProvider.state != XState.loading,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
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
          passwordTextField: TextFormField(
            controller: passwordController,
            enabled: authProvider.state != XState.loading,
            validator: XValidators.password,
            keyboardType: TextInputType.visiblePassword,
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
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 1.5,
                ),
              ),
            ),
          ),
          loginButton: FilledButton(
            onPressed:
                authProvider.state != XState.loading ? onLoginPressed : null,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              foregroundColor: Theme.of(context).colorScheme.surface,
            ),
            child: authProvider.state != XState.loading
                ? const Text("Se connecter")
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

class _LoginAdaptiveForm extends StatelessWidget {
  const _LoginAdaptiveForm({
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
