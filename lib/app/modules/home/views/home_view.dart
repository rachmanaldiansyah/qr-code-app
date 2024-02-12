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
        title: const Text('HOME'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: 4,
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              title = "Tambah Produk";
              icon = Icons.post_add_rounded;
              onTap = () => Get.toNamed(Routes.ADD_PRODUCT);
              break;
            case 1:
              title = "Daftar Produk";
              icon = Icons.list_alt_rounded;
              onTap = () => Get.toNamed(Routes.PRODUCTS);
              break;
            case 2:
              title = "Kode QR";
              icon = Icons.qr_code_2_rounded;
              onTap = () => print("Ini adalah aksi untuk buka kamera");
              break;
            case 3:
              title = "Katalog Produk";
              icon = Icons.document_scanner_rounded;
              onTap = () => controller.downloadCatalog();
              break;
          }

          return Material(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      icon,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("$title")
                ],
              ),
            ),
          );
        },
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
