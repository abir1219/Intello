import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_colors.dart';
import 'package:intello_new/features/lesson_details_updated/data/models/activity_model.dart'
    show ActivityModel;

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../account/presentation/widget/primary_button.dart';

class FillBlankWidget extends StatefulWidget {
  final ActivityModel data;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLast;

  const FillBlankWidget({
    super.key,
    required this.data,
    required this.onNext,
    required this.onPrevious,
    required this.isLast,
  });

  @override
  State<FillBlankWidget> createState() => _FillBlankWidgetState();
}

class _FillBlankWidgetState extends State<FillBlankWidget> {
  String question = "";
  String correctAnswer = "";
  String? userAnswer;
  bool showResult = false; // your UI is result screen
  final TextEditingController _controller = TextEditingController();
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    question = widget.data.question;
    correctAnswer = widget.data.answer ?? "";
    userAnswer = widget.data.answer;
  }

  void submitAnswer() {
    final userAnswer = _controller.text.trim().toLowerCase();
    setState(() {
      isCorrect = userAnswer == correctAnswer.toLowerCase();
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = AppDimensions.getResponsiveHeight(context);
    final width = AppDimensions.getResponsiveWidth(context);
    final isLandscape = Responsive.isLandscape(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: isLandscape ? height * 0.8 : height * 0.5,
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
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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

          /// QUESTION WITH BLANK
          Text(
            "Q. $question",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          /// INPUT FIELD (before submit)
          /*if (!showResult)
            Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Votre réponse...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitAnswer,
                    child: const Text("Valider"),
                  ),
                ),
              ],
            ),*/
          if (!showResult)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// LABEL (optional but modern UX)
                const Text(
                  "Votre réponse",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 8),

                /// MODERN INPUT FIELD
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _controller,
                          onChanged: (_) => setState(() {}),
                          // for button enable/disable
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Tapez votre réponse...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),

                            /// LEFT ICON
                            prefixIcon: const Icon(Icons.edit, size: 20),

                            /// REMOVE DEFAULT BORDER
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 1.5,
                              ),
                            ),

                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _controller.text.trim().isEmpty
                        ? Container()
                        : GestureDetector(
                            onTap: _controller.text.trim().isEmpty
                                ? null
                                : submitAnswer,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _controller.text.trim().isEmpty
                                    ? AppColors.greenShadowColor
                                    : AppColors.greenColor,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),

                    // const SizedBox(height: 24),

                    /// MODERN BUTTON
                  ],
                ),
              ],
            ),

          /// RESULT
          if (showResult) ...[
            Row(
              children: [
                const Text("Votre Réponse 👉 "),
                Text(
                  "“${_controller.text.trim()}”",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                const Text("Réponse 👉 "),
                Text(
                  "“$correctAnswer”",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  Text(
                    isCorrect
                        ? "Bravo ! Vous avez bien répondu à votre question."
                        : "Oups ! Ce n'est pas correct.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  isCorrect
                      ? SvgPicture.asset(AppAssets.correct_image, height: 80)
                      : const Icon(Icons.close, size: 100, color: Colors.red),
                ],
              ),
            ),
          ],
          const Spacer(),

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
}
