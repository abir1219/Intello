import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/lesson_details_updated/presentation/bloc/learning_bloc.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../account/presentation/widget/listen_button.dart';
import '../../../lesson_details/widgets/customCard.dart';
import '../../../lesson_details/widgets/lesson_content_widget.dart';
import '../../../lessons/domain/entities/lesson.dart';

class LessonDetailsUpdate extends StatefulWidget {
  final String subject;
  final String level;
  final String levelName;
  final String lessonId;
  final String content;
  final bool isMore;
  final LirePlus? lirePlus;

  const LessonDetailsUpdate({
    super.key,
    required this.subject,
    required this.level,
    required this.levelName,
    required this.lessonId,
    required this.content,
    required this.isMore,
    required this.lirePlus,
  });

  @override
  State<LessonDetailsUpdate> createState() => _LessonDetailsUpdateState();
}

class _LessonDetailsUpdateState extends State<LessonDetailsUpdate> {
  final int _currentIndex = 0; // profile index
  int selectedIndex = 0;
  late final audioService;

  @override
  void initState() {
    audioService = AudioPlayerService();
    context.read<LearningBloc>().add(
      LoadLessonEvent(
        levelId: widget.level,
        subjectId: widget.subject,
        // lessonId: widget.levelName,
        lessonId: widget.lessonId,
      ),
    );
    super.initState();
  }

  final Map<String, String> _activityRouteMap = {
    "multiple_choice": AppPages.EXAMPLE_DETAILS_SCREEN,
    "true_false": AppPages.EXAMPLE_DETAILS_SCREEN,
    "fill_blank": AppPages.EXAMPLE_DETAILS_SCREEN,
    "short_answer": AppPages.EXAMPLE_DETAILS_SCREEN,
  };

  final Map<String, String> _gameRouteMap = {
    "matching": AppPages.EXAMPLE_DETAILS_SCREEN,
    "memory_match": AppPages.EXAMPLE_DETAILS_SCREEN,
    "sorting": AppPages.EXAMPLE_DETAILS_SCREEN,
    "scenario_choice": AppPages.EXAMPLE_DETAILS_SCREEN,
  };

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: isLandscape ? height * 0.03 : height * 0.03,
                        ),
                        Stack(
                          children: [
                            Positioned(top: 0, left: 0, child: BackButton()),
                            Center(
                              child: SizedBox(
                                height: 60,
                                child: SvgPicture.asset(AppAssets.logo_text),
                              ),
                            ),
                          ],
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
                        BlocBuilder<LearningBloc, LearningState>(
                          builder: (context, state) {
                            if (state is LearningLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is LearningLoaded) {
                              return SingleChildScrollView(
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
                                    widget.isMore
                                        ? LessonContentWidget(
                                            content: widget.content,
                                            lirePlus: widget.lirePlus,
                                          )
                                        : Text(
                                            widget.content,
                                            //"Apprenez les bases grâce à des leçons et activités simples, conçues pour faciliter la compréhension et encourager la pratique.",
                                            style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                    const SizedBox(height: 30),
                                    _buildContainer(
                                      levelName: widget.level,
                                      state: state,
                                      onTap: (int position) {
                                        handleLessonNavigation(
                                          context: context,
                                          state: state,
                                          position: position,
                                          subject: widget.subject,
                                          level: widget.level,
                                          levelName: widget.levelName,
                                          lessonId: widget.lessonId,
                                        );
                                      },
                                    ),
                                    /*_buildContainer(
                                      levelName: widget.level,
                                      state: state,
                                      onTap: (int position) {
                                        if(position == 0){
                                          debugPrint("Click---->${state.lessons.activities.runtimeType}: ${state.lessons.activities.length}");

                                        }else if(position == 1){
                                          debugPrint("Click---->Lecture");
                                        }else if(position == 2){
                                          debugPrint("Click---->${state.lessons.games.runtimeType}");
                                        }

                                        // if(state.lesson.exercise)
                                        */
                                    /*if(state.activity[0].type.toLowerCase() == "multiple_choice") {
                                          context.pushReplacement(
                                            AppPages.EXAMPLE_DETAILS_SCREEN,
                                            extra: {
                                              "subject": widget.subject,
                                              "level": widget.level,
                                              "levelName": widget.levelName,
                                              "lessonId": widget.lessonId,
                                              //"exercise": state.lesson.exercise,
                                            },
                                          );
                                        }*/
                                    /*
                                      },
                                    ),*/
                                  ],
                                ),
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
    required LearningLoaded state,
    required void Function(int position)? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cards
          GestureDetector(
            onTap: () => onTap?.call(0),
            child: CustomCard(
              icon: AppAssets.exercise_image,
              title: "Exercices/Devoirs",
              subtitle:
                  "Applique ce que tu as appris à travers des exercices et des devoirs.",
              progress: state.exercisePercentage,
              progressColor: AppColors.greenColor,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => onTap?.call(1),
            child: CustomCard(
              icon: AppAssets.lecture_image,
              title: "Lecture",
              subtitle:
                  "Développe tes compétences en lecture et en compréhension écrite.",
              progress: state.exercisePercentage,
              progressColor: AppColors.blueColor,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => onTap?.call(2),
            child: CustomCard(
              icon: AppAssets.game_image,
              title: "Jeux éducatifs",
              subtitle:
                  "Développe tes compétences grâce à des jeux interactifs.",
              progress: state.exercisePercentage,
              //1.0,
              progressColor: AppColors.CLOSE_COLOR,
            ),
          ),
        ],
      ),
    );
  }

  void handleLessonNavigation({
    required BuildContext context,
    required LearningLoaded state,
    required int position,
    required String subject,
    required String level,
    required String levelName,
    required String lessonId,
  }) {
    switch (position) {
      case 0:
        _handleActivities(context, state, subject, level, levelName, lessonId);
        break;

      case 1:
        _handleLecture(context, state, subject, level, levelName, lessonId);
        break;

      case 2:
        _handleGames(context, state, subject, level, levelName, lessonId);
        break;

      default:
        debugPrint("Invalid position");
    }
  }

  /*void _handleActivities(
    BuildContext context,
    LearningLoaded state,
    String subject,
    String level,
    String levelName,
    String lessonId,
  ) {
    final activities = state.lessons.activities;

    if (activities.isEmpty) {
      debugPrint("No activities found");
      return;
    }

    final firstType = activities.first.type;

    final route = _activityRouteMap[firstType];

    if (route != null) {
      context.push(
        route,
        extra: {
          "data": activities,
          "subject": subject,
          "level": level,
          "levelName": levelName,
          "lessonId": lessonId,
        },
      );
    } else {
      debugPrint("Unsupported activity type: $firstType");
    }
  }*/

  void _handleActivities(
      BuildContext context,
      LearningLoaded state,
      String subject,
      String level,
      String levelName,
      String lessonId,
      ) {
    final activities = state.lessons.activities;

    if (activities.isEmpty) return;

    context.push(
      AppPages.ACTIVITY_FLOW_SCREEN, // ✅ single screen
      extra: {
        "activities": activities,
        "subject": subject,
        "level": level,
        "levelName": levelName,
        "lessonId": lessonId,
      },
    );
  }

  void _handleLecture(
    BuildContext context,
    LearningLoaded state,
    String subject,
    String level,
    String levelName,
    String lessonId,
  ) {
    debugPrint("Handling Lecture");
    /*final lecture = state.lessons.lecture;

    context.push(
      AppPages.PDF_VIEWER_SCREEN,
      extra: {
        "title": lecture.pdfTitle,
        "url": lecture.pdfUrl,
        "subject": subject,
        "level": level,
        "levelName": levelName,
        "lessonId": lessonId,
      },
    );*/
  }

  void _handleGames(
    BuildContext context,
    LearningLoaded state,
    String subject,
    String level,
    String levelName,
    String lessonId,
  ) {
    final games = state.lessons.games;

    if (games.isEmpty) {
      debugPrint("No games found");
      return;
    }

    final firstType = games.first.type;

    final route = _gameRouteMap[firstType];

    if (route != null) {
      context.push(
        route,
        extra: {
          "data": games,
          "subject": subject,
          "level": level,
          "levelName": levelName,
          "lessonId": lessonId,
        },
      );
    } else {
      debugPrint("Unsupported game type: $firstType");
    }
  }
}
