import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fastic_step_counter/domain/health_source/i_health_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'step_watcher_event.dart';
part 'step_watcher_state.dart';
part 'step_watcher_bloc.freezed.dart';

/// Following the Single Responsability Principle we create a bloc that manages
/// the loading & watching of the steps.
///
/// This depends on a IHealthSource. So in the future we can change the Health Source
/// and this will not be affected
@injectable
class StepWatcherBloc extends Bloc<StepWatcherEvent, StepWatcherState> {
  final IHealthSource _healthSource;

  StepWatcherBloc(this._healthSource) : super(const _Initial());

  @override
  Stream<StepWatcherState> mapEventToState(
    StepWatcherEvent event,
  ) async* {
    yield* event.when(
      startedWatching: () async* {
        yield* _healthSource.trackUserSteps().map(
              (failureOrSteps) => failureOrSteps.fold(
                (failure) => StepWatcherState.watchingFailure(
                  failureMessage: failure.when(
                    unexpectedError: () => _unexpectedErrorMessage,
                    stepsNotFound: () => _stepsNotFoundMessage,
                  ),
                ),
                (steps) => StepWatcherState.watchingSuccess(steps: steps),
              ),
            );
      },
    );
  }

  static const _unexpectedErrorMessage = "An unexpected error ocurred.";
  static const _stepsNotFoundMessage =
      "Could not retreive information about the step counter.";
}
