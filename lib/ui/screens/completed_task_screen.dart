import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../widgets/tm_app_bar.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  static const String name = '/completed-task-list';


  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: _buildTaskListView(),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          // return const TaskItemWidget(taskColor: Colors.green,);
        });
  }
}
