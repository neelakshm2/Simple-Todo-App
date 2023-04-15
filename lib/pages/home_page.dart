import 'package:flutter/material.dart';
import 'package:todo/auth.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/utils/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
        actions: [
          IconButton(
              onPressed: () {
                logoutUser();
                Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
                onTap: () {
                  todoProvider.deleteAllTodo().then((value) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("All Todos Deleted")));
                  });
                },
                title: Text("Delete All Todos"),
                leading: Icon(Icons.delete_forever))
          ],
        ),
      ),
      body: _selectedIndex == 0 ? showOngoingTodos() : showCompletedTodos(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) => setState(() {
                _selectedIndex = value;
              }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todo List"),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: "Completed")
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.NewTodo);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget showOngoingTodos() {
    return Consumer(
      builder: (context, TodoProvider provider, child) {
        return ListView.builder(
          itemCount: provider.allTodos.length,
          itemBuilder: (context, index) {
            return provider.allTodos[index].data["isDone"]
                ? SizedBox()
                : ListTile(
                    title: Text(provider.allTodos[index].data['task']),
                    leading: Checkbox(
                      value: provider.allTodos[index].data['isDone'] ?? false,
                      onChanged: (value) {
                        provider.markCompleted(provider.allTodos[index].$id,
                            !provider.allTodos[index].data['isDone']);
                      },
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          provider.deleteTodo(provider.allTodos[index].$id);
                        },
                        icon: Icon(Icons.delete)),
                  );
          },
        );
      },
    );
  }

  Widget showCompletedTodos() {
    return Consumer(
      builder: (context, TodoProvider provider, child) {
        return ListView.builder(
          itemCount: provider.allTodos.length,
          itemBuilder: (context, index) {
            return !provider.allTodos[index].data["isDone"]
                ? SizedBox()
                : ListTile(
                    title: Text(provider.allTodos[index].data['task']),
                    leading: Checkbox(
                      value: provider.allTodos[index].data['isDone'] ?? false,
                      onChanged: (value) {
                        provider.markCompleted(provider.allTodos[index].$id,
                            !provider.allTodos[index].data['isDone']);
                      },
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          provider.deleteTodo(provider.allTodos[index].$id);
                        },
                        icon: Icon(Icons.delete)),
                  );
          },
        );
      },
    );
  }
}
