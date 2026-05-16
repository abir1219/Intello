import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intello_new/core/constants/app_colors.dart';
import 'package:intello_new/features/lesson_details_updated/data/models/activity_model.dart'
    show ActivityModel;

import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/answer_input_hint.dart';
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
  int wrongAttemptCount = 0;

  @override
  void initState() {
    super.initState();
    question = widget.data.question!;
    correctAnswer = widget.data.answer ?? widget.data.sampleAnswer;
    userAnswer = widget.data.answer;
  }

  void submitAnswer() {
    final answer = _controller.text.trim().toLowerCase();
    final correct = answer == correctAnswer.toLowerCase();
    setState(() {
      isCorrect = correct;
      showResult = true;
      if (!correct) {
        wrongAttemptCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFirstWrongAttempt =
        showResult && !isCorrect && wrongAttemptCount == 1;
    final hintText = AnswerInputHint.hintText(
      correctAnswer: AnswerInputHint.forHint(correctAnswer),
      isShortAnswer: false,
      validation: widget.data.validation,
    );

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
          Row(
            children: [
              Flexible(
                child: Text(
                  "Q. $question",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if(_controller.text.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.text = "";
                      showResult = false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.greenColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.refresh, color: AppColors.whiteColor),
                        Text(
                          "Réessayer",
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                          keyboardType: AnswerInputHint.keyboardType(correctAnswer),
                          maxLines: AnswerInputHint.maxLines(
                            isShortAnswer: false,
                            correctAnswer: correctAnswer,
                          ),
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: hintText,
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
          const SizedBox(height: 10),

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
            if (!isFirstWrongAttempt) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Réponse 👉 "),
                  Text(
                    "“$correctAnswer”",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    isCorrect
                        ? "Bravo ! Vous avez bien répondu à votre question."
                        : isFirstWrongAttempt
                            ? "Oups ! Votre réponse est incorrecte. Réessayez encore une fois."
                            : "Oups ! Ce n'est pas correct.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isCorrect)
                    SvgPicture.asset(AppAssets.correct_image, height: 80)
                  else /* if (!isFirstWrongAttempt) */
                    const Icon(Icons.close, size: 100, color: Colors.red),
                ],
              ),
            ),
          ],
          //const Spacer(),
          const SizedBox(height: 30),

          /// NEXT BUTTON
          Center(
            child: PrimaryButton(
              title: "Question suivante",
              onPressed: widget.onNext,
            ),
          ),
          const SizedBox(height: 10),

          /// IGNORE
          if (!widget.isLast)
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
