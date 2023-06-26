import 'dart:io';
import 'package:flutter/material.dart';
import 'package:load_collector/utils/utils.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class PDFGenerator {
  static Future<File> generatePDF(
    String documentTitle,
    List<String> sectionSubtitles,
    List<Uint8List> images,
    List<String> readings,
    BuildContext context,
  ) async {
    final pdf = pw.Document();

    // Load the Helvetica font from assets
    final fontData = await rootBundle.load('assets/Helvetica.ttf');
    final ttf = pw.Font.ttf(fontData);

    // Add document title
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Text(
          documentTitle,
          style: pw.TextStyle(font: ttf, fontSize: 18),
        ),
      );
    }));

    // Add sections with images and readings
    for (var i = 0; i < sectionSubtitles.length; i++) {
      final sectionSubtitle = sectionSubtitles[i];
      final image = images[i];
      final reading = readings[i];

      if (image != null) {
        final imageWidget = pw.MemoryImage(image);
        pdf.addPage(pw.Page(build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Header(
                level: 1,
                child: pw.Text('Section ${i + 1} - $sectionSubtitle'),
              ),
              pw.Center(
                child: pw.Image(imageWidget),
              ),
              pw.Padding(padding: pw.EdgeInsets.all(10)),
              pw.Center(
                child: pw.Text(
                  'Reading ${i + 1}: $reading',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
              ),
            ],
          );
        }));
      }
    }

    // Get the document directory path
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = '$timestamp.pdf';
    final filePath = '${directory.path}/$fileName';

    // Save the PDF as a file
    final output = File(filePath);
    await output.writeAsBytes(await pdf.save());
    showSnackBar(context, 'PDF saved at: $filePath');
    return output;
  }
}
