import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/custom/app_icons_icons.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/models/food_class.dart';
import 'package:flutter_application_1/screens/logging_food/food_search_list.dart';
import 'package:flutter_application_1/screens/navdrawer.dart';
import 'package:flutter_application_1/screens/recommendations/recommendations.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/barcode_service.dart';
import 'package:flutter_application_1/services/recipe_database.dart';
import 'package:flutter_application_1/services/search_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../custom/loading.dart';
import '../../services/food_stats_service.dart';
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
  late File pickedImage;

  //HenriVincent
  bool isImageLoaded = false;

  List _result = [];
  String _name = "";
  String _confidence = "";
  String numbers = "";

  Future getImagefromCamera() async {
    // ignore: deprecated_member_use
    var tempStore = await (ImagePicker().getImage(source: ImageSource.camera));
    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModelOnImage(pickedImage);
    });
  }

  Future getImagefromGallery() async {
    // ignore: deprecated_member_use
    var tempStore = await (ImagePicker().getImage(source: ImageSource.gallery));
    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModelOnImage(pickedImage);
    });
  }

  loadMyModel() async {
    var result = await Tflite.loadModel(
      labels: "assets/labels.txt",
      model: "assets/food11model4.tflite",
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

  Future<void> _showResultDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
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
                                    fit: BoxFit.scaleDown)),
                          ),
                        )
                      : Container(),
                  Text('Name: $_name \nConfedence: $_confidence'),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showChoiceDialog(BuildContext context) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () async {
                    await getImagefromGallery();
                    Navigator.pop(context);
                    await _showResultDialog(context);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () async {
                    await getImagefromCamera();
                    Navigator.pop(context);
                    await _showResultDialog(context);
                  },
                )
              ],
            )),
          );
        });
  }

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
    } catch (e) {
      barcodeScanRes = "";
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

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          String recipeName = "";
          final TextEditingController _textEditingController =
              TextEditingController();
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (value) {
                    recipeName = value;
                  },
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Invalid Field";
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter Recipe Name"),
                  controller: _textEditingController,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    final uid = AuthService().getUID();
                    bool exists = await RecipeDatabaseService(
                            recipeName: recipeName, uid: uid)
                        .checkIfRecipeExists();
                    if (!exists) {
                      await Navigator.pushNamed(context, '/InputNewRecipe',
                          arguments: {
                            'recipeName': recipeName,
                            'Logging': false
                          });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: primaryColor,
                          action: SnackBarAction(
                            label: 'Dismiss',
                            textColor: Colors.white,
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                            },
                          ),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(minutes: 1),
                          content: const Text('Recipe Already Exists')));
                    }
                  },
                  child: const Text(
                    "Enter",
                    style: TextStyle(color: primaryColor),
                  ))
            ],
          );
        });
  }

  bool recommendationsOn = true;
  @override
  void initState() {
    loadMyModel();
    super.initState();
    final _auth = AuthService();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final Size size = MediaQuery.of(context).size;
      final uid = _auth.getUID();
      String? isrecommendationsOn =
          (await const FlutterSecureStorage().read(key: 'recommendations'));
      if (isrecommendationsOn == "true") {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                content: StreamBuilder<List<DocumentSnapshot>>(
                    stream: FoodStatsService(uid: uid).recommendedFoodClass,
                    builder: (context, snapshot) {
                      double carbs = 0;
                      double protein = 0;
                      double fat = 0;
                      List<DocumentSnapshot> breakfastList = [];
                      List<DocumentSnapshot> lunchList = [];
                      List<DocumentSnapshot> dinnerList = [];
                      List<DocumentSnapshot> snackList = [];

                      if (!snapshot.hasData) {
                        return const Loading();
                      }
                      for (int i = 0; i < snapshot.data!.length; i++) {
                        if (snapshot.data![i].get('Breakfast') > 1) {
                          breakfastList.add(snapshot.data![i]);
                        } else if (snapshot.data![i].get('Lunch') > 1) {
                          lunchList.add(snapshot.data![i]);
                        } else if (snapshot.data![i].get('Dinner') > 1) {
                          dinnerList.add(snapshot.data![i]);
                        } else if (snapshot.data![i].get('Snack') > 1) {
                          snackList.add(snapshot.data![i]);
                        }
                      }
                      return SizedBox(
                        width: 0.99 * size.width,
                        height: 0.9 * size.height,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.black)),
                              child: RecommendationList(
                                mealList: breakfastList,
                                mealType: 'Breakfast Recommendations',
                              ),
                            ),
                            SizedBox(
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.black)),
                              child: RecommendationList(
                                mealList: lunchList,
                                mealType: 'Lunch Recommendations',
                              ),
                            ),
                            SizedBox(
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.black)),
                              child: RecommendationList(
                                mealList: dinnerList,
                                mealType: 'Dinner Recommendations',
                              ),
                            ),
                            SizedBox(
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.black)),
                              child: RecommendationList(
                                mealList: snackList,
                                mealType: 'Snack Recommendations',
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey,
        resizeToAvoidBottomInset: true,
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Logging Food"),
          ),
          // centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 0.04 * size.height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Recommendations:"),
                FutureBuilder<String?>(
                    initialData: 'true',
                    future: const FlutterSecureStorage()
                        .read(key: 'recommendations'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        recommendationsOn = snapshot.data! == 'true';
                        return Switch.adaptive(
                            value: recommendationsOn,
                            onChanged: (val) async {
                              setState(() => recommendationsOn = val);
                              await const FlutterSecureStorage().write(
                                  key: 'recommendations',
                                  value: recommendationsOn.toString());
                            });
                      } else {
                        return Switch.adaptive(
                            value: recommendationsOn,
                            onChanged: (val) async {
                              setState(() => recommendationsOn = val);
                              await const FlutterSecureStorage().write(
                                  key: 'recommendations',
                                  value: recommendationsOn.toString());
                            });
                      }
                    })
              ],
            ),
            SizedBox(
              height: 0.02 * size.height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/RecipeList');
                  },
                  child: const Text("Recipes",
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Inria Serif',
                      )),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(0.45 * size.width, 55)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await showInformationDialog(context);
                  },
                  child: const Text("New Recipe",
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Inria Serif',
                      )),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(0.45 * size.width, 55)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.02 * size.height,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
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
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          searchWord = tempSearchWord;
                        });
                        bloc.searchWords =
                            (searchWord.toLowerCase()).split(' ');
                        bloc.fetchNewSearch();
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: IconButton(
                      onPressed: () async {
                        await _showChoiceDialog(context);
                      },
                      icon: const Icon(
                        Icons.center_focus_strong,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: IconButton(
                      onPressed: () async {
                        await scanBarcodeNormal();
                        if (_scanBarcode != -1) {
                          FoodClass? result = await BarcodeService()
                              .barcodeResult(_scanBarcode);
                          if (result != null) {
                            await Navigator.pushNamed(context, '/BarcodeInfo',
                                arguments: result);
                          }
                        }
                      },
                      icon: const Icon(
                        AppIcons.barcode_2,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.02 * size.height,
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
              recipeName: '',
              bloc: bloc,
            ),
          ],
        ),
      ),
    );
  }
}
