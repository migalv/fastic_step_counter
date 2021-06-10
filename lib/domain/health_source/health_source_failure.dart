import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_source_failure.freezed.dart';

@freezed

/// Union class to represent any failure that can happen in the Health Source
abstract class HealthSourceFailure with _$HealthSourceFailure {
  /// When an unexpected error ocurs withing the Health Source.
  ///
  /// Catching this type of errors helps determining the source of the error
  /// much more effectively.
  const factory HealthSourceFailure.unexpectedError() = _UnexpectedError;

  /// This failure represents the case when for some reason the Health Source
  /// cannot access the step counter of the user.
  const factory HealthSourceFailure.stepsNotFound() = _StepsNotFound;
}
