import 'package:flutter/material.dart';
import '../../../../core/utils/app_dimenstion.dart';
import '../../../../core/utils/responsive.dart';
import '../../../account/presentation/widget/primary_button.dart';
import '../../data/models/activity_model.dart';

class MatchingQuesAnsWidget extends StatefulWidget {
  final ActivityModel data;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLast;

  const MatchingQuesAnsWidget({
    super.key,
    required this.data,
    required this.onNext,
    required this.onPrevious, required this.isLast,
  });

  @override
  State<MatchingQuesAnsWidget> createState() =>
      _MatchingQuesAnsWidgetState();
}

class _MatchingQuesAnsWidgetState extends State<MatchingQuesAnsWidget> {
  int? selectedLeftIndex;
  Map<int, int> matchedPairs = {};

  late List<String> leftItems;
  late List<String> rightItems;

  @override
  void initState() {
    super.initState();

    final pairs = widget.data.pairs ?? [];

    /// ✅ FIX: use MatchPair model instead of Map
    leftItems = pairs.map((e) => e.left).toList();

    rightItems = pairs.map((e) => e.right).toList()
      ..shuffle(); // shuffle for challenge
  }

  void onLeftTap(int index) {
    if (matchedPairs.containsKey(index)) return;

    setState(() {
      selectedLeftIndex = index;
    });
  }

  void onRightTap(int index) {
    if (selectedLeftIndex == null) return;
    if (matchedPairs.containsValue(index)) return;

    setState(() {
      matchedPairs[selectedLeftIndex!] = index;
      selectedLeftIndex = null;
    });
  }

  bool get isCompleted => matchedPairs.length == leftItems.length;

  /// ✅ OPTIONAL: Check correctness (important improvement)
  bool isCorrectMatch(int leftIndex, int rightIndex) {
    final pairs = widget.data.pairs ?? [];
    return pairs[leftIndex].right == rightItems[rightIndex];
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
          /// QUESTION
          Text(
            "Q. ${widget.data.question}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          /// MATCHING UI
          Row(
            children: [
              /// LEFT SIDE
              Expanded(
                child: Column(
                  children: List.generate(leftItems.length, (index) {
                    final isSelected = selectedLeftIndex == index;
                    final isMatched = matchedPairs.containsKey(index);

                    return _card(
                      text: leftItems[index],
                      color: isMatched
                          ? Colors.green.shade100
                          : isSelected
                          ? Colors.blue.shade100
                          : Colors.white,
                      onTap: () => onLeftTap(index),
                    );
                  }),
                ),
              ),

              const SizedBox(width: 10),

              /// RIGHT SIDE
              Expanded(
                child: Column(
                  children: List.generate(rightItems.length, (index) {
                    final isMatched =
                    matchedPairs.containsValue(index);

                    /// ✅ Optional: show correct/incorrect color
                    Color color = Colors.white;

                    if (isMatched) {
                      final leftIndex = matchedPairs.entries
                          .firstWhere((e) => e.value == index)
                          .key;

                      color = isCorrectMatch(leftIndex, index)
                          ? Colors.green.shade100
                          : Colors.red.shade100;
                    }

                    return _card(
                      text: rightItems[index],
                      color: color,
                      onTap: () => onRightTap(index),
                    );
                  }),
                ),
              ),
            ],
          ),

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

  Widget _card({
    required String text,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}