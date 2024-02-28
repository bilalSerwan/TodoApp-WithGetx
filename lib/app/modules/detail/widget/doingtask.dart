import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/core/utils/extensions.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';

class DoingTodo extends StatelessWidget {
  DoingTodo({super.key});
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Obx(
          () => homeCtrl.doingtodo.isNotEmpty || homeCtrl.donetodo.isNotEmpty
              ? Column(
                  children: [
                    ...homeCtrl.doingtodo
                        .map(
                          (element) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.0.wp,
                              vertical: 1.0.wp,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8.0.wp,
                                  height: 8.0.wp,
                                  child: Checkbox(
                                    value: element['isDone'] == 'true'
                                        ? true
                                        : false,
                                    onChanged: (v) {
                                      homeCtrl.doneTodo(element['title']);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0.wp,
                                ),
                                Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    const Divider(
                      color: Colors.black45,
                      height: 10,
                      thickness: 1.3,
                      indent: 15,
                      endIndent: 15,
                    ),
                  ],
                )
              : const Center(
                  child: Text('Add Task'),
                ),
        ),
      ],
    );
  }
}
