import 'package:flutter/material.dart';
import 'package:intello_new/features/lesson_details_updated/data/models/activity_model.dart' show ActivityModel;

class ActivityFlowScreen extends StatefulWidget {
  final List<ActivityModel> activities;

  const ActivityFlowScreen({super.key, required this.activities});

  @override
  State<ActivityFlowScreen> createState() => _ActivityFlowScreenState();
}

class _ActivityFlowScreenState extends State<ActivityFlowScreen> {
  int currentIndex = 0;

  void next() {
    if (currentIndex < widget.activities.length - 1) {
      setState(() => currentIndex++);
    } else {
      debugPrint("Flow Completed ✅");
      Navigator.pop(context); // or go to result screen
    }
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activities[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Activity ${currentIndex + 1}/${widget.activities.length}"),
      ),
      body: _buildActivityWidget(activity),
    );
  }

  Widget _buildActivityWidget(ActivityModel activity) {
    switch (activity.type) {
      case "multiple_choice":
        return Container();
          /*MultipleChoiceWidget(
          data: activity,
          onNext: next,
        );*/

      case "true_false":
        return Container();
          /*TrueFalseWidget(
          data: activity,
          onNext: next,
        );*/

      case "fill_blank":
        return Container();
        /*FillBlankWidget(
          data: activity,
          onNext: next,
        );*/

      case "short_answer":
        return Container();
        /*ShortAnswerWidget(
          data: activity,
          onNext: next,
        );*/

      default:
        return const Center(child: Text("Unknown Activity"));
    }
  }
}