import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      var result = await firestore.collection("products").add(data);
      await firestore.collection("products").doc(result.id).update({
        "product_id": result.id,
      });

      return {
        "error": false,
        "message": "Berhasil menambah produk!",
      };
    } catch (e) {
      // error general
      return {
        "error": true,
        "message": "Tidak dapat menambah produk!",
      };
    }
  }
}
