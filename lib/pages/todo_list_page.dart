import 'package:flutter/material.dart';
import 'package:listatarefas/entities/task.dart';
import 'package:listatarefas/styles/app_theme.dart';
import 'package:listatarefas/widgets/task_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Task> tasks = [];

  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: const InputDecoration(
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Ex.: Estudar flutter',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: addToList,
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          primary: Colors.cyan),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Task task in tasks)
                        TaskListItem(
                          task: task,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${tasks.length} tarefas pendentes',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed:
                          tasks.isNotEmpty ? showClearConfirmationDialog : null,
                      child: const Text(
                        'Limpar tudo',
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan,
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addToList() {
    setState(() {
      String text = taskController.text;
      if (text.isNotEmpty) {
        Task task = Task(title: text, date: DateTime.now());
        tasks.add(task);
        taskController.clear();
      } else {
        showInSnackBar('Favor informar um nome para a tarefa');
      }
    });
  }

  void showClearConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Você tem certeja que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              clearTaskList();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(primary: Colors.red),
            child: const Text('Limpar tudo'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(primary: Colors.grey),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void clearTaskList() {
    setState(() {
      tasks.clear();
    });
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 4,
        backgroundColor: AppTheme.snackBarBackgroundColor,
      ),
    );
  }

  void onDelete(Task task) {
    int deletedTaskIndex = 0;

    setState(() {
      deletedTaskIndex = tasks.indexOf(task);
      if (deletedTaskIndex != -1) {
        tasks.remove(task);
      }
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'A tarefa ${task.title} foi removida.',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: AppTheme.snackBarBackgroundColor,
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              tasks.insert(deletedTaskIndex, task);
            });
          },
        ),
      ),
    );
  }
}
