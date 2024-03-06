import 'package:todo_app/app/data/provider/appwrite_provider.dart';
import 'package:todo_app/presentation/todo_screen/model/todo_model.dart';
import 'package:appwrite/models.dart' as models;

class TodoRepository{
  final AppWriteProvider appWriteProvider = AppWriteProvider();
    Future<models.Document> createTask(Todo todo) async {
    return  appWriteProvider.createTask(todo);
 
}


  Future<void> updateTask(Todo todo) async {
return appWriteProvider.updateTask(todo);
  }

  Future<void> deleteTask(String taskId) async {
    return appWriteProvider.deleteTask(taskId);
   
  }

  Future<List<Todo>> getTasks() async {
return appWriteProvider.getTasks();
  }
}