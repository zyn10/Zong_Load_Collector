import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:load_collector/home.dart';
import 'package:load_collector/utils/utils.dart';
import 'pdf.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final List<Uint8List?> _images = List.generate(3, (_) => null);
  final List<TextEditingController> _readingControllers = List.generate(
    3,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _readingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void selectImage(int index) async {
    try {
      Uint8List image = await pickImage(ImageSource.gallery);
      setState(() {
        _images[index] = image;
      });
    } catch (e) {
      showSnackBar(context, 'Error selecting image: $e');
    }
  }

  Future<void> push() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        List<String> readings =
            _readingControllers.map((controller) => controller.text).toList();

        List<Uint8List> images = _images
            .where((image) => image != null)
            .map((image) => image!)
            .toList();

        String documentTitle =
            'CP METER LOAD'; // Replace with the desired document title
        List<String> sectionSubtitles = [
          'Phase 1',
          'Phase 2',
          'Phase 3'
        ]; // Replace with the desired section subtitles

        // Generate PDF
        File pdfFile = await PDFGenerator.generatePDF(
          documentTitle,
          sectionSubtitles,
          images,
          readings,
          context,
        );

        // Navigate back to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    } catch (e) {
      showSnackBar(context, 'Error performing asynchronous operation: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Add Readings",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _images[i] != null
                          ? Image.memory(
                              _images[i]!,
                              fit: BoxFit.cover,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 30,
                                  color: Colors.grey,
                                  onPressed: () => selectImage(i),
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap to add ${i + 1}st Picture',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _readingControllers[i],
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.pin),
                        hintText: 'Insert Reading ${i + 1}',
                        errorStyle: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Reading is Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                  ],
                  ElevatedButton(
                    onPressed: push,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(350, 50),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('Push'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
