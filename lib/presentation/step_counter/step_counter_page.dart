import 'dart:math' as math;

import 'package:fastic_step_counter/application/goal_setter/goal_setter_bloc.dart';
import 'package:fastic_step_counter/application/step_watcher/step_watcher_bloc.dart';
import 'package:fastic_step_counter/injection.dart';
import 'package:fastic_step_counter/presentation/step_counter/themes/app_colors.dart';
import 'package:fastic_step_counter/presentation/step_counter/widgets/circle_progress.dart';
import 'package:fastic_step_counter/presentation/step_counter/widgets/dialogs/goal_form_dialog.dart';
import 'package:fastic_step_counter/presentation/step_counter/widgets/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<StepWatcherBloc>()
              ..add(const StepWatcherEvent.startedWatching()),
          ),
          BlocProvider(create: (context) => getIt<GoalSetterBloc>()),
        ],
        child: BlocConsumer<StepWatcherBloc, StepWatcherState>(
          listener: _stepWatcherBlocListener,
          builder: (context, state) {
            int steps = 0;

            state.when(
              initial: () {},
              watchingSuccess: (receivedSteps) {
                steps = receivedSteps;
              },
              watchingFailure: (failure) {},
            );

            return BlocConsumer<GoalSetterBloc, GoalSetterState>(
                listener: _goalSetterBlocListener,
                builder: (context, state) {
                  int goal = 0;
                  double progress = 0.0;

                  state.when(
                    initial: (initialGoal) => goal = initialGoal,
                    changeGoalInProgress: () =>
                        goal = context.read<GoalSetterBloc>().currentGoal,
                    changeGoalSuccess: (int currentGoal) => goal = currentGoal,
                    goalChangeCanceled: (int currentGoal) => goal = currentGoal,
                  );

                  progress = steps / goal;

                  return ListView(
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 56.0),
                      CircleProgress(value: progress * 100),
                      _buildStatsRow(
                        steps: steps,
                        goal: goal,
                      ),
                      _buildDailyGoalButton(),
                      const SizedBox(height: 32.0),
                      _buildLinearProgressBar(value: progress),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }

  void _stepWatcherBlocListener(BuildContext context, StepWatcherState state) =>
      state.when(
        initial: () {},
        watchingSuccess: (steps) {},
        watchingFailure: (failureMessage) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failureMessage),
          ),
        ),
      );

  void _goalSetterBlocListener(BuildContext context, GoalSetterState state) =>
      state.when(
        initial: (int initialGoal) {},
        changeGoalInProgress: () {
          final GoalSetterBloc goalSetterBloc = context.read<GoalSetterBloc>();
          showDialog(
            context: context,
            builder: (_) => BlocProvider<GoalSetterBloc>.value(
              value: goalSetterBloc,
              child: GoalFormDialog(),
            ),
          );
        },
        changeGoalSuccess: (int currentGoal) =>
            ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Goal updated successfully"),
          ),
        ),
        goalChangeCanceled: (int currentGoal) {},
      );

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

  Widget _buildStatsRow({
    required int steps,
    required int goal,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          children: [
            Statistics(
              icon: const RotatedBox(
                quarterTurns: -1,
                child: Icon(
                  FontAwesomeIcons.shoePrints,
                  color: AppColors.orange,
                ),
              ),
              statName: "Steps",
              stats: "$steps / $goal",
            ),
            const Expanded(child: SizedBox()),
            const Statistics(
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

  Widget _buildDailyGoalButton() =>
      BlocBuilder<GoalSetterBloc, GoalSetterState>(
        builder: (context, state) {
          return Center(
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
              onPressed: () => context
                  .read<GoalSetterBloc>()
                  .add(const GoalSetterEvent.editGoalButtonPressed()),
              icon: const Icon(Icons.edit_outlined),
              label: const Text("Daily Goal"),
            ),
          );
        },
      );

  Widget _buildLinearProgressBar({required double value}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: const Icon(Icons.flag),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: AppColors.gray30,
                minHeight: 8.0,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
      );
}
