import 'package:get/get.dart';
import 'package:getx_example_app/app/data/provider/task/provider.dart';
import 'package:getx_example_app/app/data/services/storage/repository.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepositery: TaskRepositery(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
