import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class PDFGenerator {
  static Future<File> generatePDF(
    String documentTitle,
    List<String> sectionSubtitles,
    List<Uint8List> images,
    List<String> readings,
    String siteId,
    BuildContext context,
  ) async {
    final pdf = pw.Document();
    // Load the Helvetica font from assets
    final fontData = await rootBundle.load('assets/Helvetica.ttf');
    final ttf = pw.Font.ttf(fontData);
    final Dat = DateTime.now();
    // Add document title
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
              pw.Text(
                'Site ID : $siteId',
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Date : $Dat',
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              pw.Text(
                documentTitle,
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < sectionSubtitles.length; i++) ...[
                    pw.Column(
                      children: [
                        pw.Container(
                          alignment: pw.Alignment.center,
                          width: 150,
                          height: 150,
                          child: pw.Image(
                            pw.MemoryImage(images[i]),
                            fit: pw.BoxFit.contain,
                          ),
                        ),
                        pw.Text(
                          sectionSubtitles[i],
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 5)),
                        pw.Text(
                          'Reading ${i + 1}: ${readings[i]}',
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );

    // Get the document directory path
    final directory = await getApplicationDocumentsDirectory();
    final fileName = '$siteId.pdf';
    final filePath = '${directory.path}/$fileName';

    // Save the PDF as a file
    final output = File(filePath);
    await output.writeAsBytes(await pdf.save());
    return output;
  }
}
