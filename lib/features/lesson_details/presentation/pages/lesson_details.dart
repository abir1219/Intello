import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/lesson_details/presentation/bloc/lesson_content_bloc.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../account/presentation/widget/listen_button.dart';
import '../../widgets/customCard.dart';

class LessonDetails extends StatefulWidget {
  final String subject;
  final String level;
  final String levelName;
  final String lessonId;
  final String content;

  const LessonDetails({
    super.key,
    required this.subject,
    required this.level,
    required this.levelName,
    required this.lessonId,
    required this.content,
  });

  @override
  State<LessonDetails> createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {
  final int _currentIndex = 0; // profile index
  int selectedIndex = 0;
  late final audioService;

  @override
  void initState() {
    audioService = AudioPlayerService();
    context.read<LessonContentBloc>().add(
      LoadLessonEvent(
        levelId: widget.level,
        subjectId: widget.subject,
        // lessonId: widget.levelName,
        lessonId: widget.lessonId,
      ),
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
      /*case 2:
        Center(child: Text("Home Page"));
        break;*/
      case 2:
        context.pushReplacement(AppPages.CHANGE_PASSWORD_SCREEN);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive.isTablet(context);
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          context.pushReplacement(
            AppPages.LESSON_SCREEN,
            extra: {"subjectId": widget.subject, "levelCode": widget.level},
          );
        },
        child: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: isLandscape ? height * 0.03 : height * 0.03,
                        ),
                        /*SizedBox(
                          height: isLandscape ? height * 0.05 : height * 0.05,
                          width: isLandscape ? width * 0.19 : width * 0.18,
                          child: SvgPicture.asset(
                            AppAssets.logo_text,
                            fit: BoxFit.fill,
                          ),
                        ),*/
                        Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: BackButton(),
                              ),
                              Center(
                                child: SizedBox(
                                  height: 60,
                                  child: SvgPicture.asset(AppAssets.logo_text),
                                ),
                              ),
                            ]
                        ),
                        SizedBox(
                          height: isLandscape ? height * 0.06 : height * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                "Au programme de cette leçon !",
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
                        Text(
                          "Présentation de la leçon.",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 40),
                        BlocBuilder<LessonContentBloc, LessonContentState>(
                          builder: (context, state) {
                            if (state is LessonLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is LessonLoaded) {
                              return _buildContainer(
                                levelName: widget.level,
                                state: state,
                                onTap: () {
                                  context.pushReplacement(AppPages.EXAMPLE_DETAILS_SCREEN,extra: {
                                    "subject" : widget.subject,
                                    "level" : widget.level,
                                    "levelName" : widget.levelName,
                                    "lessonId" : widget.lessonId,
                                    "exercise" : state.lesson.exercise,
                                  });
                                },
                              );
                            } else {
                              return SizedBox();
                            }
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

  Widget _buildContainer({
    required String levelName,
    required LessonLoaded state,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.levelName.toUpperCase(),
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
             Text(
              widget.content,
              //"Apprenez les bases grâce à des leçons et activités simples, conçues pour faciliter la compréhension et encourager la pratique.",
              style: TextStyle(color: AppColors.textColor, fontSize: 14),
            ),
            const SizedBox(height: 30),

            // Cards
            CustomCard(
              icon: AppAssets.exercise_image,
              title: "Exercices/Devoirs",
              subtitle:
                  "Applique ce que tu as appris à travers des exercices et des devoirs.",
              progress: state.exercisePercentage,
              progressColor: AppColors.greenColor,
            ),
            const SizedBox(height: 20),
            CustomCard(
              icon: AppAssets.lecture_image,
              title: "Lecture",
              subtitle:
                  "Développe tes compétences en lecture et en compréhension écrite.",
              progress: state.exercisePercentage,
              progressColor: AppColors.blueColor,
            ),
            const SizedBox(height: 20),
            CustomCard(
              icon: AppAssets.game_image,
              title: "Jeux éducatifs",
              subtitle:
                  "Développe tes compétences grâce à des jeux interactifs.",
              progress: state.exercisePercentage,
              //1.0,
              progressColor: AppColors.CLOSE_COLOR,
            ),
          ],
        ),
      ),
    );
  }
}
