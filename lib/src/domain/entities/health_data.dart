import 'package:equatable/equatable.dart';

class HealthData extends Equatable {
  final String id;
  final String userId;
  final double pressure;
  final double temperature;
  final double circulation;
  final double movementTracking;
  final DateTime recordedAt;

  const HealthData({
    required this.id,
    required this.userId,
    required this.pressure,
    required this.temperature,
    required this.circulation,
    required this.movementTracking,
    required this.recordedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    pressure,
    temperature,
    circulation,
    movementTracking,
    recordedAt,
  ];

  HealthData copyWith({
    String? id,
    String? userId,
    double? pressure,
    double? temperature,
    double? circulation,
    double? movementTracking,
    DateTime? recordedAt,
  }) {
    return HealthData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      pressure: pressure ?? this.pressure,
      temperature: temperature ?? this.temperature,
      circulation: circulation ?? this.circulation,
      movementTracking: movementTracking ?? this.movementTracking,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}
