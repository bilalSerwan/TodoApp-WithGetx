import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/core/utils/extensions.dart';
import 'package:getx_example_app/app/data/models/task.dart';
import 'package:getx_example_app/app/modules/detail/veiw_detail_screen.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  TaskCard({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailPage());
        homeCtrl.changingTask(task);
        homeCtrl.saparateDoingAndDoneTodo(task.todos ?? []);
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeCtrl.isTodoEmpty(task) ? 1 : task.todos!.length,
              currentStep: homeCtrl.getdonetodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                colors: [color.withOpacity(0.5), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              unselectedGradientColor: const LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(6.0.wp),
                  child: Icon(
                    IconData(task.icon, fontFamily: 'MaterialIcons'),
                    color: color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6.0.wp, vertical: 2.0.wp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0.sp,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 1.0.hp,
                      ),
                      Text(
                        '${task.todos?.length ?? 0} task',
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
