import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/main_button.dart';
import 'package:taskati/core/constants/asset_names.dart';
import 'package:taskati/core/extensions/navigations.dart';
import 'package:taskati/core/services/helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/add_task/pages/add_task_screen.dart';
import 'package:taskati/features/profile/profile_screen.dart';
import 'package:taskati/features/task_page/widgets/task_list.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              header(context),
              SizedBox(height: 25),
              dateNAddTask(context),
              SizedBox(height: 20),
              datePicker(),
              SizedBox(height: 20),
              TaskList(selectedDate: selectedDate),
            ],
          ),
        ),
      ),
    );
  }

  DatePicker datePicker() {
    return DatePicker(
      DateTime.now(),
      height: 115,
      width: 95,
      initialSelectedDate: DateTime.now(),
      selectionColor: AppColors.primaryColor,
      onDateChange: (date) {
        setState(() {
          selectedDate = DateFormat('yyyy-MM-dd').format(date);
        });
      },
    );
  }

  Row dateNAddTask(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM d, yyyy').format(DateTime.now()),
              style: TextStyles.getTitle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('EEEE').format(DateTime.now()),
              style: TextStyles.getTitle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        MainButton(
          onPressed: () {
            pushTo(context, AddTaskScreen());
          },
          text: 'Add Task',
          width: 125,
          height: 55,
        ),
      ],
    );
  }

  Row header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalHelper.getData(LocalHelper.kName) ?? '',
              style: TextStyles.getBody(
                fontSize: 20,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Have a nice day', style: TextStyles.getBody(fontSize: 18)),
          ],
        ),
        GestureDetector(
          onTap: () {
            pushTo(context, ProfileScreen()).then((value) => setState(() {}));
          },
          child: CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.primaryColor,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primaryColor,
              backgroundImage: LocalHelper.getData(LocalHelper.kPfp) != null
                  ? FileImage(File(LocalHelper.getData(LocalHelper.kPfp) ?? ''))
                  : AssetImage(AppAssets.user) as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }
}
