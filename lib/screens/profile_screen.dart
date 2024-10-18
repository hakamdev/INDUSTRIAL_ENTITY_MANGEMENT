import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:oqvt_industrial_entity_management/utils/constants.dart';
import 'package:oqvt_industrial_entity_management/utils/cookies.dart';
import 'package:oqvt_industrial_entity_management/widgets/drop_down_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = "profile_route";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void onPicturePressed() {}

  void onLogoutPressed() {
    // TODO: add dialog
    logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          actions: [
            IconButton.filledTonal(
              onPressed: onLogoutPressed,
              icon: const Icon(Iconsax.logout_1),
              padding: const EdgeInsets.all(12),
              style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: const CircleBorder(),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            /// HEADER SECTION
            renderHeaderSection(context),
          ],
        ),
      ),
    );
  }

  Widget renderHeaderSection(BuildContext context) {
    // final heroTag = ModalRoute.of(context)?.settings.arguments as String?;

    // if (heroTag == kHeroTagProfilePic) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/home_bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor.withAlpha(150)
                  : Theme.of(context).primaryColor.withAlpha(150),
              BlendMode.multiply,
            ),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: SafeArea(
            child: Column(
              children: [
                /// Header profile
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onPicturePressed,
                      child: const Hero(
                        tag: kHeroTagProfilePic,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black,
                          foregroundImage: const NetworkImage(
                            "https://avatar.iran.liara.run/public/boy",
                            //"https://avatar.iran.liara.run/public/job/doctor/male",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Bonjour, 👋",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      "Abd Elkebir HAKAM",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 42),

                /// Health Center selector
                /// TODO: add functionality: selection sheet...etc
                // XDropDownButton<String>(
                //   title: "Select Health Center",
                //   options: const [
                //     "CCI - Ben Guerir",
                //     "Emines - Ben Guerir",
                //     "FGSES - Rabat",
                //     "Emines - Laayoune",
                //   ],
                //   onUpdateSelection: (selected) async {
                //     await Future.delayed(const Duration(seconds: 2));
                //     print(selected);
                //     // return Future.error(ApiException(XErrors.invalidResponseData));
                //     return true;
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
    // } else {
    // return Hero(
    //   tag: kHeroTagHeaderSection,
    //   child: Material(
    //     color: Colors.transparent,
    //     child: Container(
    //       width: double.infinity,
    //       clipBehavior: Clip.antiAlias,
    //       padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: const AssetImage("assets/home_bg.png"),
    //           fit: BoxFit.cover,
    //           colorFilter: ColorFilter.mode(
    //             Theme.of(context).brightness == Brightness.dark
    //                 ? Theme.of(context).primaryColor.withAlpha(150)
    //                 : Theme.of(context).primaryColor.withAlpha(150),
    //             BlendMode.multiply,
    //           ),
    //         ),
    //       ),
    //       child: BackdropFilter(
    //         filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
    //         child: SafeArea(
    //           child: Column(
    //             children: [
    //               /// Header profile
    //               Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   InkWell(
    //                     customBorder: const CircleBorder(),
    //                     onTap: onPicturePressed,
    //                     child: const CircleAvatar(
    //                       radius: 40,
    //                       backgroundColor: Colors.black,
    //                       foregroundImage: const NetworkImage(
    //                         "https://avatar.iran.liara.run/public/boy",
    //                         //"https://avatar.iran.liara.run/public/job/doctor/male",
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 16),
    //                   const Text("Bonjour, 👋",
    //                       style:
    //                       TextStyle(color: Colors.white, fontSize: 12)),
    //                   const SizedBox(height: 4),
    //                   Text(
    //                     "Abd Elkebir HAKAM",
    //                     style:
    //                     Theme.of(context).textTheme.titleMedium?.copyWith(
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //
    //               const SizedBox(height: 42),
    //
    //               /// Health Center selector
    //               /// TODO: add functionality: selection sheet...etc
    //               // XDropDownButton<String>(
    //               //   title: "Select Health Center",
    //               //   options: const [
    //               //     "CCI - Ben Guerir",
    //               //     "Emines - Ben Guerir",
    //               //     "FGSES - Rabat",
    //               //     "Emines - Laayoune",
    //               //   ],
    //               //   onUpdateSelection: (selected) async {
    //               //     await Future.delayed(const Duration(seconds: 2));
    //               //     print(selected);
    //               //     // return Future.error(ApiException(XErrors.invalidResponseData));
    //               //     return true;
    //               //   },
    //               // ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // }
  }
}
