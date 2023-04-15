import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import '../auth.dart';
import 'package:appwrite/models.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    readTodos();
  }

  String databaseid = "6439dbab5dd50501b523";
  String collectionid = "6439dbb2e8e73e525403";

  final Databases database = Databases(client);

  List<Document> _todos = [];

  List<Document> get allTodos => _todos;

  //Read all the todos
  Future readTodos() async {
    try {
      final data = await database.listDocuments(
          databaseId: databaseid, collectionId: collectionid);
      _todos = data.documents;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //Create a new todo
  Future createNewTodo(String task, {bool isDone = false}) async {
    final collection = await database.createDocument(
        databaseId: databaseid,
        collectionId: collectionid,
        documentId: ID.unique(),
        data: {
          "task": task,
          "isDone": false,
        });
    readTodos();
    notifyListeners();
  }

  //change todo to complete
  Future markCompleted(String id, bool isDone) async {
    final data = await database.updateDocument(
        databaseId: databaseid,
        collectionId: collectionid,
        documentId: id,
        data: {"isDone": isDone});
    readTodos();
    notifyListeners();
  }

  //delete a todo
  Future deleteTodo(String id) async {
    final data = await database.deleteDocument(
        databaseId: databaseid, collectionId: collectionid, documentId: id);
    readTodos();
    notifyListeners();
  }

  //delete all the todos

  Future deleteAllTodo() async {
    for (var i = 0; i < _todos.length; i++) {
      await database.deleteDocument(
          databaseId: databaseid,
          collectionId: collectionid,
          documentId: _todos[i].$id);
    }
    readTodos();
    notifyListeners();
  }
}
