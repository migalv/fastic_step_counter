import 'dart:math';

import 'package:fastic_step_counter/domain/health_source/health_source_dto.dart';
import 'package:fastic_step_counter/domain/health_source/health_source_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:fastic_step_counter/domain/health_source/i_health_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IHealthSource)

/// A mock implementation of the Health Source
class MockHealthSource implements IHealthSource {
  /// Since this is a mock implementation so it will have no dependencies. It
  /// will just imatate a Health Source
  ///
  /// But in the case of implementing Google Health Care or other package this
  /// a perfect place to inject this dependency
  MockHealthSource() {
    _stepCounter = 0;
  }

  // Internal step counter;
  late int _stepCounter;

  @override
  Stream<Either<HealthSourceFailure, int>> trackUserSteps() {
    final random = Random();
    const min = 1;
    const max = 3;

    return Stream<Map<String, dynamic>>.periodic(
      const Duration(seconds: 1),
      (json) {
        final int currentStepCounter =
            _stepCounter + (min + random.nextInt(max - min));
        _stepCounter = currentStepCounter;
        // Here I return a json to imitate what an API or a Health Source would
        return {
          // These are just random parameters that I believe a Health Source might emit
          // For now we ignore them since we do not need them
          "time": DateTime.now().toIso8601String(),
          "heart_beat": 86,
          "step_counter": currentStepCounter,
        };
      },
    ).map<Either<HealthSourceFailure, int>>((json) {
      // Then I use the DTO to transform the data from JSON to an object
      final healthSourceDTO = HealthSourceDTO.fromJson(json);
      // I check if the step counter was retrieved if not then I return a failure
      if (healthSourceDTO.stepCounter == null) {
        return const Left(HealthSourceFailure.stepsNotFound());
      } else {
        return Right(healthSourceDTO.stepCounter!);
      }
    }).handleError((e) {
      return const HealthSourceFailure.unexpectedError();
    });
  }
}
