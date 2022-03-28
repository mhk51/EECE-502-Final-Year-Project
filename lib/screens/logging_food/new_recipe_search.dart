import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/app_icons_icons.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/screens/logging_food/food_search_list.dart';
import 'package:image_picker/image_picker.dart';

import 'logging_food_screen.dart';

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

  var msgController = TextEditingController();
  String tempSearchWord = "";
  String searchWord = "";
  @override
  Widget build(BuildContext context) {
    var recipe =
        ModalRoute.of(context)!.settings.arguments as RecipeIngredients;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Add Recipe Item"),
          ),
          // centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 10,
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
              fromenterrecipe: true,
              ingredients: recipe.ingredients,
            ),
          ],
        ),
      ),
    );
  }
}
