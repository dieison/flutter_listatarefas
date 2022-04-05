import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:listatarefas/entities/task.dart';

class TaskListItem extends StatelessWidget {
  TaskListItem({
    Key? key,
    required this.task,
    required this.onDelete,
  }) : super(key: key);

  final Task task;

  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');

  final Function(Task) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        direction: Axis.horizontal,
        key: key,
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const BehindMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            onDelete(task);
          }),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                onDelete(task);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Apagar',
            ),
          ],
        ),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Adicionada em ' + formatter.format(task.date),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
