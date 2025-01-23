import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../widgets/tm_app_bar.dart';

class CanceledListScreen extends StatefulWidget {
  const CanceledListScreen({super.key});

  static const String name = '/canceled-task-list';


  @override
  State<CanceledListScreen> createState() => _CanceledListScreenState();
}

class _CanceledListScreenState extends State<CanceledListScreen> {
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
          // return const TaskItemWidget(taskColor: Colors.red,);
        });
  }
}
