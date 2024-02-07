import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/modules/login/controllers/auth_controller.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          // email textfield
          TextField(
            autocorrect: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Masukkan email Anda",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // password textfield
          Obx(
            () => TextField(
              autocorrect: false,
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: controller.isHidden.value,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Masukkan password Anda",
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isHidden.toggle();
                  },
                  icon: Icon(
                    controller.isHidden.isFalse
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  controller.isLoading(true);
                  // proses login
                  Map<String, dynamic> result = await authController.login(
                      emailController.text, passwordController.text);
                  controller.isLoading(false);

                  if (result["error"] == true) {
                    Get.snackbar("Error", result["message"]);
                  } else {
                    Get.offAllNamed(Routes.HOME);
                  }
                } else {
                  Get.snackbar("Error", "Email dan password wajib diisi.");
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () => Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
