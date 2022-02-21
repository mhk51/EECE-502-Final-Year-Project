abstract class food_class {
  String foodName = "";
  double calories = 0;
  double carbs = 0;
  double protien = 0;
  double fat = 0;
  double bloodSugarInc = 0;
  foodClass(String foodName, double calories, double carbs, double protien,
      double fat, double bloodSugarInc);
  void overrideCalories(double calories);
  void overrideprotien(double protien);
  void overrideCarbs(double carbs);
  void overrideFat(double fat);
  void overrideBloodSugarInc(double bloodSugarInc);

  double getCalories();
  double getCarbs();
  double getProtien();
  double getBloodSugarInc();
  double getFat();
}
