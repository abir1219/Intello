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
import '../../../lesson_details/domain/entity/exercise.dart';
import '../../../lesson_details/presentation/pages/question_card.dart';

class ExampleDetails extends StatefulWidget {
  final String subject;
  final String level;
  final String lessonId;
  final String levelName;
  final Exercise exercise;

  const ExampleDetails({
    super.key,
    required this.subject,
    required this.level,
    required this.lessonId,
    required this.levelName,
    required this.exercise,
  });

  @override
  State<ExampleDetails> createState() => _ExampleDetailsState();
}

class _ExampleDetailsState extends State<ExampleDetails> {
  int _currentIndex = 0; // profile index
  late final audioService;

  String? selectedAnswer;
  bool isAnswered = false;

  final PageController _pageController = PageController();

  int currentPage = 0;

  void nextQuestion() {
    if (currentPage < widget.exercise.questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  void _handleNavigation(int index) {
    if (index == _currentIndex) return;

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
  void initState() {
    super.initState();
    debugPrint("Lesson-->${widget.exercise.questions.length}");
    audioService = AudioPlayerService();
  }

  @override
  void dispose() {
    audioService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isTablet = Responsive.isTablet(context);
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    final questions = widget.exercise.questions;

    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          // context.push(AppPages.LESSON_DETAILS_SCREEN);
          context.pushReplacement(
            AppPages.LESSON_DETAILS_SCREEN,
            extra: {
              "subjectId": widget.subject,
              "levelCode": widget.level,
              "levelName": widget.levelName,
              "lessonId": widget.lessonId,
            },
          );
        },
        child: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  SvgPicture.asset(AppAssets.background, fit: BoxFit.cover),
                  /*Padding(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                              onTap: () async {
                                await audioService.toggle(AppAssets.audio);
                              },
                              listenString: 'Écouter les consignes',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Trois sur trente ✅",
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Quitter"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Expanded(
                          //height: height * 0.5,
                          child: PageView.builder(
                            controller: _pageController,
                            //physics: const NeverScrollableScrollPhysics(),
                            itemCount: questions.length,
                            onPageChanged: (index) {
                              setState(() {
                                currentPage = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return QuestionCard(
                                question: questions[index],
                                onNext: nextQuestion,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.only(
                      left: isLandscape ? width * 0.25 : width * 0.08,
                      right: isLandscape ? width * 0.25 : width * 0.08,
                      top: 10,
                      bottom: 100,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: height * 0.03),

                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.18,
                            child: SvgPicture.asset(
                              AppAssets.logo_text,
                              fit: BoxFit.fill,
                            ),
                          ),

                          SizedBox(height: height * 0.06),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Aller à mon profil.",
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 130),
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
                                onTap: () async {
                                  await audioService.toggle(AppAssets.audio);
                                },
                                listenString: 'Écouter les consignes',
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Trois sur trente ✅",
                                style: TextStyle(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text("Quitter"),
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          /// PAGEVIEW
                          SizedBox(
                            height: height * 0.5,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: questions.length,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                setState(() {
                                  currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                return QuestionCard(
                                  question: questions[index],
                                  onNext: nextQuestion,
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
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
      ),
    );
  }
}
