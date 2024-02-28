import 'package:getx_example_app/app/data/models/task.dart';
import 'package:getx_example_app/app/data/provider/task/provider.dart';

class TaskRepositery {
  TaskProvider taskProvider;
  TaskRepositery({required this.taskProvider});
  List<Task> readTask() => taskProvider.readTask();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
