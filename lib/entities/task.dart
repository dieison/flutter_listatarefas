import 'package:flutter/material.dart';

class Task {
  String title;
  DateTime date;

  Task({required this.title, required this.date});

  Task.fromJson(Map<String, dynamic> json)
    : title = json['title'].toString(),
      date = DateTime.parse(json['date'].toString());

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
    };
  }
}