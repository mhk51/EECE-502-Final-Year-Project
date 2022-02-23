import 'package:flutter_application_1/models/food_class.dart';

abstract class DailyLogsClass {
  List<FoodClass> breakfastList = [];
  List<FoodClass> lunchList = [];
  List<FoodClass> dinnerList = [];
  List<FoodClass> snackList = [];

  void computeDailyStatistics();
  void computeListStatistics(List<FoodClass> fList);
}
