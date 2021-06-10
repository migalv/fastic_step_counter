import 'package:dartz/dartz.dart';
import 'package:fastic_step_counter/domain/health_source/health_source_failure.dart';

/// Specifies a contract for the Health Source
///
/// This allows us to have different implementation for the Health Source
/// without having to change too much code on the application layer.
///
/// In the future if you want to implement a new Health Source you can do it
/// by implementing this contract.
abstract class IHealthSource {
  /// Will create a stream that emits the step counter every time it changes
  ///
  /// We use functional programming to return Failures instead of throwing them
  /// this allows us to controll failures in a cleaner way.
  Stream<Either<HealthSourceFailure, int>> trackUserSteps();
}
