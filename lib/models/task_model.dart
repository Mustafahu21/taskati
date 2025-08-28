import 'package:hive_flutter/adapters.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String stDate;
  @HiveField(5)
  final String enDate;
  @HiveField(6)
  final int color;
  @HiveField(7)
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.stDate,
    required this.enDate,
    required this.color,
    required this.isCompleted,
  });
}
