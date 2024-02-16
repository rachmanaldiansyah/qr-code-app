import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_code/app/data/models/product_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<ProductsModel> allProducts = List<ProductsModel>.empty().obs;

  void downloadCatalog() async {
    final pdf = pw.Document();

    var getAllData = await firestore.collection("products").get();

    // reset all products -> untuk mengatasi duplikat
    allProducts([]);

    // isi data allProducts dari database
    getAllData.docs.forEach((e) {
      allProducts.add(ProductsModel.fromJson(e.data()));
    });

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          List<pw.TableRow> allData =
              List.generate(allProducts.length, (index) {
            ProductsModel products = allProducts[index];
            return pw.TableRow(
              children: [
                // No
                pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text(
                    "${index + 1}",
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                // Kode Barang
                pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text(
                    "${products.code}",
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                // Nama Barang
                pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text(
                    "${products.nameProduct}",
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                // Qty
                pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Text(
                    "${products.qty}",
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                // QR Code
                pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.BarcodeWidget(
                    color: PdfColor.fromHex("#000000"),
                    barcode: pw.Barcode.qrCode(),
                    data: "${products.code}",
                    height: 50,
                    width: 50,
                  ),
                )
              ],
            );
          });

          return [
            pw.Center(
              child: pw.Text(
                "KATALOG PRODUK",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(
                color: PdfColor.fromHex("#000000"),
                width: 2,
              ),
              children: [
                pw.TableRow(
                  children: [
                    // No
                    pw.Padding(
                      padding: pw.EdgeInsets.all(15),
                      child: pw.Text(
                        "No",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    // Kode Barang
                    pw.Padding(
                      padding: pw.EdgeInsets.all(15),
                      child: pw.Text(
                        "Kode Barang",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    // Nama Barang
                    pw.Padding(
                      padding: pw.EdgeInsets.all(15),
                      child: pw.Text(
                        "Nama Barang",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    // Qty
                    pw.Padding(
                      padding: pw.EdgeInsets.all(15),
                      child: pw.Text(
                        "Qty",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    // QR Code
                    pw.Padding(
                      padding: pw.EdgeInsets.all(15),
                      child: pw.Text(
                        "Kode Qr",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                ),
                // ISI DATANYA
                ...allData,
              ],
            ),
          ];
        },
      ),
    );

    // simpan pdf
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/katalog.pdf');

    // memasukkan data bytes -> file kosong
    await file.writeAsBytes(bytes);

    // open pdf
    await OpenFile.open(file.path);
  }

  Future<Map<String, dynamic>> getProductById(String code) async {
    try {
      var result = await firestore
          .collection("products")
          .where("code", isEqualTo: code)
          .get();

      if (result.docs.isEmpty) {
        return {
          "error": true,
          "message": "Tidak mendapatkan produk ini di database",
        };
      }

      Map<String, dynamic> data = result.docs.first.data();

      return {
        "error": false,
        "message": "Berhasil mendapatkan detail produk dari produk code ini",
        "data": ProductsModel.fromJson(data)
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak mendapatkan detail produk dari produk code ini",
      };
    }
  }
}
