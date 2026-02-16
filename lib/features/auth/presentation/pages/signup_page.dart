import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/core/constants/app_colors.dart';
import 'package:intello_new/routes/app_pages.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../widgets/create_password_success_dialog.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_textfield.dart';
import '../bloc/registration/registration_bloc.dart';

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
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = _handleTap;
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

  bool _check = false;
  @override
  Widget build(BuildContext context) {
    Responsive.isTablet(context);
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
                  child: BlocListener<RegistrationBloc, RegistrationState>(
                    listener: (context, state) {
                      if (state is RegistrationSuccess) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => CreatePasswordSuccessDialog(
                            onClose: () => Navigator.pop(context),
                            onContinue: () {
                              Navigator.pop(context); // close dialog first
                              context.go(AppPages.LOGIN_SCREEN);
                            },
                          ),
                        );
                      }else if(state is RegistrationFailure){
                        _showError(context, state.message);
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: isLandscape
                              ? height * 0.03
                              : height * 0.03,
                        ),
                        SizedBox(
                          height: isLandscape
                              ? height * 0.05
                              : height * 0.05,
                          width: isLandscape ? width * 0.19 : width * 0.18,
                          child: SvgPicture.asset(
                            AppAssets.logo_text,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: isLandscape
                              ? height * 0.06
                              : height * 0.06,

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
                              value: _check,
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              activeColor: AppColors.greenColor,
                              onChanged: (_) {
                                setState(() {
                                  _check = !_check;
                                });
                              },
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

                        PrimaryButton(
                          title: "S’inscrire",
                          onPressed: () => _validateAndRegister(context),
                        ),

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
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _validateAndRegister(BuildContext context) {
    final firstName = _fistName.text.trim();
    final lastName = _lastName.text.trim();
    final whatsapp = _phone.text.trim();
    final email = _email.text.trim();
    final password = _password.text.trim();
    final confirmPassword = _cnfrm_password.text.trim();

    /// 1️⃣ Empty validation
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        whatsapp.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty || _check == false) {
      _showError(context, "Tous les champs sont obligatoires.");
      return;
    }

    /// 2️⃣ Phone number validation (basic)
    final phoneRegex = RegExp(r'^[0-9]{8,15}$');
    if (!phoneRegex.hasMatch(whatsapp)) {
      _showError(context, "Numéro WhatsApp invalide.");
      return;
    }

    /// 3️⃣ Password match validation
    if (password != confirmPassword) {
      _showError(context, "Les mots de passe ne correspondent pas.");
      return;
    }

    /// If all valid → call bloc
    context.read<RegistrationBloc>().add(
      RegisterUserEvent(
        firstName: firstName,
        lastName: lastName,
        whatsapp: whatsapp,
        email: email,
        password: password,
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

}
