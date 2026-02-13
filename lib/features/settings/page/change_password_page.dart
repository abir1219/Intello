import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../core/utils/app_dimenstion.dart';
import '../../../core/utils/responsive.dart';
import '../../../routes/app_pages.dart';
import '../../account/presentation/widget/listen_button.dart';
import '../../account/presentation/widget/primary_button.dart';
import '../../auth/widgets/custom_textfield.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _StateChangePasswordPage();
}

class _StateChangePasswordPage extends State<ChangePasswordPage> {
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _cnfrm_password = TextEditingController();

  final int _currentIndex = 3; // profile index

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
        context.go(AppPages.CREATE_NEW_PASSWORD_SCREEN);
        break;
    }
  }

  @override
  void dispose() {
    _newPassword.dispose();
    _cnfrm_password.dispose();
    _oldPassword.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(AppAssets.background, fit: BoxFit.cover),
                Positioned(
                  bottom: 20,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
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
                          height: isLandscape ? height * 0.01 : height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Changer le mot de passe.",
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  //SizedBox(height: 4),
                                  Padding(
                                    padding: EdgeInsets.only(right: 130.0),
                                    child: Text(
                                      "Mettez à jour votre mot de passe pour sécuriser votre compte.",
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w400,
                                      ),
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
                        const SizedBox(height: 40),
                        CustomTextField.buildTextFieldWithLabel(
                          label: "Mot de passe actuel",
                          hintText: "Entrez votre mot de passe actuel …",
                          obscureText: true,
                          context: context,
                          controller: _oldPassword,
                        ),
                        //const SizedBox(height: 16),
                        CustomTextField.buildTextFieldWithLabel(
                          label: "Nouveau mot de passe",
                          hintText: "Créez un nouveau mot de passe sécurisé …",
                          context: context,
                          obscureText: true,
                          controller: _newPassword,
                        ),
                        CustomTextField.buildTextFieldWithLabel(
                          label: "Confirmer le nouveau mot de passe",
                          hintText: "Entrez à nouveau le nouveau mot de passe …",
                          context: context,
                          obscureText: true,
                          controller: _cnfrm_password,
                        ),
                        const SizedBox(height: 10),

                        PrimaryButton(title: "Mettre à jour le mot de passe", onPressed: () => Container()),

                        const SizedBox(height: 16),
                      ],
                    ),
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
    );
  }
}
