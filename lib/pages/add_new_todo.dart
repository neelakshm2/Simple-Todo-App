import 'package:flutter/material.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:provider/provider.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TodoProvider provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Add New Todo")),
      body: Column(
        children: [
          TextFormField(
            controller: taskController,
            decoration: InputDecoration(label: Text("Enter Task")),
          ),
          ElevatedButton(
              onPressed: () {
                provider.createNewTodo(taskController.text);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("ToDo Added")));
                Navigator.pop(context);
              },
              child: Text("Create Todo"))
        ],
      ),
    );
  }
}
