import 'dart:convert';

import 'package:listatarefas/entities/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRepository {

  late SharedPreferences sharedPreferences;

  TaskRepository() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  void saveTaskList(List<Task> tasks) {
    final String jsonString = json.encode(tasks);
    sharedPreferences.setString('task_list', jsonString);
  }
}