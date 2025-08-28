import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/asset_names.dart';
import 'package:taskati/core/services/helper.dart';
import 'package:taskati/features/task_page/widgets/task_card.dart';
import 'package:taskati/models/task_model.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.selectedDate});

  final String selectedDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: LocalHelper.taskBox.listenable(),
        builder: (context, value, child) {
          List<TaskModel> tasks = [];
          for (var task in value.values) {
            if (task.date == selectedDate) {
              tasks.add(task);
            }
          }
          if (tasks.isEmpty) {
            return Center(child: Lottie.asset(AppAssets.empty));
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              return TaskCard(task: tasks[index]);
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: tasks.length,
          );
        },
      ),
    );
  }
}
