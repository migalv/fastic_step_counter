part of 'step_watcher_bloc.dart';

@freezed
class StepWatcherState with _$StepWatcherState {
  const factory StepWatcherState.initial() = _Initial;
  const factory StepWatcherState.watchingSuccess({
    required int steps,
  }) = _WatchingSuccess;
  const factory StepWatcherState.watchingFailure({
    required String failureMessage,
  }) = _WatchingFailure;
}
