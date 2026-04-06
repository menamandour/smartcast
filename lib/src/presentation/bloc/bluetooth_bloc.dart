import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

// Events
abstract class BluetoothEvent extends Equatable {
  const BluetoothEvent();
  @override
  List<Object?> get props => [];
}

class StartScanEvent extends BluetoothEvent {}
class StopScanEvent extends BluetoothEvent {}
class ConnectToDeviceEvent extends BluetoothEvent {
  final BluetoothDevice device;
  const ConnectToDeviceEvent(this.device);
  @override
  List<Object?> get props => [device];
}
class DisconnectFromDeviceEvent extends BluetoothEvent {}

// States
abstract class BluetoothState extends Equatable {
  const BluetoothState();
  @override
  List<Object?> get props => [];
}

class BluetoothInitial extends BluetoothState {}
class BluetoothScanning extends BluetoothState {
  final List<ScanResult> scanResults;
  const BluetoothScanning(this.scanResults);
  @override
  List<Object?> get props => [scanResults];
}
class BluetoothConnecting extends BluetoothState {
  final BluetoothDevice device;
  const BluetoothConnecting(this.device);
  @override
  List<Object?> get props => [device];
}
class BluetoothConnected extends BluetoothState {
  final BluetoothDevice device;
  const BluetoothConnected(this.device);
  @override
  List<Object?> get props => [device];
}
class BluetoothDisconnected extends BluetoothState {}
class BluetoothError extends BluetoothState {
  final String message;
  const BluetoothError(this.message);
  @override
  List<Object?> get props => [message];
}

// BLoC
class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  StreamSubscription? _scanSubscription;
  BluetoothDevice? _connectedDevice;

  BluetoothBloc() : super(BluetoothInitial()) {
    on<StartScanEvent>(_onStartScan);
    on<StopScanEvent>(_onStopScan);
    on<ConnectToDeviceEvent>(_onConnectToDevice);
    on<DisconnectFromDeviceEvent>(_onDisconnectFromDevice);
  }

  Future<void> _onStartScan(StartScanEvent event, Emitter<BluetoothState> emit) async {
    // Check permissions
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted &&
        await Permission.location.request().isGranted) {
      
      emit(const BluetoothScanning([]));
      
      _scanSubscription?.cancel();
      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        add(_UpdateScanResultsEvent(results));
      });

      try {
        await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
      } catch (e) {
        emit(BluetoothError(e.toString()));
      }
    } else {
      emit(const BluetoothError("Permissions not granted"));
    }
  }

  // Internal event to update UI with scan results
  void _onUpdateScanResults(_UpdateScanResultsEvent event, Emitter<BluetoothState> emit) {
    emit(BluetoothScanning(event.results));
  }

  Future<void> _onStopScan(StopScanEvent event, Emitter<BluetoothState> emit) async {
    await FlutterBluePlus.stopScan();
    _scanSubscription?.cancel();
    if (state is BluetoothScanning) {
      emit(BluetoothInitial());
    }
  }

  Future<void> _onConnectToDevice(ConnectToDeviceEvent event, Emitter<BluetoothState> emit) async {
    emit(BluetoothConnecting(event.device));
    try {
      await event.device.connect();
      _connectedDevice = event.device;
      emit(BluetoothConnected(event.device));
    } catch (e) {
      emit(BluetoothError("Failed to connect: ${e.toString()}"));
    }
  }

  Future<void> _onDisconnectFromDevice(DisconnectFromDeviceEvent event, Emitter<BluetoothState> emit) async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
      emit(BluetoothDisconnected());
    }
  }

  // Internal helper for state updates
  @override
  void on<E extends BluetoothEvent>(EventHandler<E, BluetoothState> handler, {EventTransformer<E>? transformer}) {
    if (E == _UpdateScanResultsEvent) {
      super.on<_UpdateScanResultsEvent>((event, emit) => emit(BluetoothScanning(event.results)));
    } else {
      super.on<E>(handler, transformer: transformer);
    }
  }

  @override
  Future<void> close() {
    _scanSubscription?.cancel();
    return super.close();
  }
}

class _UpdateScanResultsEvent extends BluetoothEvent {
  final List<ScanResult> results;
  const _UpdateScanResultsEvent(this.results);
}
