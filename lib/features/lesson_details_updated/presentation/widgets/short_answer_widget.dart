import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
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
    required this.onPrevious, required this.isLast,
  });

  @override
  State<ShortAnswerWidget> createState() => _ShortAnswerWidgetState();
}

class _ShortAnswerWidgetState extends State<ShortAnswerWidget> {
  String question = "";
  String answer = "";

  @override
  void initState() {
    super.initState();
    question = widget.data.question;
    answer = widget.data.answer ?? "";
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

          /// 🔹 Question
          Text(
            "Q. $question",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          answer.isNotEmpty
              ? Text(
                  "Résultat 👉 “$answer”",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                )
              : Container(),

          const Spacer(),
          //const SizedBox(height: 30),

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
