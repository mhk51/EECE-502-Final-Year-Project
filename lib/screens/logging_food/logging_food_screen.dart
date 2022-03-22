import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/app_icons_icons.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/food_search_list.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class recipeIngredients {
  List<FoodClass> ingredients = [];
  recipeIngredients(this.ingredients);
}

class LoggingFoodScreen extends StatefulWidget {
  const LoggingFoodScreen({Key? key}) : super(key: key);

  @override
  State<LoggingFoodScreen> createState() => _LoggingFoodScreenState();
}

class _LoggingFoodScreenState extends State<LoggingFoodScreen> {
  //dialog for camera and image picker
  late XFile imageFile;

  //HenriVincent
  bool isImageLoaded = false;

  List _result = [];
  String _name = "";
  String _confidence = "";
  String numbers = "";

  _openGallery(BuildContext context) async {
    imageFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery)) as XFile;
    Navigator.of(context).pop();
    applyModelOnImage(imageFile);
  }

  _openCamera(BuildContext context) async {
    imageFile =
        (await ImagePicker().pickImage(source: ImageSource.camera)) as XFile;
    Navigator.of(context).pop();
    applyModelOnImage(imageFile);
  }

  loadMyModel() async {
    var result = await Tflite.loadModel(
      labels: "assets/labels.txt",
      model: "assets/food11model.tflite",
    );
    print("Result: $result");
  }

  applyModelOnImage(XFile file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 11,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _result = res!;
      String str = _result[0]["label"];
      _name = str.substring(11);
      _confidence = _result != null
          ? (_result[0]["confidence"] * 100.0).toString().substring(0, 11) + "%"
          : "";
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyModel();
  }

  _getResult() {}

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            )),
          );
        });
  }

  var msgController = TextEditingController();
  String tempSearchWord = "";
  String searchWord = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Logging Food"),
          ),
          // centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("All Results")),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Favorites"),
                ),
                // Expanded(child: Search()),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                List<FoodClass> ingredients = [];
                recipeIngredients recipe = recipeIngredients(ingredients);

                await Navigator.pushNamed(context, '/InputNewRecipe',
                    arguments: recipe);
              },
              child: const Text("Input New Recipe"),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: msgController,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Search Food',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.5,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          msgController.clear();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a Search Word' : null,
                    onChanged: (val) {
                      tempSearchWord = val;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      searchWord = tempSearchWord;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  icon: const Icon(
                    Icons.center_focus_strong,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  icon: const Icon(
                    AppIcons.barcode_2,
                    color: Colors.blue,
                    size: 27,
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FoodSearchWidget(
              searchWord: searchWord,
              fromenterrecipe: false,
              ingredients: [],
            ),
          ],
        ),
      ),
    );
  }
}
