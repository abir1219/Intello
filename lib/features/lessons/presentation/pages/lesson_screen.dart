import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/routes/app_routes.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../account/presentation/widget/listen_button.dart';
import '../bloc/lesson_bloc.dart';
import 'lesson_card.dart';

class LessonScreen extends StatefulWidget {
  final String subject;
  final String level;

  const LessonScreen({super.key, required this.subject, required this.level});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final int _currentIndex = 0; // profile index
  int selectedIndex = 0;
  late final audioService;

  @override
  void initState() {
    selectedIndex = -1;
    audioService = AudioPlayerService();
    context.read<LessonBloc>().add(
      LoadLessonsEvent(widget.subject, widget.level),
    );
    super.initState();
  }

  @override
  void dispose() {
    audioService.stop();
    super.dispose();
  }

  void _handleNavigation(int index) {
    // if (index == _currentIndex) return;

    debugPrint("LESSON_INDEX-->$index");
    switch (index) {
      case 0:
        context.pushReplacement(AppPages.LEVEL_SCREEN);
        break;
      case 1:
        context.pushReplacement(AppPages.PROFILE_SCREEN);
        break;
      case 2:
        Center(child: Text("Home Page"));
        break;
      case 3:
        context.pushReplacement(AppPages.CHANGE_PASSWORD_SCREEN);
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
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          context.pushReplacement(AppPages.SUBJECT_SCREEN, extra: widget.level);
        },
        child: SafeArea(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  SvgPicture.asset(AppAssets.background, fit: BoxFit.cover),
                  Padding(
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
                              onTap: () async {
                                await audioService.toggle(AppAssets.audio);
                              },
                              listenString: 'Écouter les consignes',
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        BlocBuilder<LessonBloc, LessonState>(
                          builder: (context, state) {
                            if (state is LessonLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (state is LessonLoaded) {
                              if (state.lessons.isEmpty) {
                                return Expanded(
                                  child: const Center(
                                    child: Text(
                                      "No lessons found",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Expanded(
                                child: GridView.builder(
                                  // shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  padding: const EdgeInsets.all(16),
                                  itemCount: state.lessons.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio: 1.4,
                                      ),
                                  itemBuilder: (context, index) {
                                    final level = state.lessons[index];

                                    return LessonCard(
                                      lesson: level,
                                      isSelected: selectedIndex == index,
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                        context.pushReplacement(AppPages.LESSON_DETAILS_SCREEN,extra: {
                                          "subjectId": widget.subject,
                                          "levelCode": widget.level,
                                          "levelName": state.lessons[index].title,
                                          "lessonId": state.lessons[index].id,
                                        });
                                      },
                                    );
                                  },
                                ),
                              );
                            }

                            if (state is LessonError) {
                              return Center(child: Text(state.message));
                            }

                            return const SizedBox();
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
      ),
    );
  }
}
