import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/bolus.dart';
import 'package:flutter_application_1/screens/camera_screen.dart';
import 'package:flutter_application_1/screens/daily_log_screen/daily_log_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/recipe/input_new_recipe.dart';
import 'package:flutter_application_1/screens/item_info_screen.dart';
import 'package:flutter_application_1/screens/logging_food/logging_food_screen.dart';
import 'package:flutter_application_1/screens/recipe/new_recipe_search.dart';
import 'package:flutter_application_1/screens/recipe/recipe_item_info.dart';
import 'package:flutter_application_1/screens/recipe/recipe_list.dart';
import 'package:flutter_application_1/screens/settings/settings_form.dart';
import 'package:flutter_application_1/screens/weekly_insights_screen.dart';
import 'package:flutter_application_1/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//added a comment
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/Home': (context) => const HomeScreen(),
          '/Insights': (context) => const WeeklyInsightsScreen(),
          '/ItemInfo': (context) => const ItemInfoScreen(),
          '/RecipeItemInfo': (context) => const RecipeItemInfoScreen(),
          '/LoggingFood': (context) => const LoggingFoodScreen(),
          '/NewRecipeSearch': (context) => const NewRecipeSearch(),
          '/InputNewRecipe': (context) => const InputNewRecipe(),
          '/DailyLogging': (context) => const DailyLogScreen(),
          '/Settings': (context) => const SettingsForm(),
          '/CameraScreen': (context) => const CameraScreen(),
          '/Bolus': (context) => const Bolus(),
          '/RecipeList': (context) => const RecipeList(),
          // '/SignIn': (context) => SignIn1(toggleView: () {}),
          // '/SignUp': (context) => SignUp1(),
        },
      ),
    );
  }
}
