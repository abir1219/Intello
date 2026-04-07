import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/lesson_details_updated/data/models/activity_model.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../account/presentation/widget/listen_button.dart';

class MultipleChoiceWidget extends StatefulWidget {
  final ActivityModel data;
  final VoidCallback onNext;

  const MultipleChoiceWidget({
    super.key,
    required this.data,
    required this.onNext,
  });

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  int? selectedIndex;
  bool showResult = false;

  final int _currentIndex = 0; // profile index
  //int selectedIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    final question = widget.data.question;
    final choices = widget.data.choices ?? [];
    final correctIndex = widget.data.answer ?? -1;

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
                            /// 🔹 Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Trois sur trente ✅",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Text(
                                    "Quitter",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            /// 🔹 Question
                            Text(
                              "Q. $question",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// 🔹 Options
                            ...List.generate(choices.length, (index) {
                              final isSelected = selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  if (showResult) return;

                                  setState(() {
                                    selectedIndex = index;
                                    showResult = true;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isSelected
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          choices[index],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),

                            const SizedBox(height: 20),

                            /// 🔹 Result Section
                            if (showResult) ...[
                              Text(
                                "Résultat 👉 “${choices[correctIndex]}”",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Bravo ! Vous avez bien répondu à votre question.",
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10),
                                    Icon(
                                      Icons.celebration,
                                      size: 60,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            const Spacer(),

                            /// 🔹 Next Button
                            if (showResult)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: widget.onNext,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    "Question suivante →",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),

                            const SizedBox(height: 10),

                            /// 🔹 Ignore
                            if (showResult)
                              Center(
                                child: GestureDetector(
                                  onTap: widget.onNext,
                                  child: const Text(
                                    "Ignorer",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
