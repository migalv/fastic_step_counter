import 'package:fastic_step_counter/presentation/step_counter/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  final Widget icon;
  final String stats;
  final String statName;

  const Statistics({
    Key? key,
    required this.icon,
    required this.stats,
    required this.statName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
        Text(
          stats,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: AppColors.darkBlue,
          ),
        ),
        Text(statName),
      ],
    );
  }
}
