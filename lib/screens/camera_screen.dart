import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late File pickedImage;
  bool isImageLoaded = false;

  late List _result;
  String _confidence = "";
  String _name = "";
  String numbers = "";

  getImagefromGallery() async {
    var tempStore = await (ImagePicker().getImage(source: ImageSource.gallery));
    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModelOnImage(pickedImage);
    });
    // Navigator.of(context).pop();
    // applyModelOnImage(imageFile);
  }

  loadMyModel() async {
    var result = await Tflite.loadModel(
      labels: "assets/labels.txt",
      model: "assets/food11model.tflite",
    );
    // ignore: avoid_print
    print("Result after loading model: $result");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      // numResults: 11,
      // threshold: 0.5,
      // imageMean: 127.5,
      // imageStd: 127.5,
    );
    setState(() {
      _result = res!;
      _name = _result[0]["label"].toString().substring(2);
      _confidence =
          (_result[0]["confidence"] * 100.0).toString().substring(0, 5) + "%";
    });
    // ignore: avoid_print
    print(res);
  }

  @override
  void initState() {
    super.initState();
    loadMyModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tflite Model'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            isImageLoaded
                ? Center(
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(pickedImage.path)),
                              fit: BoxFit.fill)),
                    ),
                  )
                : Container(),
            Text('Name: $_name \nConfedence: $_confidence'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImagefromGallery();
        },
        child: const Icon(
          Icons.photo_album,
        ),
      ),
    );
  }
}
