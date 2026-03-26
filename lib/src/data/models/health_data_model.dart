import 'package:json_annotation/json_annotation.dart';
import 'package:smartcast/src/domain/entities/health_data.dart';

part 'health_data_model.g.dart';

@JsonSerializable()
class HealthDataModel extends HealthData {
  const HealthDataModel({
    required super.id,
    required super.userId,
    required super.pressure,
    required super.temperature,
    required super.circulation,
    required super.movementTracking,
    required super.recordedAt,
  });

  factory HealthDataModel.fromJson(Map<String, dynamic> json) =>
      _$HealthDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthDataModelToJson(this);

  factory HealthDataModel.fromEntity(HealthData healthData) {
    return HealthDataModel(
      id: healthData.id,
      userId: healthData.userId,
      pressure: healthData.pressure,
      temperature: healthData.temperature,
      circulation: healthData.circulation,
      movementTracking: healthData.movementTracking,
      recordedAt: healthData.recordedAt,
    );
  }

  HealthData toEntity() {
    return HealthData(
      id: id,
      userId: userId,
      pressure: pressure,
      temperature: temperature,
      circulation: circulation,
      movementTracking: movementTracking,
      recordedAt: recordedAt,
    );
  }
}
