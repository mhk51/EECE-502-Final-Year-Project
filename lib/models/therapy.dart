class Therapy {
  final String uid;
  final double hyperglycemia;
  final double glucoseHigh;
  final double glucoseTarget;
  final double glucoseLow;
  final double hypoglycemia;
  final double hyperglycemiaAfterMeal;
  final double glucoseHighAfterMeal;
  final double glucoseLowAfterMeal;
  final String breakFastStartTime;
  final String breakFastEndTime;
  final String lunchStartTime;
  final String lunchEndTime;
  final String dinnerStartTime;
  final String dinnerEndTime;
  late double? insulinSensitivity;
  late double? carbohydratesRatio;
  Therapy({
    required this.glucoseTarget,
    required this.glucoseHigh,
    required this.glucoseHighAfterMeal,
    required this.glucoseLow,
    required this.glucoseLowAfterMeal,
    required this.hyperglycemia,
    required this.hyperglycemiaAfterMeal,
    required this.hypoglycemia,
    required this.uid,
    required this.breakFastEndTime,
    required this.breakFastStartTime,
    required this.dinnerEndTime,
    required this.dinnerStartTime,
    required this.lunchEndTime,
    required this.lunchStartTime,
    required this.carbohydratesRatio,
    required this.insulinSensitivity,
  });
}
