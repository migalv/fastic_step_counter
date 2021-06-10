part of 'goal_setter_bloc.dart';

@freezed
class GoalSetterState with _$GoalSetterState {
  const factory GoalSetterState.initial({
    required int initialGoal,
  }) = _Initial;
  const factory GoalSetterState.changeGoalInProgress() = _ChangeGoalInProgress;
  const factory GoalSetterState.changeGoalSuccess({
    required int currentGoal,
  }) = _ChangeGoalSuccess;
  const factory GoalSetterState.goalChangeCanceled({
    required int currentGoal,
  }) = _GoalChangeCanceled;
}
