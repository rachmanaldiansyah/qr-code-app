import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/modules/login/controllers/auth_controller.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> result = await authController.logout();

          if (result["error"] == false) {
            Get.offAllNamed(Routes.LOGIN);
          } else {
            Get.snackbar("Error", result["error"]);
          }
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
