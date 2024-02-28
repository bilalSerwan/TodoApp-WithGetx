import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/core/utils/extensions.dart';
import 'package:getx_example_app/app/core/values.dart/colors.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';

class DoneTodos extends StatelessWidget {
  DoneTodos({super.key});
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.donetodo.isNotEmpty
          ? Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 5.0.wp),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.0.wp, vertical: 2.0.wp),
                    child: Text(
                      'Completed ${homeCtrl.donetodo.length}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0.sp,
                      ),
                    ),
                  ),
                  ...homeCtrl.donetodo.map((element) => Dismissible(
                        key: ObjectKey(element),
                        onDismissed: (direction) {
                          homeCtrl.deletingDoneTodo(element);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 6.0.wp),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 9.0.wp, vertical: 3.0.wp),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.done,
                                  color: blue,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.0.wp, vertical: 1.0.wp),
                                child: Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14.0.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            )
          : Container(),
    );
  }
}
