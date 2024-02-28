import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/core/utils/extensions.dart';
import 'package:getx_example_app/app/modules/detail/widget/doingtask.dart';
import 'package:getx_example_app/app/modules/detail/widget/donetask.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    final color = HexColor.fromHex(task.color);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => true,
        child: Form(
          key: homeCtrl.formkey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        homeCtrl.updateTodos();
                        homeCtrl.textcontroller.clear();
                        homeCtrl.changingTask(null);
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color,
                    ),
                    SizedBox(
                      width: 5.0.wp,
                    ),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  int todoslength =
                      homeCtrl.donetodo.length + homeCtrl.doingtodo.length;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.wp, vertical: 3.0.wp),
                    child: Row(
                      children: [
                        Text(
                          '$todoslength Task',
                          style:
                              TextStyle(fontSize: 10.0.sp, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 5.0.wp,
                        ),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: todoslength == 0 ? 1 : todoslength,
                            currentStep: homeCtrl.donetodo.length,
                            size: 5,
                            padding: 0,
                            selectedGradientColor: LinearGradient(
                              colors: [color.withOpacity(0.5), color],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            unselectedGradientColor: LinearGradient(
                              colors: [Colors.grey[300]!, Colors.grey[300]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
                child: TextFormField(
                  controller: homeCtrl.textcontroller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Todo',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.grey[400]!,
                      ),
                    ),
                    prefixIcon: Checkbox(
                      value: true,
                      onChanged: (v) {},
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeCtrl.formkey.currentState!.validate()) {
                          var seccess =
                              homeCtrl.addTodo(homeCtrl.textcontroller.text);
                          if (seccess) {
                            EasyLoading.showSuccess('Added the To do');
                          } else {
                            EasyLoading.showError('Error adding the To do');
                          }
                          homeCtrl.textcontroller.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'please write something';
                    }
                    return null;
                  },
                ),
              ),
              DoingTodo(),
              DoneTodos(),
            ],
          ),
        ),
      ),
    );
  }
}
