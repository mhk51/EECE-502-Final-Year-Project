import 'package:flutter_application_1/models/food_class.dart';

FoodClass f1 = FoodClass(
    foodName: "Apple",
    sugar: 10,
    carbs: 30,
    protien: 20,
    fat: 8,
    bloodSugarInc: 1);

FoodClass f2 = FoodClass(
    foodName: "Apple",
    sugar: 10,
    carbs: 30,
    protien: 20,
    fat: 8,
    bloodSugarInc: 1);
FoodClass f3 = FoodClass(
    foodName: "Apple",
    sugar: 10,
    carbs: 30,
    protien: 20,
    fat: 8,
    bloodSugarInc: 1);
FoodClass f4 = FoodClass(
    foodName: "Apple",
    sugar: 10,
    carbs: 30,
    protien: 20,
    fat: 8,
    bloodSugarInc: 1);

class DailyLogsClass {
  List<FoodClass> breakfastList = [];
  List<FoodClass> lunchList = [];
  List<FoodClass> dinnerList = [];
  List<FoodClass> snackList = [];
  DailyLogsClass();

  List computeDailyStatistics() {
    int totalCarbs = 0;
    int totalProtein = 0;
    int totalFat = 0;

    for (int i = 0; i < breakfastList.length; i++) {
      totalCarbs = totalCarbs + breakfastList[i].carbs as int;
      totalProtein = totalProtein + breakfastList[i].protien as int;
      totalFat = totalFat + breakfastList[i].fat as int;
    }
    for (int i = 0; i < lunchList.length; i++) {
      totalCarbs = totalCarbs + lunchList[i].carbs as int;
      totalProtein = totalProtein + lunchList[i].protien as int;
      totalFat = totalFat + lunchList[i].fat as int;
    }
    for (int i = 0; i < dinnerList.length; i++) {
      totalCarbs = totalCarbs + dinnerList[i].carbs as int;
      totalProtein = totalProtein + dinnerList[i].protien as int;
      totalFat = totalFat + dinnerList[i].fat as int;
    }
    for (int i = 0; i < snackList.length; i++) {
      totalCarbs = totalCarbs + snackList[i].carbs as int;
      totalProtein = totalProtein + snackList[i].protien as int;
      totalFat = totalFat + snackList[i].fat as int;
    }
    List summary = [totalCarbs, totalProtein, totalFat];
    return summary;
  }

  List computeListStatistics(List<FoodClass> fList) {
    int totalCarbs = 0;
    int totalProtein = 0;
    int totalFat = 0;

    for (int i = 0; i < fList.length; i++) {
      totalCarbs = totalCarbs + fList[i].carbs as int;
      totalProtein = totalProtein + fList[i].protien as int;
      totalFat = totalFat + fList[i].fat as int;
    }
    List summary = [totalCarbs, totalProtein, totalFat];
    return summary;
  }
}
