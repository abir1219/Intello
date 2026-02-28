import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/account/presentation/widget/listen_button.dart';

import '../../../../core/audio/audio_player_service.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/navigation/custom_bottom_nav_bar.dart';
import '../../../../routes/app_pages.dart';
import '../../widgets/subject_card.dart';
import '../bloc/subject_bloc.dart';
import '../bloc/subject_event.dart';
import '../bloc/subject_state.dart';

class SubjectScreen extends StatefulWidget {
  final String levelCode;

  const SubjectScreen({super.key, required this.levelCode});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  int selectedIndex = 0;
  int _navIndex = 0;
  late final audioService;

  @override
  void initState() {
    super.initState();
    debugPrint("code->${widget.levelCode}");
    audioService = AudioPlayerService();
    context.read<SubjectBloc>().add(LoadSubjectsEvent(widget.levelCode));
  }

  /*void _handleNavigation(int index) {
    setState(() {
      _navIndex = index;
    });
  }*/

  void _handleNavigation(int index) {
    // if (index == _navIndex) return;
    debugPrint("SUBJECT_INDEX-->$index");
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

  @override
  void dispose() {
    audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if(didPop) return;
          context.push(AppPages.LEVEL_SCREEN);
        },
        child: SafeArea(
          child: Stack(
            children: [
              /// Background
              SvgPicture.asset(
                AppAssets.background,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo
                    Center(
                      child: SizedBox(
                        height: 60,
                        child: SvgPicture.asset(AppAssets.logo_text),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "Sélectionne ton sujet.",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),

                        ListenButton(
                          onTap: () => audioService.playAsset(AppAssets.audio),
                          listenString: "Écouter les consignes",
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    /// Subject List
                    Expanded(
                      child: BlocBuilder<SubjectBloc, SubjectState>(
                        builder: (context, state) {
                          print("State==>$state");
                          if (state is SubjectLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is SubjectLoaded) {
                            /// First card active by default
                            if (state.subjects.isNotEmpty &&
                                selectedIndex >= state.subjects.length) {
                              selectedIndex = 0;
                            }

                            return ListView.builder(
                              itemCount: state.subjects.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: SubjectCard(
                                    subject: state.subjects[index],
                                    isSelected: selectedIndex == index,
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                      context.push(AppPages.LESSON_SCREEN,extra: {
                                        "subjectId": state.subjects[index].id,
                                        "levelCode": widget.levelCode
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          }

                          if (state is SubjectFailure) {
                            return Center(child: Text(state.message));
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Bottom Navigation
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: CustomBottomNavBar(
                  selectedIndex: _navIndex,
                  onItemSelected: _handleNavigation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
