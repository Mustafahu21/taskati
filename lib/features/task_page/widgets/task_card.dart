import 'package:flutter/material.dart';
import 'package:taskati/core/constants/chip_colors.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/models/task_model.dart';
import 'package:taskati/features/add_task/pages/add_task_screen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // pushTo(context, AddEditTaskScreen(taskModel: task));
      },
      child: Container(
        height: 115,
        padding: const EdgeInsets.all(12),
        // margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: task.isCompleted ? Colors.green : chipColors[task.color],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.getTitle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.white, size: 17),
                      SizedBox(width: 6),
                      Text(
                        '${task.stDate} : ${task.enDate}',
                        style: TextStyles.getSmall(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    task.description.isEmpty
                        ? 'No Description'
                        : task.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.getBody(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Container(width: 1, height: 60, color: Colors.white),
            SizedBox(width: 5),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted ? 'DONE' : 'TODO',
                style: TextStyles.getSmall(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
