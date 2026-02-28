import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../account/presentation/widget/listen_button.dart';
import '../../data/datasources/level_local_datasources.dart';
import '../widgets/level_card.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int _currentIndex = 0; // profile index

  late final audioService;
  late final LevelLocalDataSource dataSource;

  @override
  void initState() {
    super.initState();
    audioService = AudioPlayerService();
    dataSource = LevelLocalDataSource();
  }

  @override
  void dispose() {
    audioService.dispose();
    super.dispose();
  }

  void _handleNavigation(int index) {
    if (index == _currentIndex) return;
    debugPrint("LEVEL_INDEX-->$index");
    switch (index) {
      case 0:
        context.go(AppPages.LEVEL_SCREEN);
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

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    // print("DATASOURCE-->${dataSource.getLevels()}");

    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(AppAssets.background, fit: BoxFit.cover),
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: isLandscape ? width * 0.25 : width * 0.08,
                    right: isLandscape ? width * 0.25 : width * 0.08,
                    top: 10,
                    bottom: 100,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: isLandscape ? height * 0.03 : height * 0.03,
                      ),
                      SizedBox(
                        height: isLandscape ? height * 0.05 : height * 0.05,
                        width: isLandscape ? width * 0.19 : width * 0.18,
                        child: SvgPicture.asset(
                          AppAssets.logo_text,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: isLandscape ? height * 0.06 : height * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              "Sélectionne ton niveau d’apprentissage.",
                              style: TextStyle(
                                fontSize: 28,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          ListenButton(
                            onTap: () =>
                                audioService.playAsset(AppAssets.audio),
                            listenString: 'Écouter les consignes',
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      FutureBuilder(
                        future: dataSource.getLevels(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final levels = snapshot.data!;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 40,
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: levels.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: isLandscape ? 1.8 : 1.5,
                                  ),
                              itemBuilder: (context, index) {
                                return LevelCard(
                                  level: levels[index],
                                  isSelected: selectedIndex == index,
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                    print("label-->${levels[index].id}");
                                    context.push(
                                      AppPages.SUBJECT_SCREEN,
                                      extra: levels[index].id,
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
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
