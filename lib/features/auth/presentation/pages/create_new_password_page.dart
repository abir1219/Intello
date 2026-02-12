import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/auth/widgets/create_password_success_dialog.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../onboarding/presentation/widgets/primary_button.dart';
import '../../widgets/custom_textfield.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final _password = TextEditingController();
  final _cnfrm_password = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _cnfrm_password.dispose();
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
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape ? width * 0.25 : width * 0.1,
                    vertical: 10,
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
                      SizedBox(
                        width: isLandscape ? width * 0.5 : width * 0.3,
                        child: Text(
                          "Créez un nouveau mot de passe.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.TEXT_FIELD_COLOR,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: isLandscape ? height * 0.01 : height * 0.005,
                      ),
                      const Text(
                        "Créez un mot de passe sécurisé pour protéger votre compte.",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.TEXT_FIELD_COLOR,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      CustomTextField.buildTextFieldWithLabel(
                        label: "Mot de passe",
                        hintText: "Choisis un mot de passe sécurisé ...",
                        obscureText: true,
                        context: context,
                        controller: _password,
                      ),
                      //const SizedBox(height: 16),
                      CustomTextField.buildTextFieldWithLabel(
                        label: "Confirmer le mot de passe",
                        hintText: "Entre à nouveau ton mot de passe ...",
                        context: context,
                        obscureText: true,
                        controller: _cnfrm_password,
                      ),
                      const SizedBox(height: 10),

                      PrimaryButton(title: "S’inscrire", onPressed: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => CreatePasswordSuccessDialog(
                          onClose: () => Navigator.pop(context),
                          onContinue: () {
                            Navigator.pop(context); // close dialog first
                            context.go(AppPages.LOGIN_SCREEN);
                          },
                        ),
                      )),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
