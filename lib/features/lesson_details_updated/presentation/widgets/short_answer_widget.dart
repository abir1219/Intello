import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/answer_input_hint.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../account/presentation/widget/primary_button.dart';
import '../../data/models/activity_model.dart';

class ShortAnswerWidget extends StatefulWidget {
  final ActivityModel data;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLast;

  const ShortAnswerWidget({
    super.key,
    required this.data,
    required this.onNext,
    required this.onPrevious,
    required this.isLast,
  });

  @override
  State<ShortAnswerWidget> createState() => _ShortAnswerWidgetState();
}

class _ShortAnswerWidgetState extends State<ShortAnswerWidget> {
  late String question;
  late String correctAnswer;

  bool showResult = false;
  bool isCorrect = false;
  int wrongAttemptCount = 0;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    question = widget.data.question ?? "";
    correctAnswer =
        widget.data.answer?.toString() ?? widget.data.sampleAnswer ?? "";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isAnswerCorrect(String answer) {
    if (correctAnswer.isEmpty) {
      return answer.isNotEmpty;
    }
    return answer.toLowerCase() == correctAnswer.toLowerCase();
  }

  void submitAnswer() {
    final answer = _controller.text.trim();
    final correct = _isAnswerCorrect(answer);
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
      isShortAnswer: true,
      validation: widget.data.validation,
    );

    final height = AppDimensions.getResponsiveHeight(context);
    final isLandscape = Responsive.isLandscape(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: isLandscape ? height * 0.8 : height * 0.52,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.onPrevious,
                child: const Text(
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
          if (_controller.text.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.clear();
                      showResult = false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
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
          ],
          const SizedBox(height: 20),

          if (!showResult)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Votre réponse",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
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
                            isShortAnswer: true,
                            correctAnswer: correctAnswer,
                          ),
                          minLines: 1,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            prefixIcon: const Icon(Icons.edit, size: 20),
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
                    if (_controller.text.trim().isNotEmpty)
                      GestureDetector(
                        onTap: submitAnswer,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greenColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

          const SizedBox(height: 10),

          if (showResult) ...[
            Row(
              children: [
                const Text("Votre Réponse 👉 "),
                Flexible(
                  child: Text(
                    "“${_controller.text.trim()}”",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            if (!isFirstWrongAttempt && correctAnswer.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Réponse 👉 "),
                  Flexible(
                    child: Text(
                      "“$correctAnswer”",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
            if (!isFirstWrongAttempt &&
                widget.data.explanation != null &&
                widget.data.explanation!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                "Résultat 👉 “${widget.data.explanation}”",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
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

          const SizedBox(height: 30),

          Center(
            child: PrimaryButton(
              title: "Question suivante",
              onPressed: widget.onNext,
            ),
          ),
          const SizedBox(height: 10),

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
