import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_count_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskColor,
    required this.taskModel,
    required this.status,
  });

  final Color taskColor;
  final String status;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
          title: Text(taskModel.title ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskModel.description ?? ''),
              Text('Date: ${taskModel.createdDate ?? ''}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: taskColor,
                    ),
                    child: Text(status),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_note_outlined)),
                      IconButton(
                        onPressed: () {
                          _deleteTaskDialog(context);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _deleteTaskDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('DELETE'),
            content: const Text('Are you sure?'),
            actions: [
              TextButton(
                onPressed: () async{
                  Navigator.pop(context);
                  showSnackBarMessage(context, 'Task deleted successfully');
                  await _deleteTask(taskModel.sId ?? '', context);
                },

                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  Future<void> _deleteTask(String id, context) async {
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteTaskUrl(id),
    );
    if(response.isSuccess){
      Navigator.pop(context);
    }
    else{
      showSnackBarMessage(context, response.errorMessage);
    }
  }
}
