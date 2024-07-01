import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habitTile.dart';
import 'package:habit_tracker/components/monthSummary.dart';
import 'package:habit_tracker/components/myAlertBox.dart';
import 'package:habit_tracker/components/myFab.dart';
import 'package:habit_tracker/data/habitDb.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  // open a box
  await Hive.openBox("Habit_Database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit tracker',
      theme: ThemeData(useMaterial3: false, primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    // if there is no current habit list, then it is the 1st time ever opening the app
    // then create default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
      //db.populateHeatMapDataSet();
    }

    // there already exists data, this is not the first time
    else {
      db.loadData();
    }

    // update the database
    db.updateDatabase();

    super.initState();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    // show alert dialog for user to enter the new habit details
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter habit name..',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    // add new habit to todays habit list
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });

    // clear textfield
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // cancel new habit
  void cancelDialogBox() {
    // clear textfield
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  // open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: db.todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  int calculateCurrentStreak() {
    int currentStreak = 0;
    DateTime today = DateTime.now();
    DateTime currentDate = DateTime(today.year, today.month, today.day);

    if (db.heatMapDataSet.containsKey(currentDate) &&
        db.heatMapDataSet[currentDate]! > 0) {
      currentStreak++;
    } else {
      return currentStreak;
    }

    while (true) {
      currentDate = currentDate.subtract(const Duration(days: 1));
      if (db.heatMapDataSet.containsKey(currentDate) &&
          db.heatMapDataSet[currentDate]! > 0) {
        currentStreak++;
      } else {
        break;
      }
    }

    return currentStreak;
  }

  // Function to calculate the longest streak
  int calculateLongestStreak() {
    int longestStreak = 0;
    int currentStreak = 0;

    List<DateTime> dates = db.heatMapDataSet.keys.toList();
    dates.sort();

    for (var date in dates) {
      if (db.heatMapDataSet[date]! > 0) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else {
        currentStreak = 0;
      }
    }

    return longestStreak;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.black,
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: const Text(
                'Welecome back! 👋',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            // New Container with Image and Streak Info
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.5),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/target.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Max Streak: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '${calculateLongestStreak()} days',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Current Streak: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '${calculateCurrentStreak()} days',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "🏆 Heat map",
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.grey[500],
                ))
              ],
            ),

            // Monthly summary heat map
            MonthlySummary(
              datasets: db.heatMapDataSet,
              startDate: _myBox.get("START_DATE"),
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "🎯 Habits",
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.grey[500],
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // list of habits
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todaysHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: db.todaysHabitList[index][0],
                  habitCompleted: db.todaysHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => deleteHabit(index),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
