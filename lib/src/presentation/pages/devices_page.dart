import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/config/routes/app_routes.dart';
import 'package:smartcast/src/presentation/bloc/bluetooth_bloc.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  bool _initializationDone = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initializationDone) {
      final bloc = context.read<BluetoothBloc>();
      bloc.add(CheckBluetoothStatusEvent());
      bloc.add(StartScanEvent());
      _initializationDone = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(isAr ? Icons.arrow_forward_ios : Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            context.read<BluetoothBloc>().add(StopScanEvent());
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          loc.translate('devices.connectCast'),
          style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BluetoothBloc, BluetoothState>(
        listener: (context, state) {
          if (state is BluetoothConnected) {
            Navigator.of(context).pushNamed(AppRoutes.bluetoothDetails);
          }
          if (state is BluetoothError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Status Header
                        _buildStatusHeader(loc, state),

                        const SizedBox(height: 24),

                        // Permissions Denied
                        if (state is BluetoothPermissionsDenied)
                          _buildPermissionsDeniedSection(loc, context)
                        // Bluetooth Disabled
                        else if (state is BluetoothDisabled)
                          _buildBluetoothDisabledSection(loc)
                        // Scanning
                        else if (state is BluetoothScanning)
                          _buildScanningSection(loc, isAr, state)
                        // Connecting/Connected
                        else if (state is BluetoothConnecting)
                          _buildConnectingSection(loc, state)
                        // Initial
                        else if (state is BluetoothInitial)
                          _buildInitialSection(loc, context)
                        // Error
                        else if (state is BluetoothError)
                          _buildErrorSection(loc, state, context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusHeader(AppLocalizations loc, BluetoothState state) {
    String statusText = '';
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.bluetooth_disabled;

    if (state is BluetoothPermissionsDenied) {
      statusText = loc.translate('devices.permissionsRequired');
      statusColor = Colors.orange;
      statusIcon = Icons.lock;
    } else if (state is BluetoothDisabled) {
      statusText = loc.translate('devices.bluetoothOffline');
      statusColor = Colors.red;
      statusIcon = Icons.bluetooth_disabled;
    } else if (state is BluetoothScanning) {
      statusText = loc.translate('devices.scanningForDevices');
      statusColor = const Color(0xFF074FAC);
      statusIcon = Icons.bluetooth_searching;
    } else if (state is BluetoothConnecting) {
      statusText = loc.translate('devices.connecting');
      statusColor = Colors.orange;
      statusIcon = Icons.bluetooth_connected;
    } else if (state is BluetoothConnected) {
      statusText = loc.translate('bluetooth.connected');
      statusColor = Colors.green;
      statusIcon = Icons.bluetooth_connected;
    } else if (state is BluetoothInitial) {
      statusText = loc.translate('devices.readyToScan');
      statusColor = const Color(0xFF074FAC);
      statusIcon = Icons.bluetooth;
    } else if (state is BluetoothError) {
      statusText = loc.translate('devices.error');
      statusColor = Colors.red;
      statusIcon = Icons.error;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        border: Border.all(color: statusColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsDeniedSection(AppLocalizations loc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Icon(Icons.lock_outline, size: 64, color: Colors.red.shade200),
        ),
        const SizedBox(height: 24),
        Text(
          loc.translate('devices.permissionsRequired'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          'This app needs the following permissions to scan for Bluetooth devices:\n\n'
          '• ${loc.translate('devices.bluetoothScanPermission')}\n'
          '• ${loc.translate('devices.bluetoothConnectPermission')}\n'
          '• ${loc.translate('devices.locationPermission')}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<BluetoothBloc>().add(RequestPermissionsEvent());
            },
            icon: const Icon(Icons.check_circle),
            label: Text(loc.translate('devices.grantPermissions')),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF074FAC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBluetoothDisabledSection(AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Icon(Icons.bluetooth_disabled, size: 64, color: Colors.red.shade200),
        ),
        const SizedBox(height: 24),
        Text(
          loc.translate('devices.bluetoothOffline'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          loc.translate('devices.enableBluetooth'),
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            border: Border.all(color: Colors.blue.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.blue.shade700),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  loc.translate('devices.goToSettings'),
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScanningSection(AppLocalizations loc, bool isAr, BluetoothScanning state) {
    if (state.scanResults.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 40),
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 24),
          Center(
            child: Text(
              loc.translate('devices.searchingForDevice'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            loc.translate('devices.smartCastPoweredOn'),
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 32),
        ],
      );
    }

    return Column(
      crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          loc.translate('devices.foundDevices', args: {'count': state.scanResults.length, 'plural': state.scanResults.length != 1 ? 's' : ''}),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...state.scanResults.map((result) {
          final deviceName = (result.name?.isNotEmpty == true)
              ? result.name!
              : result.deviceId;
          return _buildDeviceListItem(
            deviceName,
            result.rssi ?? -100,
            isAr,
            onTap: () => context.read<BluetoothBloc>().add(ConnectToDeviceEvent(result)),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildConnectingSection(AppLocalizations loc, BluetoothConnecting state) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Center(child: CircularProgressIndicator()),
        const SizedBox(height: 24),
        Center(
          child: Text(
            loc.translate('devices.connectingTo', args: {'device': state.device.name ?? state.device.deviceId}),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildInitialSection(AppLocalizations loc, BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Center(
          child: Icon(Icons.bluetooth, size: 64, color: Colors.grey.shade300),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            loc.translate('devices.readyToScan'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          loc.translate('devices.tapToStartScanning'),
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => context.read<BluetoothBloc>().add(StartScanEvent()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF074FAC),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              loc.translate('devices.startScanning'),
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorSection(AppLocalizations loc, BluetoothError state, BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Center(
          child: Icon(Icons.error_outline, size: 64, color: Colors.red.shade200),
        ),
        const SizedBox(height: 24),
        Text(
          loc.translate('devices.errorOccurred'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          state.message,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => context.read<BluetoothBloc>().add(CheckBluetoothStatusEvent()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF074FAC),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              loc.tryAgain,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceListItem(
    String name,
    int rssi,
    bool isAr, {
    VoidCallback? onTap,
  }) {
    // Map RSSI to signal strength (rough estimate)
    // RSSI is negative, closer to 0 is better
    int signalStrength = 0;
    if (rssi > -50) {
      signalStrength = 4;
    } else if (rssi > -60) {
      signalStrength = 3;
    } else if (rssi > -70) {
      signalStrength = 2;
    } else if (rssi > -80) {
      signalStrength = 1;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            if (!isAr) const Icon(Icons.bluetooth, color: Color(0xFF074FAC), size: 28),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        for (int i = 0; i < 4; i++)
                          Icon(
                            Icons.signal_cellular_4_bar,
                            size: 14,
                            color: i < signalStrength ? Colors.green : Colors.grey.shade300,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          '${rssi} dBm',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isAr) const Icon(Icons.bluetooth, color: Color(0xFF074FAC), size: 28),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
