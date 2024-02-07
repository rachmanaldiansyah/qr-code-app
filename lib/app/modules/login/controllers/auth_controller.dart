import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? uid; // untuk cek kondisi ada auth atau tidak -> uid

  late FirebaseAuth auth;

  // fungsi autentikasi login
  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return {
        "error": false,
        "message": "Login berhasil!",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      // error general
      return {
        "error": true,
        "message": "Tidak dapat login",
      };
    }
  }

  // fungsi autentikasi logout
  Future<Map<String, dynamic>> logout() async {
    try {
      await auth.signOut();
      return {
        "error": false,
        "message": "Berhasil logout!",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      // error general
      return {
        "error": true,
        "message": "Gagal logout!",
      };
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });

    super.onInit();
  }
}
