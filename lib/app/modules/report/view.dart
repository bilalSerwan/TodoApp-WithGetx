import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/core/utils/extensions.dart';
import 'package:getx_example_app/app/core/values.dart/colors.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});
  final HomeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        var totalNumberOfTodo = HomeCtrl.totalNumberOfAllTodos();
        var numberofdonetodo = HomeCtrl.getnumberofdonetodo();
        var numberofdoingtodo = totalNumberOfTodo - numberofdonetodo;
        if (totalNumberOfTodo == 0) {
          totalNumberOfTodo = 1;
        }
        var percentageofdonetodos =
            ((numberofdonetodo / totalNumberOfTodo) * 100).toInt();
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My Report',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
              child: Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyle(fontSize: 15.0.sp, color: Colors.grey),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
              child: const Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 1.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WidgetCard(
                    color: Colors.green,
                    number: numberofdoingtodo,
                    text: 'Live Tasks',
                  ),
                  WidgetCard(
                    color: Colors.orange,
                    number: numberofdonetodo,
                    text: 'Completed',
                  ),
                  WidgetCard(
                    color: Colors.blue,
                    number: totalNumberOfTodo,
                    text: 'Created',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0.wp,
            ),
            UnconstrainedBox(
              child: SizedBox(
                height: 70.0.wp,
                width: 70.0.wp,
                child: CircularStepProgressIndicator(
                  totalSteps: totalNumberOfTodo,
                  currentStep: numberofdonetodo,
                  padding: 0,
                  selectedColor: green,
                  unselectedColor: Colors.grey[200],
                  stepSize: 20,
                  width: 150,
                  height: 150,
                  selectedStepSize: 22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${totalNumberOfTodo == 0 ? 0 : percentageofdonetodos} %',
                        style: TextStyle(
                            fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.0.wp,
                      ),
                      Text(
                        'Effeceincy',
                        style: TextStyle(color: Colors.grey, fontSize: 14.0.sp),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

class WidgetCard extends StatelessWidget {
  const WidgetCard({
    Key? key,
    required this.color,
    required this.number,
    required this.text,
  }) : super(key: key);
  final Color color;
  final int number;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 2.0.wp),
          width: 4.0.wp,
          height: 4.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.0.wp),
          ),
        ),
        SizedBox(
          width: 1.0.wp,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1.0.wp,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }
}
