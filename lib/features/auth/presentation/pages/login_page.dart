import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../onboarding/presentation/widgets/primary_button.dart';
import '../../widgets/custom_textfield.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool rememberMe = true;

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
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _handleTap() {
    context.go(AppPages.SIGNUP_SCREEN);
  }

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
                  child: BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        _showSuccess(context,"Connexion réussie");
                        context.go(AppPages.PROFILE_SCREEN);
                      } else if (state is LoginFailure) {
                        _showError(context, state.message);
                        /*ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );*/
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          "Bon retour !",
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
                          "Poursuis ton parcours d’apprentissage avec Intello.",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.TEXT_FIELD_COLOR,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

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
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  activeColor: AppColors.greenColor,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                const Text("Se souvenir de moi"),
                              ],
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => context.go(
                                AppPages.PHONE_VALIDATE_SCREEN,
                              ),
                              child: Text(
                                "Mot de passe oublié ?",
                                style: TextStyle(
                                  color: AppColors.TEXT_FIELD_COLOR,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        PrimaryButton(
                          title: "Se connecter",
                          onPressed: () => context.read<LoginBloc>().add(
                            LoginUserEvent(
                              email: _email.text.trim(),
                              password: _password.text.trim(),
                              phone: _phone.text.trim(),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Vous n’avez pas de compte ?  ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.TEXT_FIELD_COLOR,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "S’inscrire",
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

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.greenColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
