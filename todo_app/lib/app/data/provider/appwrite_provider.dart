import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/foundation.dart';
import 'package:todo_app/core/constants/app_write_constants.dart';
import 'package:todo_app/presentation/todo_screen/model/todo_model.dart';

class AppWriteProvider {
  Client client = Client();
  Account? account;
  late Databases databases;

  AppWriteProvider() {
    client
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("65e56e8009b0e8613eeb")
        .setSelfSigned(status: true);
    account = Account(client);
      databases = Databases(client);
  
  }
  
  Future<models.User> signup(Map map) async {
    final response = account!.create(
        userId: map["userId"],
        email: map["email"],
        password: map["password"],
        name: map["name"]);
    return response;
  }

  Future<models.Session> login(Map map) async {
    final response = account!.createEmailSession(
        email: map["email"], password: map["password"]);
    return response;
  }
Future<models.Document> createTask(Todo todo) async {
  try {
    final response = await databases.createDocument(
      collectionId: AppWriteConstants.collectionId, // Specify your collection ID
      data: todo.toJson(), databaseId: AppWriteConstants.databaseId, documentId: todo.id
    );
    return response;
  } catch (e) {
    if (kDebugMode) {
      print('Error creating task: $e');
    }
    rethrow;
  }
}


  Future<void> updateTask(Todo todo) async {
    try {
      if (kDebugMode) {
        print(todo.id);
      }
      await databases.updateDocument(
        collectionId: AppWriteConstants.collectionId, // Specify your collection ID
        documentId: todo.id,
        data: todo.toJson(), databaseId: AppWriteConstants.databaseId,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error updating task: $e');
      }
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await databases.deleteDocument(
        collectionId: AppWriteConstants.collectionId , // Specify your collection ID
        documentId: taskId, databaseId: AppWriteConstants.databaseId,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting task: $e');
      }
      rethrow;
    }
  }

  Future<List<Todo>> getTasks() async {
  try {
    final response = await databases.listDocuments(
      collectionId: AppWriteConstants.collectionId,
      databaseId: AppWriteConstants.databaseId,
    );

    final List<Todo> tasks = [];
    for (final document in response.documents) {
      final data = document.data;
      final todo = Todo.fromJson(data);
      tasks.add(todo);
    }

    return tasks;
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching tasks: $e');
    }
    rethrow;
  }
}

}
