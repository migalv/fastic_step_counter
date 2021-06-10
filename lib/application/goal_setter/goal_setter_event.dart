part of 'goal_setter_bloc.dart';

@freezed
class GoalSetterEvent with _$GoalSetterEvent {
  const factory GoalSetterEvent.editGoalButtonPressed() =
      _EditGoalButtonPressed;

  const factory GoalSetterEvent.confirmGoalButtonPressed({
    required int newGoal,
  }) = _ConfirmGoalButtonPressed;

  const factory GoalSetterEvent.cancelGoalButtonPressed() =
      _CancelGoalButtonPressed;
}
