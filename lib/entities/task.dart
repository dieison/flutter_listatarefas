import 'package:flutter/material.dart';

class Task {
  String title;
  DateTime date;

  Task({required this.title, required this.date});

  Map<String, String> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
    };
  }
}