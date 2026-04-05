import 'package:flutter/material.dart';

import '../../lessons/domain/entities/lesson.dart';

class LessonContentWidget extends StatefulWidget {
  final String? content;
  final LirePlus? lirePlus;

  const LessonContentWidget({
    super.key,
    required this.content,
    required this.lirePlus,
  });

  @override
  State<LessonContentWidget> createState() => _LessonContentWidgetState();
}

class _LessonContentWidgetState extends State<LessonContentWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasLirePlus = widget.lirePlus?.enabled ?? false;
    debugPrint("isExpanded-->$isExpanded}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ✅ CONTENT
        Text(
          isExpanded //&& hasLirePlus
              ? '${widget.content ?? ''}\n\n${widget.lirePlus?.extendedContent ?? ''}'
              : (widget.content ?? ''),
          maxLines: isExpanded ? null : 3,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),

        const SizedBox(height: 4),

        /// ✅ BUTTON (only if extra content exists)
        // if (hasLirePlus)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded
                  ? 'Lire moins'
                  : (widget.lirePlus?.buttonLabel ?? 'Lire plus'),
              style: const TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }
}