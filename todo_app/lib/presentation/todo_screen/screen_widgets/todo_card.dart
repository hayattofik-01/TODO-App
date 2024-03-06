import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/presentation/todo_screen/controller/todo_controller.dart';
import 'package:todo_app/presentation/todo_screen/model/todo_model.dart';

class TodoCard extends GetView<TodoController>{
  final Todo todo;
  

  const TodoCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20),
),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                todo.title,
                style: TextStyle(color: kBackgroundColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Show description popup
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Description'),
                            content: Text(todo.description),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'See Description',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
                        decoration: BoxDecoration(
                          color: todo.isCompleted ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          todo.isCompleted ? 'Done' : 'To Do',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Show dialog to edit task
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Edit Task'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(labelText: 'Title'),
                                      controller: TextEditingController(text: todo.title),
                                      onChanged: (value) {
                                        todo.title = value;
                                      },
                                    ),
                                    SizedBox(height: 20.h),
                                    TextFormField(
                                      decoration: const InputDecoration(labelText: 'Description'),
                                      controller: TextEditingController(text: todo.description),
                                      onChanged: (value) {
                                        todo.description = value;
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back(); // Close the dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back(); // Close the dialog
                                      controller.updateTask(todo);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Show delete confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text('Are you sure you want to delete this task?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back(); // Close the dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back(); // Close the dialog
                                      controller.deleteTask(todo.id);
                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: todo.isCompleted ? const Icon(Icons.close, color: Colors.red) : const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          if (todo.isCompleted) {
                            todo.isCompleted = false;
                          } else {
                            todo.isCompleted = true;
                          }
                        controller.updateTask(todo);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
