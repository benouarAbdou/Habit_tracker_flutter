import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 75,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
    );
  }
}
