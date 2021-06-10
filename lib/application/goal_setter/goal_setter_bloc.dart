import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'goal_setter_event.dart';
part 'goal_setter_state.dart';
part 'goal_setter_bloc.freezed.dart';

@injectable
class GoalSetterBloc extends Bloc<GoalSetterEvent, GoalSetterState> {
  // I set the initial goal to be 1000
  GoalSetterBloc() : super(const GoalSetterState.initial(initialGoal: 1000));

  int currentGoal = 1000;

  @override
  Stream<GoalSetterState> mapEventToState(
    GoalSetterEvent event,
  ) async* {
    // As you can see here. It's much easier to implement all the events when using
    // Freezed to create Unions for our states.
    // If you dont implement an event the code will not compile
    yield* event.when(
      editGoalButtonPressed: () async* {
        yield const GoalSetterState.changeGoalInProgress();
      },
      confirmGoalButtonPressed: (int newGoal) async* {
        currentGoal = newGoal;
        yield GoalSetterState.changeGoalSuccess(currentGoal: currentGoal);
      },
      cancelGoalButtonPressed: () async* {
        yield GoalSetterState.goalChangeCanceled(currentGoal: currentGoal);
      },
    );
  }
}
