import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/core/utils/extensions.dart';
import 'package:getx_example_app/app/core/values.dart/colors.dart';
import 'package:getx_example_app/app/data/models/task.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';
import 'package:getx_example_app/app/modules/home/widgtes/addDialog.dart';
import 'package:getx_example_app/app/modules/home/widgtes/addcard.dart';
import 'package:getx_example_app/app/modules/home/widgtes/task_card.dart';
import 'package:getx_example_app/app/modules/report/view.dart';

class HomeVeiw extends GetView<HomeController> {
  const HomeVeiw({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.indexOfPage.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.0.wp, vertical: 4.0.hp),
                    child: Text(
                      'My List',
                      style: TextStyle(
                          fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks.map(
                          (task) => LongPressDraggable(
                            data: task,
                            feedback: Opacity(
                              opacity: 0.7,
                              child: TaskCard(
                                task: Task(
                                  title: task.title,
                                  icon: task.icon,
                                  color: task.color,
                                  todos: task.todos,
                                ),
                              ),
                            ),
                            onDragStarted: () {
                              controller.changedeleting(true);
                            },
                            onDraggableCanceled: (velocity, offset) {
                              controller.changedeleting(false);
                            },
                            onDragEnd: (details) {
                              controller.changedeleting(false);
                            },
                            child: TaskCard(
                              task: Task(
                                  title: task.title,
                                  icon: task.icon,
                                  color: task.color,
                                  todos: task.todos),
                            ),
                          ),
                        ),
                        AddCard(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ReportPage(),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (context, _, __) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo('Please Add task type');
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deletingTask(task);
          EasyLoading.showSuccess('Delete secess');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.indexOfPage.value,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (value) {
                controller.changingIndexOfPage(value);
              },
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 10.0.wp),
                    child: const Icon(Icons.apps),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding: EdgeInsets.only(left: 10.0.wp),
                    child: const Icon(Icons.data_usage),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
