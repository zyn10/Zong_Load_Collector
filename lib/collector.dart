import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:load_collector/home.dart';
import 'package:load_collector/utils/utils.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Uint8List? _image1;
  Uint8List? _image2;
  Uint8List? _image3;

  final TextEditingController _readingController_1 = TextEditingController();
  final TextEditingController _readingController_2 = TextEditingController();
  final TextEditingController _readingController_3 = TextEditingController();

  @override
  void dispose() {
    _readingController_1.dispose();
    _readingController_2.dispose();
    _readingController_3.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im1 = await pickImage(ImageSource.gallery);
    Uint8List im2 = await pickImage(ImageSource.gallery);
    Uint8List im3 = await pickImage(ImageSource.gallery);
    setState(() {
      _image1 = im1;
      _image2 = im2;
      _image3 = im3;
    });
  }

  Future<void> push() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // String output = await FireStoreMethods().uploadShow(
      //   reading_1: _readerController_1.text,
      //   reading_2: _readerController_2.text,
      //   reading_3: _readerController_3.text,

      //   image1: _image1,
      //   image2: _image2,
      //   image3: _image3,

      // );
      String output = "success";
      setState(() {
        _isLoading = false;
      });
      if (output != 'success') {
        // ignore: use_build_context_synchronously
        showSnackBar(context, output);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
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
                    child: _image1 != null
                        ? Image.memory(
                            _image1!,
                            fit: BoxFit.cover,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 30,
                                color: Colors.grey,
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Tap to add 1st Pciture',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _readingController_1,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.pin),
                      hintText: "Insert Reading 1",
                      errorStyle: TextStyle(
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
                  const SizedBox(
                    height: 20.0,
                  ),
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
                    child: _image2 != null
                        ? Image.memory(
                            _image2!,
                            fit: BoxFit.cover,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 30,
                                color: Colors.grey,
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Tap to add 2nd Pciture',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _readingController_2,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.pin),
                      hintText: "Insert Reading 2",
                      errorStyle: TextStyle(
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
                  const SizedBox(
                    height: 20.0,
                  ),
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
                    child: _image3 != null
                        ? Image.memory(
                            _image3!,
                            fit: BoxFit.cover,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 30,
                                color: Colors.grey,
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Tap to add 3rd Pciture',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _readingController_3,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.pin),
                      hintText: "Insert Reading 3",
                      errorStyle: TextStyle(
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
                  const SizedBox(
                    height: 20.0,
                  ),
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
