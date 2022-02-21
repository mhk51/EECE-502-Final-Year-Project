import 'dart:ffi';

import 'package:flutter_application_1/models/food_class.dart';

abstract class dailyLogs_class {
  List<food_class> breakfastList = [];
  List<food_class> lunchList = [];
  List<food_class> dinnerList = [];
  List<food_class> snackList = [];

  void computeDailyStatistics();
  void computeListStatistics(List<food_class> fList);
}
