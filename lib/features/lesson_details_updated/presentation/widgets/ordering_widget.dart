import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../exercise/presentation/widgets/primary_button.dart';
import '../../data/models/activity_model.dart';

class OrderingWidget extends StatefulWidget {
  // final ActivityModel data;
  final dynamic data;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLast;

  const OrderingWidget({
    super.key,
    required this.data,
    required this.onNext,
    required this.onPrevious,
    required this.isLast,
  });

  @override
  State<OrderingWidget> createState() => _OrderingWidgetState();
}

class _OrderingWidgetState extends State<OrderingWidget> {
  late List<String> items;

  /// selected sequence
  List<String> selectedOrder = [];

  /// item -> selected index
  Map<String, int> selectedIndexes = {};

  bool showResult = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();

    items = List<String>.from(widget.data.items ?? []);
  }

  void onSelectItem(String item) {
    /// prevent reselection
    if (selectedOrder.contains(item)) return;

    setState(() {
      selectedOrder.add(item);

      selectedIndexes[item] = selectedOrder.length;
    });
  }

  void checkAnswer() {
    final correctOrder = widget.data.correctOrder ?? [];

    bool matched = true;

    if (selectedOrder.length != correctOrder.length) {
      matched = false;
    } else {
      for (int i = 0; i < correctOrder.length; i++) {
        if (selectedOrder[i] != correctOrder[i]) {
          matched = false;
          break;
        }
      }
    }

    setState(() {
      isCorrect = matched;
      showResult = true;
    });
  }

  void resetAnswer() {
    setState(() {
      selectedOrder.clear();
      selectedIndexes.clear();

      showResult = false;
      isCorrect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = AppDimensions.getResponsiveHeight(context);
    final isLandscape = Responsive.isLandscape(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: isLandscape ? height * 0.8 : height * 0.58,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
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

          const SizedBox(height: 10),

          /// QUESTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Q. ${widget.data.instruction}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (selectedOrder.isNotEmpty)
                GestureDetector(
                  onTap: resetAnswer,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.greenColor,
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.refresh, color: Colors.white, size: 18),

                        SizedBox(width: 6),

                        Text(
                          "Réessayer",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 25),

          /// ITEMS
          ...List.generate(items.length, (index) {
            final item = items[index];

            final isSelected = selectedOrder.contains(item);

            return GestureDetector(
              onTap: () => onSelectItem(item),

              child: Container(
                margin: const EdgeInsets.only(bottom: 12),

                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),

                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade50 : Colors.white,

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),

                child: Row(
                  children: [
                    /// selection order
                    Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                      ),

                      child: Text(
                        isSelected ? "${selectedIndexes[item]}" : "",

                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          /// SUBMIT BUTTON
          if (!showResult)
            Center(
              child: PrimaryButton(
                title: "Vérifier",
                onPressed:
                    selectedOrder.length ==
                        (widget.data.correctOrder?.length ?? 0)
                    ? checkAnswer
                    : () {},
              ),
            ),

          /// RESULT
          if (showResult) ...[
            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [
                  Text(
                    isCorrect
                        ? "Bravo ! L'ordre est correct."
                        : "Oups ! L'ordre n'est pas correct.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  isCorrect
                      ? SvgPicture.asset(
                          AppAssets.correct_image,
                          height: 80,
                          width: 80,
                        )
                      : const Icon(Icons.close, color: Colors.red, size: 80),

                  const SizedBox(height: 20),

                  /// CORRECT ANSWER
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Résultat 👉 ${(widget.data.correctOrder ?? []).join(" → ")}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// NEXT BUTTON
                  PrimaryButton(
                    title: "Question suivante",
                    onPressed: widget.onNext,
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 10),

          /// SKIP
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
