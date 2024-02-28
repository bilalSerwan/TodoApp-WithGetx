import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_example_app/app/Widgets/icons.dart';
import 'package:getx_example_app/app/core/utils/extensions.dart';
import 'package:getx_example_app/app/data/models/task.dart';
import 'package:getx_example_app/app/modules/home/home_controller.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});

  final icons = getIcons();

  @override
  Widget build(BuildContext context) {
    final squareWidth = Get.width - 12.0.wp;
    final squareHeight = Get.height - 12.0.hp;
    final homeCtrl = Get.find<HomeController>();
    return Container(
      width: squareWidth / 2,
      height: squareHeight / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            title: "Add Task",
            radius: 10,
            content: Form(
              key: homeCtrl.formkey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.textcontroller,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please Enter The Title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: getIcons()
                          .map(
                            (e) => Obx(
                              () {
                                final index = icons.indexOf(e);
                                return ChoiceChip(
                                  selectedColor:
                                      const Color.fromARGB(255, 158, 218, 245),
                                  pressElevation: 0,
                                  backgroundColor: Colors.white,
                                  label: e,
                                  selected: homeCtrl.index.value == index,
                                  onSelected: (bool selected) {
                                    homeCtrl.index.value = selected ? index : 0;
                                  },
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      if (homeCtrl.formkey.currentState!.validate()) {
                        int icon = icons[homeCtrl.index.value].icon!.codePoint;
                        String color =
                            icons[homeCtrl.index.value].color!.toHex();
                        var task = Task(
                            title: homeCtrl.textcontroller.text,
                            icon: icon,
                            color: color);
                        Get.back();
                        homeCtrl.addTask(task)
                            ? EasyLoading.showSuccess('Task Added')
                            : EasyLoading.showError('ERROR');
                      }
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          );
          homeCtrl.textcontroller.clear();
          homeCtrl.index.value = 0;
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
