import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:load_collector/collector.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> shareFilesViaWhatsApp() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      List<String> filePaths = result.paths.map((path) => path!).toList();
      List<Future<dynamic>> shareFutures = [];

      for (final filePath in filePaths) {
        File file = File(filePath);
        // ignore: deprecated_member_use
        shareFutures.add(Share.shareFiles([file.path]));
      }

      await Future.wait<dynamic>(shareFutures);
    } else {
      // User canceled the picker
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Tasks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: shareFilesViaWhatsApp,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Info(
                              title: 'CP Meter Load',
                            )),
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "CP Meter Load",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Info(
                              title: 'CP Meter Readings',
                            )),
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "CP READINGS ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const CreateAlert()),
                  // );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "MCCB LOAD ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const NGOInfo()),
                  // );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "ACDB LOAD ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PetShowInfo()),
                  // );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Rectifier one load ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PetShowInfo()),
                  // );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Rectifier Two load ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PetShowInfo()),
                  // );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "OMO 1 Load ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PetShowInfo()),
                  // );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "OMO 2 Load",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PetShowInfo()),
                  // );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blueGrey,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Neutral Tighting ",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
