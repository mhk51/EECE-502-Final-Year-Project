import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/custom/app_icons_icons.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/screens/logging_food/food_search_list.dart';
import 'package:flutter_application_1/services/search_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/food_class.dart';
import '../../services/barcode_service.dart';

class NewRecipeSearch extends StatefulWidget {
  const NewRecipeSearch({Key? key}) : super(key: key);

  @override
  State<NewRecipeSearch> createState() => _NewRecipeSearchState();
}

class _NewRecipeSearchState extends State<NewRecipeSearch> {
  //dialog for camera and image picker
  late File imageFile;
  _openGallery(BuildContext context) async {
    imageFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery)) as File;
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    imageFile =
        (await ImagePicker().pickImage(source: ImageSource.camera)) as File;
    Navigator.of(context).pop();
  }

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

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
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

  Bloc bloc = Bloc();
  var msgController = TextEditingController();
  String tempSearchWord = "";
  String searchWord = "";
  @override
  Widget build(BuildContext context) {
    var recipeName = ModalRoute.of(context)!.settings.arguments as String;
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Add Recipe Item"),
          ),
          // centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 0.04 * size.height,
              ),

              //////////////////////////////////////////////////////////////////////////////////////////////////
              Row(
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
                        bloc.searchWord = searchWord;
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
                        // _showChoiceDialog(context);
                        await Navigator.pushNamed(context, '/CameraScreen');
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
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.02 * size.width,
                  )
                ],
              ),

              //////////////////////////////////////////////////////////////////////////////////////////////////
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     Expanded(
              //       child: TextFormField(
              //         controller: msgController,
              //         decoration: textInputDecoration.copyWith(
              //           hintText: 'Search Food',
              //           enabledBorder: const OutlineInputBorder(
              //             borderSide: BorderSide(
              //               color: Colors.grey,
              //               width: 2.5,
              //             ),
              //           ),
              //           suffixIcon: IconButton(
              //             onPressed: () {
              //               msgController.clear();
              //             },
              //             icon: const Icon(
              //               Icons.cancel,
              //               color: Colors.red,
              //             ),
              //           ),
              //         ),
              //         validator: (val) =>
              //             val!.isEmpty ? 'Enter a Search Word' : null,
              //         onChanged: (val) {
              //           tempSearchWord = val;
              //         },
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     IconButton(
              //       onPressed: () {
              //         setState(() {
              //           searchWord = tempSearchWord;
              //         });
              //         bloc.fetchNewSearch(searchWord);
              //       },
              //       icon: const Icon(
              //         Icons.search,
              //         color: Colors.blue,
              //         size: 30,
              //       ),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         _showChoiceDialog(context);
              //       },
              //       icon: const Icon(
              //         Icons.center_focus_strong,
              //         color: Colors.blue,
              //         size: 30,
              //       ),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         _showChoiceDialog(context);
              //       },
              //       icon: const Icon(
              //         AppIcons.barcode_2,
              //         color: Colors.blue,
              //         size: 27,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     )
              //   ],
              // ),
              SizedBox(
                height: 0.02 * size.height,
              ),
              FoodSearchWidget(
                searchWord: searchWord, recipeName: recipeName,
                // fromenterrecipe: true,
                // ingredients: recipe.ingredients,
                bloc: bloc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
