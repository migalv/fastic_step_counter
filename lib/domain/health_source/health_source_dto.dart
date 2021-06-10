import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_source_dto.freezed.dart';
part 'health_source_dto.g.dart';

@freezed

/// Data Transfer object to transfer data from the Health Care Source to the app
///
/// I decided to create a DTO for this instead of just returning the steps
/// because in the future the Health Care Source would probably return many
/// other useful paramaters
///
/// I also used Freezed and JSON Serializable because most Services communicate
/// with JSON payloads. These libraries make it really easy to implement.
class HealthSourceDTO with _$HealthSourceDTO {
  const factory HealthSourceDTO({
    int? stepCounter,
  }) = _HealthSourceDTO;

  factory HealthSourceDTO.fromJson(Map<String, dynamic> json) =>
      _$HealthSourceDTOFromJson(json);
}
