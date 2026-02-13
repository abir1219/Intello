import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/auth/widgets/custom_textfield.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../widget/listen_button.dart';
import '../widget/primary_button.dart';
import '../widget/profile_avatar_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1; // profile index

  void _handleNavigation(int index) {
    if (index == _currentIndex) return;

    switch (index) {
      case 0:
        Container();
        break;
      case 1:
        context.go(AppPages.PROFILE_SCREEN);
        break;
      case 2:
        Center(child: Text("Home Page"));
        break;
      case 3:
        context.go(AppPages.CHANGE_PASSWORD_SCREEN);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    return Scaffold(
      //backgroundColor: const Color(0xFFF4EFE6),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(AppAssets.background, fit: BoxFit.cover),
                SingleChildScrollView(
                  /*padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? width * 0.25 : width * 0.05,
                    vertical: 10,
                  ),*/
                  padding: EdgeInsets.only(
                    left: isLandscape ? width * 0.25 : width * 0.08,
                    right: isLandscape ? width * 0.25 : width * 0.08,
                    top: 10,
                    bottom: 100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: isLandscape ? height * 0.01 : height * 0.01,
                      ),
                      SizedBox(
                        height: isLandscape ? height * 0.13 : height * 0.15,
                        width: isLandscape ? width * 0.19 : width * 0.18,
                        child: SvgPicture.asset(
                          AppAssets.logo,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: isLandscape ? height * 0.01 : height * 0.01,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Aller à mon profil.",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                //SizedBox(height: 4),
                                Text(
                                  "Consultez et gérez vos informations personnelles.",
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListenButton(
                            onTap: () {},
                            listenString: 'Écouter les consignes',
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            const ProfileAvatarSection(),
                            const SizedBox(height: 30),
                            CustomTextField.buildTextFieldWithLabel(
                              context: context,
                              controller: null,
                              hintText: "Entrez votre nom complet …",
                              label: "Nom complet*",
                            ),
                            CustomTextField.buildTextFieldWithLabel(
                              context: context,
                              controller: null,
                              hintText: "Entrez votre numéro WhatsApp ...",
                              label: "Numéro WhatsApp*",
                            ),
                            CustomTextField.buildTextFieldWithLabel(
                              context: context,
                              controller: null,
                              hintText: "Entre une adresse e-mail valide ...",
                              label: "Adresse e-mail",
                            ),
                            const SizedBox(height: 10),

                            PrimaryButton(
                              title: "Mettre à jour le profil",
                              onPressed: () => Container(),
                              // context.go(AppPages.NAVIGATION_SCREEN),
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: CustomBottomNavBar(
                  selectedIndex: _currentIndex,
                  onItemSelected: _handleNavigation,
                ),)
              ],
            );
          },
        ),
      ),
      /*bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemSelected: _handleNavigation,
      ),*/
    );
  }
}
