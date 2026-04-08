import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../routes/app_pages.dart';
import '../../../account/presentation/widget/listen_button.dart';

class LecturePage extends StatefulWidget {
  final String pdfPath;
  final String subject;
  final String level;

  const LecturePage({super.key, required this.pdfPath, required this.subject, required this.level});

  @override
  State<LecturePage> createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {

  final int _currentIndex = 0; // profile index
  int selectedIndex = 0;
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
                        ConstrainedBox(constraints: BoxConstraints(
                          maxHeight: isLandscape ? height * 0.8 : height * 0.6,
                        ),
                        child: SfPdfViewer.asset(widget.pdfPath))
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
            // child: SfPdfViewer.asset(widget.pdfPath),
          ),
        ),
      ),
    );
  }
}
