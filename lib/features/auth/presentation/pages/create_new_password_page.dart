import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
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
                  child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
                    listenWhen: (previous, current) =>
                    previous.isSuccess != current.isSuccess ||
                        previous.errorMessage != current.errorMessage,
                    listener: (context, state) {

                      if (state.isSuccess) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => CreatePasswordSuccessDialog(
                            onClose: () => Navigator.pop(context),
                            onContinue: () {
                              Navigator.pop(context);
                              context.go(AppPages.LOGIN_SCREEN);
                            },
                          ),
                        );
                      }

                      if (state.errorMessage != null) {
                        _showError(context, state.errorMessage!);
                      }
                    },

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(height: height * 0.03),

                        /// Logo
                        SizedBox(
                          height: height * 0.05,
                          width: isLandscape ? width * 0.19 : width * 0.18,
                          child: SvgPicture.asset(
                            AppAssets.logo_text,
                            fit: BoxFit.fill,
                          ),
                        ),

                        SizedBox(height: height * 0.06),

                        /// Title
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

                        SizedBox(height: height * 0.01),

                        const Text(
                          "Créez un mot de passe sécurisé pour protéger votre compte.",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.TEXT_FIELD_COLOR,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 32),

                        /// Password Field
                        BlocSelector<ForgotPasswordBloc, ForgotPasswordState, bool>(
                          selector: (state) => state.isPasswordVisible,
                          builder: (context, isVisible) {
                            return CustomTextField.buildTextFieldWithLabel(
                              label: "Mot de passe",
                              hintText: "Choisis un mot de passe sécurisé ...",
                              obscureText: isVisible,
                              context: context,
                              isPassword: true,
                              controller: _password,
                              onTap: () {
                                context.read<ForgotPasswordBloc>().add(
                                  const TogglePasswordVisibilityEvent(),
                                );
                              },
                            );
                          },
                        ),

                        /// Confirm Password Field
                        BlocSelector<ForgotPasswordBloc, ForgotPasswordState, bool>(
                          selector: (state) => state.isConfirmPasswordVisible,
                          builder: (context, isVisible) {
                            return CustomTextField.buildTextFieldWithLabel(
                              label: "Confirmer le mot de passe",
                              hintText: "Entre à nouveau ton mot de passe ...",
                              obscureText: isVisible,
                              context: context,
                              isPassword: true,
                              controller: _cnfrm_password,
                              onTap: () {
                                context.read<ForgotPasswordBloc>().add(
                                  const ToggleConfirmPasswordVisibilityEvent(),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        /// Submit Button
                        BlocSelector<ForgotPasswordBloc, ForgotPasswordState, bool>(
                          selector: (state) => state.isLoading,
                          builder: (context, isLoading) {
                            return PrimaryButton(
                              title: isLoading ? "Chargement..." : "S’inscrire",
                              onPressed: isLoading
                                  ? null
                                  : () {
                                context.read<ForgotPasswordBloc>().add(
                                  SubmitForgotPassword(
                                    _password.text.trim(),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 16),
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
}
