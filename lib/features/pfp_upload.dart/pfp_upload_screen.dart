import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/components/main_button.dart';
import 'package:taskati/core/constants/asset_names.dart';
import 'package:taskati/core/extensions/errors.dart';
import 'package:taskati/core/extensions/navigations.dart';
import 'package:taskati/core/services/helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/features/task_page/pages/task_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: doneButton(context),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                pfp(),
                SizedBox(height: 20),
                uploadButtons(),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Enter your name'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column uploadButtons() {
    return Column(
      children: [
        MainButton(
          text: 'Upload From Gallery',
          onPressed: () async {
            imageUpload(false);
          },
          width: 275,
          height: 55,
        ),
        SizedBox(height: 10),
        MainButton(
          text: 'Take Photo',
          onPressed: () async {
            imageUpload(true);
          },
          width: 275,
          height: 55,
        ),
      ],
    );
  }

  CircleAvatar pfp() {
    return CircleAvatar(
      radius: 80,
      backgroundColor: AppColors.primaryColor,
      backgroundImage: path != null
          ? FileImage(File(path ?? ''))
          : AssetImage(AppAssets.user),
    );
  }

  AppBar doneButton(BuildContext context) {
    return AppBar(
      actions: [
        TextButton(
          onPressed: () {
            if (path != null && nameController.text.isNotEmpty) {
              LocalHelper.cacheData(LocalHelper.kPfp, path);
              LocalHelper.cacheData(LocalHelper.kName, nameController.text);
              LocalHelper.cacheData(LocalHelper.kIsUploaded, true);
              pushReplacement(context, TaskScreen());
            } else if (path == null && nameController.text.isNotEmpty) {
              showErrorDialog(context, 'Please select an image');
            } else if (nameController.text.isEmpty && path != null) {
              showErrorDialog(context, 'Please enter your name');
            } else {
              showErrorDialog(context, 'Please fill all fields');
            }
            // pushReplacement(context, TaskScreen());
          },
          child: const Text(
            'Done',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  imageUpload(bool isCamera) async {
    var imagePicker = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (imagePicker != null) {
      setState(() {
        path = imagePicker.path;
      });
    }
  }
}
