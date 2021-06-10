import 'dart:math' as math;

import 'package:fastic_step_counter/presentation/step_counter/themes/app_colors.dart';
import 'package:fastic_step_counter/presentation/step_counter/widgets/circle_progress.dart';
import 'package:fastic_step_counter/presentation/step_counter/widgets/statistics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepCounterPage extends StatelessWidget {
  const StepCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkBlue,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_off_outlined,
              color: AppColors.darkBlue,
            ),
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 56.0),
          const CircleProgress(value: 49.0),
          _buildStatsRow(),
          _buildDailyGoalButton(),
          const SizedBox(height: 32.0),
          _buildLinearProgressBar(),
        ],
      ),
    );
  }

  Widget _buildTitle() => const Padding(
        padding: EdgeInsets.only(left: 16.0, top: 16.0),
        child: Text(
          "Stepcounter",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w900,
            color: AppColors.darkBlue,
          ),
        ),
      );

  Widget _buildStatsRow() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          children: const [
            Statistics(
              icon: RotatedBox(
                quarterTurns: -1,
                child: Icon(
                  FontAwesomeIcons.shoePrints,
                  color: AppColors.orange,
                ),
              ),
              statName: "Steps",
              stats: "1557 / 30000",
            ),
            Expanded(child: SizedBox()),
            Statistics(
              icon: Icon(
                FontAwesomeIcons.fire,
                color: AppColors.orange,
              ),
              statName: "Calories",
              stats: "340",
            ),
          ],
        ),
      );

  Widget _buildDailyGoalButton() => Center(
        child: TextButton.icon(
          style: TextButton.styleFrom(
            primary: AppColors.gray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20.0,
            ),
            backgroundColor: AppColors.gray20,
          ),
          onPressed: () {},
          icon: const Icon(Icons.edit_outlined),
          label: const Text("Daily Goal"),
        ),
      );

  Widget _buildLinearProgressBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: const Icon(Icons.flag)),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: const LinearProgressIndicator(
                value: 0.49,
                backgroundColor: AppColors.gray30,
                minHeight: 8.0,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
      );
}
