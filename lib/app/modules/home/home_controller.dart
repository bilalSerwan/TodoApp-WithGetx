import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/data/models/task.dart';
import 'package:getx_example_app/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepositery taskRepositery;
  HomeController({required this.taskRepositery});
  final formkey = GlobalKey<FormState>();
  final textcontroller = TextEditingController();
  final index = 0.obs;
  final tasks = <Task>[].obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingtodo = <dynamic>[].obs;
  final donetodo = <dynamic>[].obs;
  final indexOfPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepositery.readTask());
    ever(tasks, (_) => taskRepositery.writeTasks(tasks));
  }
  @override
  void onClose() {
    super.onClose();
    textcontroller.dispose();
  }

  void changingIndexOfPage(int index) {
    indexOfPage.value = index;
  }

  void saparateDoingAndDoneTodo(List<dynamic> select) {
    donetodo.clear();
    doingtodo.clear();
    for (int i = 0; i < select.length; i++) {
      if (select[i]['isDone'] == 'true') {
        donetodo.add(select[i]);
      } else {
        doingtodo.add(select[i]);
      }
    }
  }

  void changingTask(Task? task) {
    this.task.value = task;
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'isDone': 'false'};
    var doneetodo = {'title': title, 'isDone': 'true'};
    if (doingtodo.any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    } else if (donetodo
        .any((element) => mapEquals<String, dynamic>(doneetodo, element))) {
      return false;
    } else {
      doingtodo.add(todo);
      return true;
    }
  }

  void updateTodos() {
    var NewTodos = <Map<String, dynamic>>[];
    NewTodos.addAll([...doingtodo, ...donetodo]);
    var newTask = task.value!.copyWith(todos: NewTodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    } else {
      var todo = {'title': title, 'isDone': 'false'};
      todos.add(todo);
      var newTask = task.copyWith(todos: todos);
      int oldindex = tasks.indexOf(task);
      tasks[oldindex] = newTask;
      return true;
    }
  }
   bool containeTodo(List todos, String title) {
    if (todos.any((element) => element['title'] == title)) {
      return true;
    } else {
      return false;
    }
  }


  void changedeleting(bool value) {
    deleting.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deletingTask(Task task) {
    tasks.remove(task);
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'isDone': 'false'};
    var index = doingtodo.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    var doneTodo = {'title': title, 'isDone': 'true'};
    doingtodo.removeAt(index);
    donetodo.add(doneTodo);
    doingtodo.refresh();
    donetodo.refresh();
  }

 

  void deletingDoneTodo(dynamic todo) {
    var index = donetodo.indexWhere((element) => mapEquals(todo, element));
    donetodo.removeAt(index);
    donetodo.refresh();
  }

  bool isTodoEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  
//report page
  int getdonetodo(Task task) {
    int numberofdonetodo = 0;
    if (task.todos != null) {
      for (int i = 0; i < task.todos!.length; i++) {
        if (task.todos![i]['isDone'] == 'true') {
          numberofdonetodo++;
        }
      }
    }
    return numberofdonetodo;
  }

  int totalNumberOfAllTodos() {
    int totalnum = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (int j = 0; j < tasks[i].todos!.length; j++) {
          totalnum++;
        }
      }
    }
    return totalnum;
  }

  int getnumberofdonetodo() {
    int res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (int j = 0; j < tasks[i].todos!.length; j++) {
          if (tasks[i].todos![j]['isDone'] == 'true') {
            res++;
          }
        }
      }
    }
    return res;
  }
}
