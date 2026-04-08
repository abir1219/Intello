import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/lesson_details_updated/data/models/activity_model.dart'
    show ActivityModel;

import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart' show AppDimensions;
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../account/presentation/widget/listen_button.dart';
import '../widgets/fill_in_the_blank_widget.dart';
import '../widgets/matching_ques_ans_widget.dart';
import '../widgets/multiple_choice_widget.dart';
import '../widgets/short_answer_widget.dart';
import '../widgets/true_false_widget.dart';

class ActivityFlowScreen extends StatefulWidget {
  final List<ActivityModel> activities;

  const ActivityFlowScreen({super.key, required this.activities});

  @override
  State<ActivityFlowScreen> createState() => _ActivityFlowScreenState();
}

class _ActivityFlowScreenState extends State<ActivityFlowScreen> {
  int currentIndex = 0;
  final int _currentIndex = 0;

  late final audioService;

  @override
  void initState() {
    audioService = AudioPlayerService();
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

  void next() {
    if (currentIndex < widget.activities.length - 1) {
      setState(() => currentIndex++);
    } else {
      debugPrint("Flow Completed ✅");
      Navigator.pop(context); // or go to result screen
    }
  }

  void previous() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    } else {
      debugPrint("Already at first question ⛔");
      Navigator.pop(context); // optional
    }
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activities[currentIndex];

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
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildActivityWidget(
                              activity,
                              widget.activities.length,
                            ),
                          ],
                        ),
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
          //child: _buildActivityWidget(activity)
        ),
      ),
    );
  }

  Widget _buildActivityWidget(ActivityModel activity, int length) {
    switch (activity.type) {
      case "multiple_choice":
        return //Center(child: Text("Multiple Choice"),);
        MultipleChoiceWidget(
          data: activity,
          onNext: next,
          onPrevious: previous,
          isLast: currentIndex == length - 1,
        );

      case "true_false":
        return TrueFalseWidget(
          data: activity,
          onNext: next,
          onPrevious: previous,
          isLast: currentIndex == length - 1,
        );

      case "fill_blank":
        return FillBlankWidget(
          data: activity,
          onNext: next,
          onPrevious: previous,
          isLast: currentIndex == length - 1,
        );

      case "short_answer":
        return ShortAnswerWidget(
          data: activity,
          onNext: next,
          onPrevious: previous,
          isLast: currentIndex == length - 1,
        );

      case "matching":
        return MatchingQuesAnsWidget(
          data: activity,
          onNext: next,
          onPrevious: previous,
          isLast: currentIndex == length - 1,
        );

      default:
        return const Center(child: Text("Unknown Activity"));
    }
  }
}
