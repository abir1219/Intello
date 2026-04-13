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
import '../../../exercise/presentation/widgets/primary_button.dart';

class MultipleChoiceWidget extends StatefulWidget {
  final ActivityModel data;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLast;

  const MultipleChoiceWidget({
    super.key,
    required this.data,
    required this.onNext,
    required this.onPrevious, required this.isLast,
  });

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  int? selectedIndex;
  bool showResult = false;

  @override
  Widget build(BuildContext context) {
    final question = widget.data.question;
    final choices = widget.data.choices ?? [];
    final correctIndex = widget.data.answer ?? -1;

    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: isLandscape ? height * 0.8 : height * 0.52,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.onPrevious,
                child: Text(
                  "Précédente",
                  style: TextStyle(
                      fontSize: 16, decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  "Quitter",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          /// 🔹 Question
          /*Text(
            "Q. $question",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Q. ${widget.data.question}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if(selectedIndex != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = null;
                      showResult = false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.greenColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.refresh, color: AppColors.whiteColor,),
                        Text("Réessayer", style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                ),
            ],
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
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    isSelected
                        ? SvgPicture.asset(AppAssets.selected_image)
                        : Icon(
                      //Icons.radio_button_checked:
                      Icons.radio_button_off,
                      color: isSelected ? Colors.blue : Colors.grey,
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

          // const SizedBox(height: 20),
          /*Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = null;
                  showResult = false;
                });
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.2,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.greenColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.refresh, color: AppColors.whiteColor,),
                    Text("Réessayer", style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
            ),
          ),*/
          const SizedBox(height: 20),

          /// 🔹 Result Section
          if (showResult) ...[
            //Text("${selectedIndex == correctIndex}"),
            Text(
              "Résultat 👉 “${choices[correctIndex]}”",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),

            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text(
                    selectedIndex == correctIndex
                        ? "Bravo ! Vous avez bien répondu à votre question."
                        : "Oups ! Ce n'est pas correct.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  selectedIndex == correctIndex
                      ? SvgPicture.asset(AppAssets.correct_image)
                      : Icon(Icons.close, size: 100, color: Colors.red),
                ],
              ),
            ),
          ],

          //const Spacer(),
          const SizedBox(height: 30),

          /// 🔹 Next Button
          //if (showResult)
          Center(
            child: PrimaryButton(
              title: "Question suivante",
              onPressed: widget.onNext,
            ),
          ),

          const SizedBox(height: 10),

          /// 🔹 Ignore
          if(!widget.isLast)
            Center(
              child: GestureDetector(
                onTap: widget.onNext,
                child: const Text(
                  "Ignorer",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
