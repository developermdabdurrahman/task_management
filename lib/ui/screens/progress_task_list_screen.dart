import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../widgets/tm_app_bar.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  static const String name = '/progress-task-list';


  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
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
          // return const TaskItemWidget(taskColor: Colors.pink,);
        });
  }
}
