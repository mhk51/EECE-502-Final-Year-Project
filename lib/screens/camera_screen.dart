//import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  var _image = File('file.txt');
  ImagePicker picker = ImagePicker();
  Future getImage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }
    //   Image.file(File(image!.path));
    setState(() {
//      _image = File(image!.path);
      Image.file(File(image!.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Pick Demo'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.insert_drive_file),
                onPressed: () {
                  getImage(false);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  getImage(true);
                },
              ),
              _image == null
                  ? Container()
                  : Image.file(
                      _image,
                      height: 300.0,
                      width: 300.0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
