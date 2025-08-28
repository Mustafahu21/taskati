import 'package:hive_flutter/adapters.dart';
import 'package:taskati/models/task_model.dart';

class LocalHelper {
  static late Box _userBox;
  static late Box _taskBox;

  static Box get userBox => _userBox;
  static Box get taskBox => _taskBox;

  static String kUserBox = 'user';
  static String kTaskBox = 'task';
  static String kName = 'name';
  static String kPfp = 'pfp';
  static String kIsUploaded = 'isUploaded';

  static init() async {
    await Hive.openBox(kUserBox);
    await Hive.openBox(kTaskBox);
    Hive.registerAdapter(TaskModelAdapter());
    _userBox = Hive.box(kUserBox);
    _taskBox = Hive.box(kTaskBox);
  }

  static cacheData(String key, dynamic value) {
    _userBox.put(key, value);
  }

  static getData(String key) {
    return _userBox.get(key);
  }

  static cacheTask(String key, TaskModel task) {
    _taskBox.put(key, task);
  }

  static getTask(String key) {
    return _taskBox.get(key);
  }
}
