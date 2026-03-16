import 'package:flutter/material.dart';
import 'package:intello_new/core/constants/app_colors.dart';

import '../../../account/presentation/widget/primary_button.dart';
import '../../domain/entity/option.dart';
import '../../domain/entity/question.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final VoidCallback onNext;

  const QuestionCard({super.key, required this.question, required this.onNext});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedAnswer;

  bool get answered => selectedAnswer != null;

  @override
  Widget build(BuildContext context) {
    final options = widget.question.options;
    final correctId = widget.question.correctAnswerId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// QUESTION
            Text(
              "Q. ${widget.question.question}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// OPTIONS
            ...options.map((Option option) {
              return RadioListTile<String>(
                value: option.id,
                groupValue: selectedAnswer,
                title: Text(option.value),
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value;
                  });
                },
              );
            }),

            const SizedBox(height: 20),

            /// RESULT
            if (answered)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Résultat 👉 ${options.firstWhere((o) => o.id == correctId).value}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      "Bravo ! Vous avez bien répondu à votre question.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Center(child: Icon(Icons.celebration, size: 60)),
                ],
              ),

            const Spacer(),

            /// NEXT BUTTON
            PrimaryButton(title: 'Question suivante', onPressed: answered ? widget.onNext : null),

            /*SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: answered ? widget.onNext : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Question suivante →"),
              ),
            ),*/
            const SizedBox(height: 10),

            Center(
              child: TextButton(
                onPressed: widget.onNext,
                child: Text(
                  "Ignorer",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
