part of 'step_watcher_bloc.dart';

@freezed
class StepWatcherEvent with _$StepWatcherEvent {
  const factory StepWatcherEvent.startedWatching() = _StartedWatching;
}
