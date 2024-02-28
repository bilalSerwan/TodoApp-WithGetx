
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/core/utils/extensions.dart';
import 'package:getx_example_app/app/core/values.dart/colors.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key});
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Get.back();
                        homeCtrl.textcontroller.clear();
                        homeCtrl.changingTask(null);
                      },
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if (homeCtrl.formkey.currentState!.validate()) {
                          if (homeCtrl.task.value == null) {
                            EasyLoading.showError('Please select category');
                          } else {
                            var secess = homeCtrl.updateTask(homeCtrl.task.value!,
                                homeCtrl.textcontroller.text);
                            if (secess) {
                              EasyLoading.showSuccess('Added Sacessfuly');
                              Get.back();
                              homeCtrl.changingTask(null);
                            } else {
                              EasyLoading.showError('Something went wrong');
                            }
                          }
                          homeCtrl.textcontroller.clear();
                        }
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(color: blue),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  'New Task',
                  style:
                      TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeCtrl.textcontroller,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter The To Do Item';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  'Add To',
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
              ...homeCtrl.tasks.map(
                (element) => Obx(
                  () => InkWell(
                    onTap: () {
                      homeCtrl.changingTask(element);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.0.wp, vertical: 3.0.wp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                IconData(element.icon,
                                    fontFamily: 'MaterialIcons'),
                                color: HexColor.fromHex(element.color),
                              ),
                              SizedBox(
                                width: 3.0.wp,
                              ),
                              Text(
                                element.title,
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (homeCtrl.task.value == element)
                            const Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
