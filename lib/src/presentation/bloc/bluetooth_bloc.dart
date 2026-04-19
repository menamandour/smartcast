import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_ble/universal_ble.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class BluetoothEvent extends Equatable {
  const BluetoothEvent();
  @override
  List<Object?> get props => [];
}

class CheckBluetoothStatusEvent extends BluetoothEvent {}
class RequestPermissionsEvent extends BluetoothEvent {}
class StartScanEvent extends BluetoothEvent {}
class StopScanEvent extends BluetoothEvent {}
class ConnectToDeviceEvent extends BluetoothEvent {
  final BleDevice device;
  const ConnectToDeviceEvent(this.device);
  @override
  List<Object?> get props => [device];
}
class DisconnectFromDeviceEvent extends BluetoothEvent {}
class _UpdateScanResultsEvent extends BluetoothEvent {
  final List<BleDevice> results;
  const _UpdateScanResultsEvent(this.results);
  @override
  List<Object?> get props => [results];
}

// States
abstract class BluetoothState extends Equatable {
  const BluetoothState();
  @override
  List<Object?> get props => [];
}

class BluetoothInitial extends BluetoothState {}
class BluetoothPermissionsDenied extends BluetoothState {
  final String message;
  const BluetoothPermissionsDenied(this.message);
  @override
  List<Object?> get props => [message];
}
class BluetoothDisabled extends BluetoothState {}
class BluetoothScanning extends BluetoothState {
  final List<BleDevice> scanResults;
  const BluetoothScanning(this.scanResults);
  @override
  List<Object?> get props => [scanResults];
}
class BluetoothConnecting extends BluetoothState {
  final BleDevice device;
  const BluetoothConnecting(this.device);
  @override
  List<Object?> get props => [device];
}
class BluetoothConnected extends BluetoothState {
  final BleDevice device;
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
  StreamSubscription<BleDevice>? _scanSubscription;
  final List<BleDevice> _scanResults = [];

  StreamSubscription<List<int>>? _notificationSub;

  BleDevice? _connectedDevice;
  bool _isScanning = false;

  BluetoothBloc() : super(BluetoothInitial()) {
    on<CheckBluetoothStatusEvent>(_onCheckBluetoothStatus);
    on<RequestPermissionsEvent>(_onRequestPermissions);
    on<StartScanEvent>(_onStartScan);
    on<StopScanEvent>(_onStopScan);
    on<ConnectToDeviceEvent>(_onConnectToDevice);
    on<DisconnectFromDeviceEvent>(_onDisconnectFromDevice);
    on<_UpdateScanResultsEvent>(_onUpdateScanResults);
  }

  Future<bool> _hasPermissions() async {
    final status = await UniversalBle.hasPermissions();
    return status == true;
  }

  Future<bool> _requestPermissions() async {
    await UniversalBle.requestPermissions();
    final status = await UniversalBle.hasPermissions();
    return status == true;
  }

  Future<bool> _ensureBluetoothReady(Emitter<BluetoothState> emit) async {
    try {
      // Check if Bluetooth is available
      final BleState = await UniversalBle.getBluetoothAvailabilityState();
      if (BleState == AvailabilityState.unsupported) {
       print("unsupported");
        return false;
      }

      // Check if Bluetooth is enabled
      if (BleState != AvailabilityState.poweredOn) {
        print("not poweredOn");
        return false;
      }

      // Check permissions
      var status = await UniversalBle.hasPermissions();
      if (status != true) {
        // Request permissions
        await UniversalBle.requestPermissions();
        status = await UniversalBle.hasPermissions();
        if (status != true) {
          print("not granted");
          return false;
        }
      }

      return true;
    } catch (e) {
      print("error: $e");
      return false;
    }




    try {
      final availability = await UniversalBle.getBluetoothAvailabilityState();
      if (availability == AvailabilityState.unsupported) {
        emit(const BluetoothError('Bluetooth is not available on this device'));
        return false;
      }
      if (availability != AvailabilityState.poweredOn) {
        emit(BluetoothDisabled());
        return false;
      }
      if (!await _hasPermissions()) {
        emit(const BluetoothPermissionsDenied('Bluetooth permissions are required to scan devices'));
        return false;
      }
      return true;
    } catch (e) {
      emit(BluetoothError('Bluetooth readiness check failed: $e'));
      return false;
    }
  }

  Future<void> _onCheckBluetoothStatus(
    CheckBluetoothStatusEvent event,
    Emitter<BluetoothState> emit,
  ) async {
    try {
      final availability = await UniversalBle.getBluetoothAvailabilityState();
      if (availability == AvailabilityState.unsupported) {
        emit(const BluetoothError('Bluetooth is not available on this device'));
        return;
      }
      if (availability != AvailabilityState.poweredOn) {
        emit(BluetoothDisabled());
        return;
      }
      if (!await _hasPermissions()) {
        emit(const BluetoothPermissionsDenied('Bluetooth permissions are required to scan devices'));
        return;
      }
      emit(BluetoothInitial());
    } catch (e) {
      emit(BluetoothError('Bluetooth status check failed: $e'));
    }
  }

  Future<void> _onRequestPermissions(
    RequestPermissionsEvent event,
    Emitter<BluetoothState> emit,
  ) async {
    try {
      final granted = await _requestPermissions();
      if (!granted) {
        emit(const BluetoothPermissionsDenied('Bluetooth permissions denied'));
        return;
      }
      final availability = await UniversalBle.getBluetoothAvailabilityState();
      if (availability != AvailabilityState.poweredOn) {
        emit(BluetoothDisabled());
      } else {
        emit(BluetoothInitial());
      }
    } catch (e) {
      emit(BluetoothError('Permission request failed: $e'));
    }
  }

  Future<void> _onStartScan(
    StartScanEvent event,
    Emitter<BluetoothState> emit,
  ) async {
    if (!await _ensureBluetoothReady(emit)) {
      return;
    }

    emit(BluetoothScanning([]));
    _scanResults.clear();
    _scanSubscription?.cancel();
    _isScanning = true;

    _scanSubscription = UniversalBle.scanStream.listen(
      (BleDevice bleDevice) {

        print("bleDevice.name: ${bleDevice.name}");
        final exists = _scanResults.any((d) => d.deviceId == bleDevice.deviceId);
        if (!exists) {
          _scanResults.add(bleDevice);
          add(_UpdateScanResultsEvent(List.unmodifiable(_scanResults)));
        }
      },
      onError: (error) {
        emit(BluetoothError('Scan error: $error'));
      },
    );

    try {
      await UniversalBle.startScan();
      Future.delayed(const Duration(seconds: 50), () {
        if (_isScanning) {
          add(StopScanEvent());
        }
      });
    } catch (e) {
      emit(BluetoothError('Failed to start scan: $e'));
    }
  }

  Future<void> _onUpdateScanResults(
    _UpdateScanResultsEvent event,
    Emitter<BluetoothState> emit,
  ) async {
    emit(BluetoothScanning(event.results));
  }

  Future<void> _onStopScan(
    StopScanEvent event,
    Emitter<BluetoothState> emit,
  ) async {
    _isScanning = false;
    try {
      await UniversalBle.stopScan();
    } catch (_) {}
    await _scanSubscription?.cancel();
    _scanSubscription = null;
    emit(BluetoothInitial());
  }

  Future<void> _onConnectToDevice(
      ConnectToDeviceEvent event,
      Emitter<BluetoothState> emit,
      ) async {
    emit(BluetoothConnecting(event.device));

    try {
      _isScanning = false;

      // Stop scanning safely
      try {
        await UniversalBle.stopScan();
      } catch (_) {}

      await _scanSubscription?.cancel();
      _scanSubscription = null;

      // Connect
      await event.device.connect();
      _connectedDevice = event.device;

      print('Connected to device');

      // 🔴 REQUEST MTU (IMPORTANT for bigger packets)
      try {
        print('Requesting MTU 64...');
        int mtu = await event.device.requestMtu(64);
        print('MTU negotiated: $mtu');

        if (mtu < 43) {
          print('WARNING: MTU smaller than expected packet size');
        }
      } catch (e) {
        print('MTU request failed: $e');
      }

      // 🔴 DISCOVER SERVICES
      print('Discovering services...');
      List<BleService> services = await event.device.discoverServices();

      BleCharacteristic? notifyChar;

      for (var service in services) {
        print('Service: ${service.uuid}');

        for (var char in service.characteristics) {
          print('  Char: ${char.uuid} - ${char.properties}');

          // 🔴 FIND NOTIFY CHARACTERISTIC
          if (char.properties.contains(CharacteristicProperty.notify)) {
            notifyChar = char;
            break;
          }
        }

        if (notifyChar != null) break;
      }

      if (notifyChar == null) {
        throw Exception('No notify characteristic found');
      }

      // 🔴 LISTEN TO NOTIFICATIONS
      _notificationSub = notifyChar.onValueReceived.listen(
            (value) {
          print('Received data: $value');

          // TODO: process your bytes here
          // _handleBytes(value);
        },
        onError: (error) {
          print('Notification error: $error');
        },
      );

      // 🔴 ENABLE NOTIFICATIONS
      await notifyChar.notifications.subscribe();
      print('Subscribed to notifications');

      emit(BluetoothConnected(event.device));
    } catch (e) {
      emit(BluetoothError('Failed to connect: $e'));
    }
  }

  Future<void> _onDisconnectFromDevice(
      DisconnectFromDeviceEvent event,
      Emitter<BluetoothState> emit,
      ) async {
    try {
      await _notificationSub?.cancel();
      _notificationSub = null;

      if (_connectedDevice != null) {
        await _connectedDevice!.disconnect();
        _connectedDevice = null;
      }

      emit(BluetoothDisconnected());
    } catch (e) {
      emit(BluetoothError('Disconnect failed: $e'));
    }
  }

  @override
  Future<void> close() {
    _scanSubscription?.cancel();
    return super.close();
  }
}
