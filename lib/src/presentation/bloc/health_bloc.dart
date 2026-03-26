import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/domain/entities/health_data.dart';
import 'package:smartcast/src/domain/usecases/get_health_data_history_usecase.dart';
import 'package:smartcast/src/domain/usecases/record_health_data_usecase.dart';

// Events
abstract class HealthEvent extends Equatable {
  const HealthEvent();

  @override
  List<Object?> get props => [];
}

class RecordHealthDataEvent extends HealthEvent {
  final String userId;
  final double pressure;
  final double temperature;
  final double circulation;
  final double movementTracking;

  const RecordHealthDataEvent({
    required this.userId,
    required this.pressure,
    required this.temperature,
    required this.circulation,
    required this.movementTracking,
  });

  @override
  List<Object?> get props => [
    userId,
    pressure,
    temperature,
    circulation,
    movementTracking,
  ];
}

class GetHealthDataHistoryEvent extends HealthEvent {
  final String userId;
  final int limit;

  const GetHealthDataHistoryEvent({required this.userId, this.limit = 30});

  @override
  List<Object?> get props => [userId, limit];
}

// States
abstract class HealthState extends Equatable {
  const HealthState();

  @override
  List<Object?> get props => [];
}

class HealthInitialState extends HealthState {
  const HealthInitialState();
}

class HealthLoadingState extends HealthState {
  const HealthLoadingState();
}

class HealthDataRecordedState extends HealthState {
  final HealthData healthData;

  const HealthDataRecordedState({required this.healthData});

  @override
  List<Object?> get props => [healthData];
}

class HealthDataHistoryState extends HealthState {
  final List<HealthData> healthDataList;

  const HealthDataHistoryState({required this.healthDataList});

  @override
  List<Object?> get props => [healthDataList];
}

class HealthErrorState extends HealthState {
  final String message;

  const HealthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

// BLoC
class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final RecordHealthDataUseCase recordHealthDataUseCase;
  final GetHealthDataHistoryUseCase getHealthDataHistoryUseCase;

  HealthBloc({
    required this.recordHealthDataUseCase,
    required this.getHealthDataHistoryUseCase,
  }) : super(const HealthInitialState()) {
    on<RecordHealthDataEvent>(_onRecordHealthDataEvent);
    on<GetHealthDataHistoryEvent>(_onGetHealthDataHistoryEvent);
  }

  Future<void> _onRecordHealthDataEvent(
    RecordHealthDataEvent event,
    Emitter<HealthState> emit,
  ) async {
    emit(const HealthLoadingState());
    final result = await recordHealthDataUseCase(
      userId: event.userId,
      pressure: event.pressure,
      temperature: event.temperature,
      circulation: event.circulation,
      movementTracking: event.movementTracking,
    );

    result.fold(
      (failure) => emit(HealthErrorState(message: failure.message)),
      (healthData) => emit(HealthDataRecordedState(healthData: healthData)),
    );
  }

  Future<void> _onGetHealthDataHistoryEvent(
    GetHealthDataHistoryEvent event,
    Emitter<HealthState> emit,
  ) async {
    emit(const HealthLoadingState());
    final result = await getHealthDataHistoryUseCase(
      userId: event.userId,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(HealthErrorState(message: failure.message)),
      (healthDataList) =>
          emit(HealthDataHistoryState(healthDataList: healthDataList)),
    );
  }
}
