import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  void downloadCatalog() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
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
                            fontSize: 12,
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
                            fontSize: 12,
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
                            fontSize: 12,
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
                            fontSize: 12,
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
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),

                  // ISI DATA PRODUK
                  ...List.generate(5, (index) {
                    return pw.TableRow(
                      children: [
                        // No
                        pw.Padding(
                          padding: pw.EdgeInsets.all(15),
                          child: pw.Text(
                            "${index + 1}",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        // Kode Barang
                        pw.Padding(
                          padding: pw.EdgeInsets.all(15),
                          child: pw.Text(
                            "Kode Barang",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        // Nama Barang
                        pw.Padding(
                          padding: pw.EdgeInsets.all(15),
                          child: pw.Text(
                            "Nama Barang",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        // Qty
                        pw.Padding(
                          padding: pw.EdgeInsets.all(15),
                          child: pw.Text(
                            "Qty",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        // QR Code
                        pw.Padding(
                          padding: pw.EdgeInsets.all(15),
                          child: pw.Text(
                            "Kode Qr",
                            style: pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    );
                  })
                ],
              ),
            ],
          );
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
}
