import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom/constants.dart';
import 'package:flutter_application_1/custom/loading.dart';
import 'package:flutter_application_1/models/therapy.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/screens/settings/therapy_dialog.dart';
import 'package:flutter_application_1/services/therapy_database.dart';
import 'package:provider/provider.dart';

class TherapyTab extends StatefulWidget {
  const TherapyTab({Key? key}) : super(key: key);

  @override
  State<TherapyTab> createState() => _TherapyTabState();
}

class _TherapyTabState extends State<TherapyTab> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return user == null
        ? const Loading()
        : StreamBuilder<Therapy>(
            stream: TherapyDatabaseService(uid: user.uid).userTherapyData,
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.active &&
                      snapshot.hasData)
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 50, top: 20),
                            child: Text(
                              'Glucose Levels Target Range',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Hyperglycemia",
                            ),
                            subtitle: Text(
                              '${snapshot.data!.hyperglycemia.toString()} mmol/L',
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            title: const Text(
                              "Glucose High",
                            ),
                            subtitle: Text(
                              '${snapshot.data!.glucoseHigh.toString()} mmol/L',
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Glucose Target",
                            ),
                            subtitle: Text(
                              '${snapshot.data!.glucoseTarget.toString()} mmol/L',
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Glucose Low",
                            ),
                            subtitle: Text(
                                '${snapshot.data!.glucoseLow.toString()} mmol/L'),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Hypoglycemia",
                            ),
                            subtitle: Text(
                              '${snapshot.data!.hypoglycemia.toString()} mmol/L',
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1.5,
                            color: Colors.grey[600],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50, top: 20),
                            child: Text(
                              'Target Range After Meal',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () {},
                            title: const Text(
                              "Hyperglycemia",
                            ),
                            subtitle: Text(
                              '${snapshot.data!.hyperglycemiaAfterMeal.toString()} mmol/L',
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () {},
                            title: const Text(
                              "Glucose High",
                            ),
                            subtitle: Text(
                              '${snapshot.data!.glucoseHighAfterMeal.toString()} mmol/L',
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () {},
                            title: const Text(
                              "Glucose Low",
                            ),
                            subtitle: Text(
                              '${snapshot.data!.glucoseLowAfterMeal.toString()} mmol/L',
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1.5,
                            color: Colors.grey[600],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50, top: 20),
                            child: Text(
                              'Ratio and sensitivity Settings',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 50,
                            ),
                            onTap: () async {
                              double result = await showTherapyDialog(
                                  context,
                                  "Carbohydrates ratio (hourly)",
                                  "00.000",
                                  snapshot.data!.carbohydratesRatio!);
                              await TherapyDatabaseService(uid: user.uid)
                                  .updateUserTherapyCollection(
                                      snapshot.data!.hyperglycemia,
                                      snapshot.data!.glucoseHigh,
                                      snapshot.data!.glucoseTarget,
                                      snapshot.data!.glucoseLow,
                                      snapshot.data!.hypoglycemia,
                                      snapshot.data!.hyperglycemiaAfterMeal,
                                      snapshot.data!.glucoseHighAfterMeal,
                                      snapshot.data!.glucoseLowAfterMeal,
                                      snapshot.data!.breakFastStartTime,
                                      snapshot.data!.breakFastEndTime,
                                      snapshot.data!.lunchStartTime,
                                      snapshot.data!.lunchEndTime,
                                      snapshot.data!.dinnerStartTime,
                                      snapshot.data!.dinnerEndTime,
                                      snapshot.data!.insulinSensitivity!,
                                      result);
                            },
                            title: const Text(
                              "Carbohydrates ratio (hourly)",
                            ),
                            subtitle: Text(
                              'The amount of carbohydrates in grams covered by 1 insulin unit ${(snapshot.data!.carbohydratesRatio == -1) ? '' : '\n00:00->' + snapshot.data!.carbohydratesRatio.toString()}',
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 50,
                            ),
                            onTap: () async {
                              double result = await showTherapyDialog(
                                  context,
                                  "Carbohydrates ratio (hourly)",
                                  "00.000",
                                  snapshot.data!.carbohydratesRatio!);
                              await TherapyDatabaseService(uid: user.uid)
                                  .updateUserTherapyCollection(
                                      snapshot.data!.hyperglycemia,
                                      snapshot.data!.glucoseHigh,
                                      snapshot.data!.glucoseTarget,
                                      snapshot.data!.glucoseLow,
                                      snapshot.data!.hypoglycemia,
                                      snapshot.data!.hyperglycemiaAfterMeal,
                                      snapshot.data!.glucoseHighAfterMeal,
                                      snapshot.data!.glucoseLowAfterMeal,
                                      snapshot.data!.breakFastStartTime,
                                      snapshot.data!.breakFastEndTime,
                                      snapshot.data!.lunchStartTime,
                                      snapshot.data!.lunchEndTime,
                                      snapshot.data!.dinnerStartTime,
                                      snapshot.data!.dinnerEndTime,
                                      result,
                                      snapshot.data!.carbohydratesRatio!);
                            },
                            title: const Text(
                              "Insulin sensitibity (hourly)",
                            ),
                            subtitle: Text(
                              'Glucose amount reduction in mmol/L per insulin unit ${(snapshot.data!.insulinSensitivity == -1) ? '' : '\n00:00->' + snapshot.data!.insulinSensitivity.toString()}',
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1.5,
                            color: Colors.grey[600],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50, top: 20),
                            child: Text(
                              'Breakfast time',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Breakfast start time",
                            ),
                            subtitle: Text(
                              snapshot.data!.breakFastStartTime,
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Breakfast end time",
                            ),
                            subtitle: Text(
                              snapshot.data!.breakFastEndTime,
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1.5,
                            color: Colors.grey[600],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50, top: 20),
                            child: Text(
                              'Lunch time',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Lunch start time",
                            ),
                            subtitle: Text(
                              snapshot.data!.lunchStartTime,
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Lunch end time",
                            ),
                            subtitle: Text(
                              snapshot.data!.lunchEndTime,
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1.5,
                            color: Colors.grey[600],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50, top: 20),
                            child: Text(
                              'Dinner time',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Dinner start time",
                            ),
                            subtitle: Text(
                              snapshot.data!.dinnerStartTime,
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 50,
                            ),
                            onTap: () async {},
                            title: const Text(
                              "Dinner end time",
                            ),
                            subtitle: Text(
                              snapshot.data!.dinnerEndTime,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Loading();
            });
  }
}
