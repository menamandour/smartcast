import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';

class BluetoothDetailsPage extends StatelessWidget {
  const BluetoothDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(isAr ? Icons.arrow_forward_ios : Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          loc.translate('devices.bluetooth'),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Bluetooth Icon
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E60FF).withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1E60FF), width: 4),
                ),
                child: const Icon(Icons.bluetooth, color: Color(0xFF1E60FF), size: 80),
              ),
            ),
            const SizedBox(height: 32),
            
            // Status
            const Text(
              'Smart Cast',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF074FAC),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.translate('devices.connected'),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.check_box_outlined, color: Colors.green),
              ],
            ),
            
            const SizedBox(height: 48),
            
            // Device Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFB9C6D9).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${loc.translate('devices.castIdLabel')}: #0092',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.search, color: Color(0xFF1E60FF)),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '${loc.translate('devices.batteryLabel')}: 89%',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Battery Bar
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Container(
                          width: 200, // 89% approximate
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Disconnected Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB9C6D9).withOpacity(0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    loc.translate('devices.disconnected'),
                    style: const TextStyle(
                      color: Color(0xFF0A0E21),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            
            const Spacer(),
            
            // Searching Status
            Column(
              children: [
                const Icon(Icons.wifi, color: Color(0xFF1E60FF), size: 40),
                const SizedBox(height: 8),
                Text(
                  loc.translate('devices.searchingForDevice'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
