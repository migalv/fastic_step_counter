import 'package:fastic_step_counter/application/goal_setter/goal_setter_bloc.dart';
import 'package:fastic_step_counter/presentation/step_counter/themes/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class GoalFormDialog extends StatelessWidget {
  GoalFormDialog({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalSetterBloc, GoalSetterState>(
      builder: (context, snapshot) {
        final TextEditingController _goalController = TextEditingController(
          text: context.read<GoalSetterBloc>().currentGoal.toString(),
        );
        return AlertDialog(
          title: const Text('Edit Goal'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _goalController,
              decoration: const InputDecoration(labelText: "New Goal"),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The goal can't be empty";
                } else if (int.tryParse(value) == null) {
                  return "Enter a valid goal";
                }
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: AppColors.orange),
              onPressed: () {
                context
                    .read<GoalSetterBloc>()
                    .add(const GoalSetterEvent.cancelGoalButtonPressed());
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColors.orange),
              onPressed: () {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  final int? newGoal = int.tryParse(_goalController.text);

                  if (newGoal == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid value"),
                      ),
                    );
                    return;
                  }

                  context.read<GoalSetterBloc>().add(
                      GoalSetterEvent.confirmGoalButtonPressed(
                          newGoal: newGoal));

                  Navigator.of(context).pop();
                }
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
