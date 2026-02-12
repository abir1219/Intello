import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/core/constants/app_colors.dart';
import 'package:intello_new/routes/app_pages.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/registration_success_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fistName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _cnfrm_password = TextEditingController();
  // 4. Initialize the gesture recognizer
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _handleTap;
  }

  @override
  void dispose() {
    // 4. Dispose of the recognizer
    _tapGestureRecognizer.dispose();
    _fistName.dispose();
    _lastName.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    _cnfrm_password.dispose();
    super.dispose();
  }

  void _handleTap() {
    context.go(AppPages.LOGIN_SCREEN);
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Text(
                        "Créer un compte !",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.TEXT_FIELD_COLOR,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: isLandscape ? height * 0.01 : height * 0.005,
                      ),
                      const Text(
                        "Crée ton compte pour commencer à apprendre avec Intello.",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.TEXT_FIELD_COLOR,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      CustomTextField.buildTextFieldWithLabel(
                        controller: _fistName,
                        context: context,
                        label: "Prénom*",
                        hintText: "Prénom ...",
                      ),

                      //const SizedBox(height: 16),
                      CustomTextField.buildTextFieldWithLabel(
                        controller: _lastName,
                        context: context,
                        label: "Ton Nom*",
                        hintText: "Entre ton nom de famille ...",
                      ),

                      //const SizedBox(height: 16),
                      CustomTextField.buildTextFieldWithLabel(
                        controller: _phone,
                        context: context,
                        label: "Numéro WhatsApp*",
                        keyboardType: TextInputType.phone,
                        hintText: "Entrez votre numéro WhatsApp ...",
                      ),

                      // const SizedBox(height: 16),
                      CustomTextField.buildTextFieldWithLabel(
                        controller: _email,
                        context: context,
                        hintText: "Entre une adresse e-mail valide ...",
                        keyboardType: TextInputType.emailAddress,
                        label: "Adresse e-mail",
                      ),

                      // const SizedBox(height: 16),
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

                      /// Terms
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            activeColor: AppColors.greenColor,
                            onChanged: (_) {},
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "J’accepte les",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.TEXT_FIELD_COLOR,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Conditions générales",
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.TEXT_FIELD_COLOR,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " et la ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.TEXT_FIELD_COLOR,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Politique de confidentialité",
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.TEXT_FIELD_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      PrimaryButton(title: "S’inscrire", onPressed: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => RegistrationSuccessDialog(
                          onClose: () => Navigator.pop(context),
                          onContinue: () {
                            Navigator.pop(context); // close dialog first
                            context.go(AppPages.NAVIGATION_SCREEN);
                          },
                        ),
                      )),

                      const SizedBox(height: 16),

                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Vous avez déjà un compte ? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.TEXT_FIELD_COLOR,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "Se connecter",
                              // 3. Assign the recognizer to the specific TextSpan
                              recognizer: _tapGestureRecognizer,
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: AppColors.TEXT_FIELD_COLOR,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
