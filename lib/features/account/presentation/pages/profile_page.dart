import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intello_new/features/auth/widgets/custom_textfield.dart';
import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../bloc/profile_bloc.dart';
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

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  String? selectedImagePath;
  late final audioService;

  @override
  void initState() {
    super.initState();
    audioService = AudioPlayerService();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();

    context.read<ProfileBloc>().add(LoadAccountEvent());
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    audioService.dispose();
    super.dispose();
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
                  child: BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      print("State is $state");
                      if (state is UpdateProfileSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Profil mis à jour avec succès."),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }

                      if (state is UpdateProfileFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }

                      if (state is AccountLoaded) {
                        nameController.text =
                            "${state.user.firstName} ${state.user.lastName}";
                        phoneController.text = state.user.whatsapp;
                        emailController.text = state.user.email;
                      }
                    },
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is AccountLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is AccountFailure) {
                          return Center(child: Text(state.message));
                        }

                        return Column(
                          children: [
                            //const SizedBox(height: 30),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Padding(
                                        padding: EdgeInsets.only(right: 130.0),
                                        child: Text(
                                          "Consultez et gérez vos informations personnelles.",
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
                                  onTap: () => audioService.playAsset(
                                    AppAssets.audio,
                                  ),
                                  listenString: 'Écouter les consignes',
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                if (state is AccountLoaded) {
                                  return ProfileAvatarSection(
                                    imagePath: state.user.imagePath,
                                    onTap: () {
                                      _showImagePicker(context);
                                    },
                                  );
                                }

                                return const SizedBox();
                              },
                            ),
                            const SizedBox(height: 30),

                            CustomTextField.buildTextFieldWithLabel(
                              context: context,
                              controller: nameController,
                              hintText: "Entrez votre nom complet …",
                              label: "Nom complet*",
                            ),

                            CustomTextField.buildTextFieldWithLabel(
                              context: context,
                              controller: phoneController,
                              hintText: "Entrez votre numéro WhatsApp ...",
                              label: "Numéro WhatsApp*",
                            ),

                            CustomTextField.buildTextFieldWithLabel(
                              context: context,
                              controller: emailController,
                              hintText: "Entre une adresse e-mail valide ...",
                              label: "Adresse e-mail",
                            ),

                            const SizedBox(height: 20),

                            PrimaryButton(
                              title: state is UpdateProfileLoading
                                  ? "Mise à jour..."
                                  : "Mettre à jour le profil",
                              onPressed: () => state is UpdateProfileLoading
                                  ? null
                                  : context.read<ProfileBloc>().add(
                                      UpdateProfileEvent(
                                        fullName: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                      ),
                                    ),
                            ),

                            const SizedBox(height: 80),
                          ],
                        );
                      },
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
                  ),
                ),
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

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choisir depuis la galerie"),
                onTap: () {
                  Navigator.pop(context);
                  context.read<ProfileBloc>().add(
                    UploadProfileImageEvent(ImageSource.gallery),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Prendre une photo"),
                onTap: () {
                  Navigator.pop(context);
                  context.read<ProfileBloc>().add(
                    UploadProfileImageEvent(ImageSource.camera),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
