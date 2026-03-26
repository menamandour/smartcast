// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthDataModel _$HealthDataModelFromJson(Map<String, dynamic> json) =>
    HealthDataModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      pressure: (json['pressure'] as num).toDouble(),
      temperature: (json['temperature'] as num).toDouble(),
      circulation: (json['circulation'] as num).toDouble(),
      movementTracking: (json['movementTracking'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );

Map<String, dynamic> _$HealthDataModelToJson(HealthDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'pressure': instance.pressure,
      'temperature': instance.temperature,
      'circulation': instance.circulation,
      'movementTracking': instance.movementTracking,
      'recordedAt': instance.recordedAt.toIso8601String(),
    };
