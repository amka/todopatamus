import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todopatamus/app/data/core/services/storage/service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todopatamus",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade300),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue.shade300,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    ),
  );
}

Future initServices() async {
  await GetStorage.init();

  await Get.putAsync(() => StorageService().init());
}
