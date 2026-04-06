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
  @override
  void initState() {
    super.initState();
    context.read<BluetoothBloc>().add(StartScanEvent());
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
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
          loc.connectCast,
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
                        Center(
                          child: Text(
                            loc.nearbyBluetoothDevice,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Scanning Status
                        if (state is BluetoothScanning && state.scanResults.isEmpty)
                          const Center(child: CircularProgressIndicator())
                        else if (state is BluetoothScanning)
                          ...state.scanResults.map((result) => _buildDeviceListItem(
                            result.device.platformName.isEmpty ? "Unknown Device" : result.device.platformName,
                            isAr,
                            onTap: () => context.read<BluetoothBloc>().add(ConnectToDeviceEvent(result.device)),
                          )).toList(),
                        
                        const SizedBox(height: 32),
                        Text(
                          loc.bluetoothDevices,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                
                // Bottom Button (Manual Search)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () => context.read<BluetoothBloc>().add(StartScanEvent()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF074FAC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        loc.searchingForDevice,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
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

  Widget _buildDeviceListItem(String name, bool isAr, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            if (!isAr) const Icon(Icons.bluetooth, color: Color(0xFF074FAC), size: 28),
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            if (isAr) const Icon(Icons.bluetooth, color: Color(0xFF074FAC), size: 28),
          ],
        ),
      ),
    );
  }
}
