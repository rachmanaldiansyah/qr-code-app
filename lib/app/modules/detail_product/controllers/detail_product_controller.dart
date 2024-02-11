import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> updateProducts(Map<String, dynamic> data) async {
    try {
      await firestore.collection("products").doc(data["id"]).update({
        "product_name": data["product_name"],
        "qty": data["qty"],
      });

      return {
        "error": false,
        "message": "Berhasil mengupdate produk",
      };
    } catch (e) {
      // General error
      return {
        "error": true,
        "message": "Tidak dapat meng-update produk",
      };
    }
  }

  Future<Map<String, dynamic>> deleteProducts(String id) async {
    try {
      await firestore.collection("products").doc(id).delete();
      return {
        "error": false,
        "message": "Berhasil menghapus produk",
      };
    } catch (e) {
      // General error
      return {
        "error": true,
        "message": "Tidak dapat menghapus produk",
      };
    }
  }
}
