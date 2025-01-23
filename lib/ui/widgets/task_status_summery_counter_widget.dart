import 'package:flutter/material.dart';

class TaskStatusSummeryCounterWidget extends StatelessWidget {
  const TaskStatusSummeryCounterWidget({
    super.key,
    required this.counter,
    required this.title,
  });

  final String counter;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            Text(
              counter,
              style: textStyle.titleLarge,
            ),
            Text(
              title,
              style: textStyle.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}