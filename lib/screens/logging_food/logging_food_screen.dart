import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/custom/app_icons_icons.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/food_search_list.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/services/barcode_service.dart';
import 'package:flutter_application_1/services/search_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

class RecipeIngredients {
  List<FoodClass> ingredients = [];
  RecipeIngredients(this.ingredients);
}

class LoggingFoodScreen extends StatefulWidget {
  const LoggingFoodScreen({Key? key}) : super(key: key);

  @override
  State<LoggingFoodScreen> createState() => _LoggingFoodScreenState();
}

class _LoggingFoodScreenState extends State<LoggingFoodScreen> {
  // //dialog for camera and image picker
  // late File imageFile;

  // //HenriVincent
  // bool isImageLoaded = false;

  // List _result = [];
  // String _name = "";
  // String _confidence = "";
  // String numbers = "";

  // _openGallery(BuildContext context) async {
  //   imageFile =
  //       await (ImagePicker().pickImage(source: ImageSource.gallery)) as File;
  //   Navigator.of(context).pop();
  //   applyModelOnImage(imageFile);
  // }

  // _openCamera(BuildContext context) async {
  //   imageFile =
  //       (await ImagePicker().pickImage(source: ImageSource.camera)) as File;
  //   Navigator.of(context).pop();
  //   applyModelOnImage(imageFile);
  // }

  // loadMyModel() async {
  //   var result = await Tflite.loadModel(
  //     labels: "assets/labels.txt",
  //     model: "assets/food11model.tflite",
  //   );
  //   print("Result: $result");
  // }

  // applyModelOnImage(File file) async {
  //   var res = await Tflite.runModelOnImage(
  //       path: file.path,
  //       numResults: 11,
  //       threshold: 0.5,
  //       imageMean: 127.5,
  //       imageStd: 127.5);
  // setState(() {
  //   _result = res!;
  //   String str = _result[0]["label"];
  //   _name = str.substring(11);
  //   _confidence = _result != null
  //       ? (_result[0]["confidence"] * 100.0).toString().substring(0, 11) + "%"
  //       : "";
  // });
  //   print(res);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   loadMyModel();
  // }

  // Future<void> _showChoiceDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: SingleChildScrollView(
  //               child: ListBody(
  //             children: <Widget>[
  //               GestureDetector(
  //                 child: const Text("Gallery"),
  //                 onTap: () {
  //                   _openGallery(context);
  //                 },
  //               ),
  //               const Padding(
  //                 padding: EdgeInsets.all(8.0),
  //               ),
  //               GestureDetector(
  //                 child: const Text("Camera"),
  //                 onTap: () {
  //                   _openCamera(context);
  //                 },
  //               )
  //             ],
  //           )),
  //         );
  //       });
  // }
  Bloc bloc = Bloc();
  var msgController = TextEditingController();
  String tempSearchWord = "";
  String searchWord = "";
  int _scanBarcode = 0;
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      try {
        _scanBarcode = int.parse(barcodeScanRes);
      }
      // ignore: empty_catches
      catch (e) {}
    });
  }

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
                RecipeIngredients recipe = RecipeIngredients(ingredients);

                await Navigator.pushNamed(context, '/InputNewRecipe',
                    arguments: recipe);
              },
              child: const Text("Input New Recipe"),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        searchWord = tempSearchWord;
                      });
                      bloc.fetchNewSearch(searchWord);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // _showChoiceDialog(context);
                      await Navigator.pushNamed(context, '/CameraScreen');
                    },
                    icon: const Icon(
                      Icons.center_focus_strong,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // _showChoiceDialog(context);
                      await scanBarcodeNormal();
                      // QuerySnapshot<Object?> result =
                      //     await BarcodeService().barcodeResult(_scanBarcode);
                      // print(result.docs.first.get('title'));
                      FoodClass result =
                          await BarcodeService().barcodeResult(_scanBarcode);
                      await Navigator.pushNamed(context, '/ItemInfo',
                          arguments: result);
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
            ),
            const Divider(
              color: Colors.black,
              thickness: 1.5,
              height: 10,
            ),
            FoodSearchWidget(
              searchWord: searchWord,
              fromenterrecipe: false,
              ingredients: const [],
              bloc: bloc,
            ),
          ],
        ),
      ),
    );
  }
}
