import 'dart:io';
import 'package:flutter/material.dart';
import 'package:load_collector/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:pdf_merger/pdf_merger.dart';

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
    final date = DateTime.now();
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
                'Date : $date',
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
                            fontSize: 16,
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

    //===========> Get the downloads directory path based on the platform
    Directory generalDownloadDir;
    if (Platform.isAndroid) {
      generalDownloadDir = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      generalDownloadDir = await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
    final fileName = '$siteId.pdf';
    final filePath = '${generalDownloadDir.path}/$fileName';

  
    //---------> Define the paths for the existing file and the new file
    final existingFilePath = filePath;
    final newFilePath = '${generalDownloadDir.path}/$siteId-new.pdf';
    
    //---------> Save the PDF as a new file
    final newFile = File(newFilePath);
    await newFile.writeAsBytes(await pdf.save());
    //---------> Merge the existing file and the new file
    final mergedFilePath = '${generalDownloadDir.path}/$siteId.pdf';
    final pathsToMerge = [existingFilePath, newFilePath];
    MergeMultiplePDFResponse response = await PdfMerger.mergeMultiplePDF(
        paths: pathsToMerge, outputDirPath: mergedFilePath);
    if (response.status == "success") {
      // Delete the previous file
      final existingFile = File(existingFilePath);
      await existingFile.delete();
      // Delete the new file
      await newFile.delete();
      // Rename the merged file to the previous file name
      final mergedFile = File(mergedFilePath);
      await mergedFile.rename(filePath);
      // Show a success message
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Files merged and Updated');
      return mergedFile;
    } else {
      // Show an error message
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Failed to merge files');
      // Return the new file
      return newFile;
    }
  }
}
