

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/app/data/response/api_response_status.dart';
import 'package:todo_app/app_exports.dart';


class TodoScreen extends GetView<TodoController> {
  
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Todo List',style: TextStyle(color: kBackgroundColor,fontWeight: FontWeight.w700,fontSize: 24.sp),),
        ),
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.only(top: 20.h),
            child: Obx(
              () {
                if (controller.tasksStatus.value == Status.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.tasksStatus.value == Status.error) {
                  return const Center(
                    child: Text('Error fetching tasks',style:TextStyle(color: Colors.white),),
                  );
                } else if (controller.tasks.isEmpty) {
                  return const Center(
                    child: Text('No tasks to show',style:TextStyle(color: Colors.white),),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.tasks.length,
                    itemBuilder: (context, index) {
                      Todo todo = controller.tasks[index];
                      return TodoCard(todo: todo);
                    },
                  );
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: kBackgroundColor,
          onPressed: () {
            // Show dialog to add new task
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add New Task'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Title'),
                          controller: titleController,
                        ),
                        SizedBox(height: 20.h),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Description'),
                          controller: descriptionController,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final userId = GetStorage().read("userId") ?? '';
                        final id = controller.generateUniqueId(userId);
                        
                        controller.createTask(
                          Todo(
                            isCompleted: false,
                            userId: userId,
                            id: id,
                            title: titleController.text,
                            description: descriptionController.text,
                            createdAt: DateTime.now(),
                          ),
                        );
                        titleController.clear();
                        descriptionController.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

}

