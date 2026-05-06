import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../account/presentation/widget/primary_button.dart';
import '../../data/models/activity_model.dart';

class TrueFalseWidget extends StatefulWidget {
  final ActivityModel data;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLast;

  const TrueFalseWidget({
    super.key,
    required this.data,
    required this.onNext,
    required this.onPrevious, required this.isLast,
  });

  @override
  State<TrueFalseWidget> createState() => _TrueFalseWidgetState();
}

class _TrueFalseWidgetState extends State<TrueFalseWidget> {
  bool? selectedAnswer; // user selection
  bool correctAnswer = false;
  bool showResult = false;
  String question = "";

  @override
  void initState() {
    super.initState();
    question = widget.data.question ?? "";
    correctAnswer = widget.data.answer ?? true; // must be bool
  }

  @override
  Widget build(BuildContext context) {
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: isLandscape ? height * 0.8 : height * 5,
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
                  style: TextStyle(fontSize: 16, decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,color: Colors.black),
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

          /// QUESTION
          /*Text(
            "Q. $question",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 10),
              if(selectedAnswer != null)
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAnswer = null;
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
            ],
          ),
          const SizedBox(height: 10),
          if(selectedAnswer != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // ✅ FIX
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAnswer = null;
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

          /// OPTIONS
          Column(
            children: [
              _optionTile("vrai", true),
              // const SizedBox(height: 4),
              _optionTile("faux", false),
            ],
          ),
          const SizedBox(height: 20),

          /// RESULT
          if (showResult) ...[
            Text(
              // "Résultat 👉 “${correctAnswer ? "vrai" : "faux"}”",
              "Résultat 👉 “${widget.data.explanation}“",
              // (${correctAnswer ? "vrai" : "faux"})
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Center(
              child: Column(
                children: [
                  Text(
                    selectedAnswer == correctAnswer
                        ? "Bravo ! Vous avez bien répondu à votre question."
                        : "Oups ! Ce n'est pas correct.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 10),

                  selectedAnswer == correctAnswer
                      ? SvgPicture.asset(AppAssets.correct_image)
                      : const Icon(Icons.close, size: 100, color: Colors.red),
                ],
              ),
            ),
          ],

          //const Spacer(),

          const SizedBox(height: 30,),

          /// NEXT BUTTON
          Center(
            child: PrimaryButton(
              title: "Question suivante",
              onPressed: widget.onNext,
            ),
          ),

          const SizedBox(height: 10),

          /// IGNORE
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

  Widget _optionTile(String text, bool value) {
    final isSelected = selectedAnswer == value;

    return GestureDetector(
      onTap: () {
        if (showResult) return;

        setState(() {
          selectedAnswer = value;
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
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            isSelected
                ? SvgPicture.asset(AppAssets.selected_image)
                : const Icon(Icons.radio_button_off, color: Colors.grey),

            const SizedBox(width: 10),

            Expanded(
              child: Text(text, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
