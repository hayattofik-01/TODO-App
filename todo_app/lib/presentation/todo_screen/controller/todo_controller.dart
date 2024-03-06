import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/network/api_exceptions.dart';
import 'package:todo_app/app/data/response/api_response_status.dart';

import 'package:todo_app/presentation/todo_screen/model/todo_model.dart';
import 'package:todo_app/presentation/todo_screen/repository/todo_repository.dart';

class TodoController extends GetxController {
  final TodoRepository _todoRepository = TodoRepository();

  final RxList<Todo> tasks = <Todo>[].obs;
  final Rx<Status> tasksStatus = Status.loading.obs;

  @override
  void onInit() {
    super.onInit();
    getTasks(); // Fetch tasks on controller initialization
  }

  // Method to generate unique ID for a task based on user ID and timestamp
  String generateUniqueId(String userId) {
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return '$userId-$timestamp';
  }

  // Method to create a new task
  Future<void> createTask(Todo todo) async {
    // Handling errors during task creation
    // ignore: body_might_complete_normally_catch_error
    await _todoRepository.createTask(todo).catchError((error) {
      if (error is NetworkException) {
        Get.snackbar('Network Error', 'Network error while creating task');
      } else if (error is AppwriteException) {
        Get.snackbar('Server Error', error.response["message"]);
      } else {
        if (kDebugMode) {
          print('Error creating task: $error');
        }
        Get.snackbar('Error', 'Error creating task');
      }
    });
    tasks.add(todo);
  }

  // Method to update an existing task
  Future<void> updateTask(Todo todo) async {
    await _todoRepository.updateTask(todo).catchError((error) {
      if (error is NetworkException) {
        Get.snackbar('Network Error', 'Error updating the todo');
      } else if (error is AppwriteException) {
        Get.snackbar('Server Error', error.response["message"]);
      } else {
        if (kDebugMode) {
          print('Error updating task: $error');
        }
        Get.snackbar('Error', 'Error updating task');
      }
    });
    final index = tasks.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      tasks[index] = todo;
    }
  }

  // Method to delete a task
  Future<void> deleteTask(String taskId) async {
    await _todoRepository.deleteTask(taskId).catchError((error) {
      if (error is NetworkException) {
        Get.snackbar('Network Error', 'Network error while deleting task');
      } else if (error is AppwriteException) {
        Get.snackbar('Server Error', error.response["message"]);
      } else {
        if (kDebugMode) {
          print('Error deleting task: $error');
        }
        Get.snackbar('Error', 'Error deleting task');
      }
    });
    tasks.removeWhere((t) => t.id == taskId);
  }

  // Method to fetch tasks
  Future<void> getTasks() async {
    try {
      tasksStatus.value = Status.loading;
      final fetchedTasks = await _todoRepository.getTasks();
      tasks.assignAll(fetchedTasks);
      tasksStatus.value = Status.completed;
    } on NetworkException {
      Get.snackbar('Network Error', 'Network error while fetching tasks');
    } on AppwriteException catch (error) {
      Get.snackbar('Server Error', error.response["message"]);
    } catch (error) {
      tasksStatus.value = Status.error;
      if (kDebugMode) {
        print('Error fetching tasks: $error');
      }
      Get.snackbar('Error', 'Error fetching tasks');
      rethrow;
    }
  }
}
