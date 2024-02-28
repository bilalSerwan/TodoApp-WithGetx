import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_example_app/app/data/services/storage/services.dart';
import 'package:getx_example_app/app/modules/home/home_binding.dart';
import 'package:getx_example_app/app/modules/home/home_view.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageServices().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      home: const HomeVeiw(),
      builder: EasyLoading.init(),
    );
  }
}
