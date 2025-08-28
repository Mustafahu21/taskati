import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/components/main_button.dart';
import 'package:taskati/core/constants/asset_names.dart';
import 'package:taskati/core/services/helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? path;
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 30, color: AppColors.primaryColor),
        actions: [
          IconButton(
            icon: Icon(Icons.sunny, color: AppColors.primaryColor, size: 30),
            onPressed: () {
              // Handle edit button press
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: AppColors.primaryColor,
                    backgroundImage: FileImage(
                      File(LocalHelper.getData(LocalHelper.kPfp) ?? ''),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 225,
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MainButton(
                                        text: 'Upload From Camera',
                                        onPressed: () {
                                          imageUpload(true);
                                          Navigator.of(context).pop();
                                        },
                                        height: 65,
                                      ),
                                      SizedBox(height: 20),
                                      MainButton(
                                        text: 'Upload From Gallery',
                                        onPressed: () {
                                          imageUpload(false);
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        height: 65,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Divider(),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocalHelper.getData(LocalHelper.kName),
                    style: TextStyles.getTitle(fontSize: 22),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 225,
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                color: Colors.white,
                              ),
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Enter your name',
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    MainButton(
                                      text: 'Update Your Name',
                                      onPressed: () {
                                        LocalHelper.cacheData(
                                          LocalHelper.kName,
                                          nameController.text,
                                        );
                                        setState(() {});
                                        Navigator.of(context).pop();
                                      },
                                      height: 65,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  imageUpload(bool isCamera) async {
    var imagePicker = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (imagePicker != null) {
      LocalHelper.cacheData(LocalHelper.kPfp, imagePicker.path);
      if (!mounted) return;
      setState(() {});
    }
  }
}
