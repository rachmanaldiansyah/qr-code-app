import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/data/models/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);

  final ProductsModel products = Get.arguments;
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeController.text = products.code;
    nameController.text = products.nameProduct;
    qtyController.text = products.qty.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL PRODUK'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImage(
                  data: products.code,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: codeController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Kode Produk",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Nama Produk",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: qtyController,
            keyboardType: TextInputType.number,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: "Qty",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (nameController.text.isNotEmpty &&
                    qtyController.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> result =
                      await controller.updateProducts({
                    "id": products.productId,
                    "product_name": nameController.text,
                    "qty": int.tryParse(qtyController.text) ?? 0,
                  });
                  controller.isLoading(false);

                  Get.back(); // kembali ke page products
                  Get.snackbar(
                    result["error"] == true ? "Error" : "Success",
                    result["message"],
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    "Semua data wajib diisi",
                    duration: Duration(seconds: 3),
                  );
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
              () => Text(
                controller.isLoading.isFalse ? "UBAH PRODUK" : "LOADING...",
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Hapus Produk",
                middleText: "Apakah Anda yakin ingin menghapus produk ini?",
                actions: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: Text("Kembali"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.isLoadingDelete(true);
                      Map<String, dynamic> result =
                          await controller.deleteProducts(products.productId);
                      controller.isLoadingDelete(false);

                      Get.back(); // tutup dialog
                      Get.back(); // kembali ke page products
                      Get.snackbar(
                        result["error"] == true ? "Error" : "Success",
                        result["message"],
                      );
                    },
                    child: Obx(
                      () => controller.isLoadingDelete.isFalse
                          ? Text("HAPUS")
                          : Container(
                              padding: EdgeInsets.all(2),
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
            child: Text(
              "Hapus Produk",
              style: TextStyle(
                color: Colors.red.shade900,
              ),
            ),
          )
        ],
      ),
    );
  }
}
