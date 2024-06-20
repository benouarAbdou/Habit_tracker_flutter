import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    this.onChanged,
    this.settingsTapped,
    this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  if (onChanged != null) {
                    onChanged!(!habitCompleted); // Toggle habitCompleted
                  }
                },
                backgroundColor: Colors.green,
                icon: Icons.check,
              ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.4,
            motion: const StretchMotion(),
            children: [
              // settings option
              SlidableAction(
                onPressed: settingsTapped,
                backgroundColor: Colors.grey.shade800,
                icon: Icons.settings,
              ),

              // delete option
              SlidableAction(
                onPressed: deleteTapped,
                backgroundColor: Colors.red.shade400,
                icon: Icons.delete,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  habitName,
                  style: TextStyle(
                    decoration: habitCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                habitCompleted
                    ? Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ))
                    : const SizedBox(
                        height: 30,
                        width: 30,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
