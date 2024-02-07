import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);

  final TextEditingController codeProductController = TextEditingController();
  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController qtyProductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TAMBAH PRODUK'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: codeProductController,
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Kode Produk",
              hintText: "Masukkan kode produk...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: nameProductController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Nama Produk",
              hintText: "Masukkan nama produk...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            controller: qtyProductController,
            maxLength: 2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Qty Produk",
              hintText: "Masukkan kuantitas produk...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () => Text(
                controller.isLoading.isFalse ? "TAMBAH PRODUK" : "LOADING...",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
