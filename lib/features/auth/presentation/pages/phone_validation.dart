import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:intello_new/routes/app_pages.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../account/presentation/widget/primary_button.dart';
import '../../widgets/custom_textfield.dart';

class PhoneValidation extends StatelessWidget {
  const PhoneValidation({super.key});

  @override
  Widget build(BuildContext context) {
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    final _phone = TextEditingController();

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
                    previous.isPhoneValidated != current.isPhoneValidated ||
                        previous.errorMessage != current.errorMessage,
                    listener: (context, state) {

                      if (state.isPhoneValidated) {
                        context.go(AppPages.CREATE_NEW_PASSWORD_SCREEN);
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
                        Text(
                          "Réinitialisez votre mot de passe.",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.TEXT_FIELD_COLOR,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: height * 0.01),

                        const Text(
                          "Entrez le numéro WhatsApp associé à votre numéro de téléphone.",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.TEXT_FIELD_COLOR,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 50),

                        /// Phone Field
                        CustomTextField.buildTextFieldWithLabel(
                          controller: _phone,
                          context: context,
                          label: "Numéro WhatsApp*",
                          keyboardType: TextInputType.phone,
                          hintText: "Entrez votre numéro WhatsApp ...",
                        ),

                        const SizedBox(height: 10),

                        /// Validate Button
                        BlocSelector<ForgotPasswordBloc, ForgotPasswordState, bool>(
                          selector: (state) => state.isLoading,
                          builder: (context, isLoading) {
                            return PrimaryButton(
                              title: isLoading ? "Chargement..." : "Valider",
                              onPressed: isLoading
                                  ? null
                                  : () {
                                context.read<ForgotPasswordBloc>().add(
                                  ValidatePhoneNumberEvent(
                                    _phone.text.trim(),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        /// Back to login
                        PrimaryButton(
                          title: "Retour à la connexion",
                          color: AppColors.greenColor,
                          logoVisible: false,
                          onPressed: () => context.go(AppPages.LOGIN_SCREEN),
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
