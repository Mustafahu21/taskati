import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/components/main_button.dart';
import 'package:taskati/components/task_fields.dart';
import 'package:taskati/core/services/helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, this.taskModel});
  final TaskModel? taskModel;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey = GlobalKey<FormState>();

  int selectedColor = 0;

  List<Color> chipColors = [
    AppColors.primaryColor,
    AppColors.orangeColor,
    AppColors.redColor,
  ];

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  var startTimeController = TextEditingController(
    text: DateFormat('hh:mm a').format(DateTime.now()),
  );
  var endTimeController = TextEditingController(
    text: DateFormat('hh:mm a').format(DateTime.now()),
  );

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModel?.title ?? '';
    descriptionController.text = widget.taskModel?.description ?? '';
    dateController.text =
        widget.taskModel?.date ??
        DateFormat("yyyy-MM-dd").format(DateTime.now());
    startTimeController.text =
        widget.taskModel?.stDate ??
        DateFormat("hh:mm a").format(DateTime.now());
    endTimeController.text =
        widget.taskModel?.enDate ??
        DateFormat("hh:mm a").format(DateTime.now());
    selectedColor = widget.taskModel?.color ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(key: formKey, child: formFields()),
        ),
      ),
      bottomNavigationBar: navBar(context),
    );
  }

  SafeArea navBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MainButton(
          text: widget.taskModel != null ? 'Update Task' : 'Create Task',
          height: 60,
          onPressed: () {
            String id = '';
            if (widget.taskModel != null) {
              id = widget.taskModel!.id;
            } else {
              id = DateTime.now().millisecondsSinceEpoch.toString();
            }
            LocalHelper.cacheTask(
              id,
              TaskModel(
                title: titleController.text,
                description: descriptionController.text,
                date: dateController.text,
                stDate: startTimeController.text,
                enDate: endTimeController.text,
                color: selectedColor,
                id: id,
                isCompleted: false,
              ),
            );
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Column formFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleForm(),
        descriptionForm(),
        dateForm(),
        startNendTime(),
        SizedBox(height: 20),
        colorSelection(),
      ],
    );
  }

  Column descriptionForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: TextStyles.getTitle(fontSize: 20)),
        SizedBox(height: 10),
        TaskFields(
          hint: 'Enter description',
          controller: descriptionController,
          maxLines: 4,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Column dateForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date', style: TextStyles.getTitle(fontSize: 20)),
        SizedBox(height: 10),
        TaskFields(
          hint: dateController.text,
          suffixIcon: Icon(Icons.calendar_month, color: AppColors.primaryColor),
          controller: dateController,
          readonly: true,
          onTap: () {
            showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              initialDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365 * 5)),
            ).then((value) {
              if (value != null) {
                dateController.text = DateFormat('yyyy-MM-dd').format(value);
              }
            });
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Row colorSelection() {
    return Row(
      spacing: 4,
      children: List.generate(chipColors.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = index;
            });
          },
          child: CircleAvatar(
            backgroundColor: chipColors[index],
            radius: 25,
            child: Icon(
              Icons.check,
              color: selectedColor == index ? Colors.white : Colors.transparent,
            ),
          ),
        );
      }),
    );
  }

  Row startNendTime() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Start Time', style: TextStyles.getTitle(fontSize: 20)),
              SizedBox(height: 10),
              TaskFields(
                hint: startTimeController.text,
                suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.primaryColor,
                ),
                controller: startTimeController,
                readonly: true,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    if (value != null) {
                      startTimeController.text = value.format(context);
                    }
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('End Time', style: TextStyles.getTitle(fontSize: 20)),
              SizedBox(height: 10),
              TaskFields(
                hint: endTimeController.text,
                suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.primaryColor,
                ),
                controller: endTimeController,
                readonly: true,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    if (value != null) {
                      endTimeController.text = value.format(context);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column titleForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title', style: TextStyles.getTitle(fontSize: 20)),
        SizedBox(height: 10),
        TaskFields(hint: 'Enter title', controller: titleController),
        SizedBox(height: 20),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryColor, size: 32),
      title: Text(
        widget.taskModel != null ? 'Edit Task' : 'Add Task',
        style: TextStyles.getTitle(color: AppColors.primaryColor, fontSize: 22),
      ),
    );
  }
}
