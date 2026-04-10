import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/presentation/pages/messages_page.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isAr) Icon(Icons.notifications_active, color: Colors.red.shade400, size: 32),
                  if (!isAr) const SizedBox(width: 12),
                  Text(
                    loc.navAlerts,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isAr) const SizedBox(width: 12),
                  if (isAr) Icon(Icons.notifications_active, color: Colors.red.shade400, size: 32),
                ],
              ),
              const SizedBox(height: 32),

              // Highlight Alerts
              _buildAlertCard(
                title: loc.highPressure,
                time: '2 ${loc.minAgo}',
                icon: Icons.speed,
                color: const Color(0xFFFFEBEE),
                textColor: Colors.red,
                isAr: isAr,
              ),
              const SizedBox(height: 16),
              _buildAlertCard(
                title: loc.feverDetected,
                time: '15 ${loc.minAgo}',
                icon: Icons.warning_amber_rounded,
                color: const Color(0xFFFFF3E0),
                textColor: Colors.orange,
                isAr: isAr,
              ),
              const SizedBox(height: 16),
              _buildAlertCard(
                title: loc.humidityIsHigh,
                time: '1 ${loc.hrAgo}',
                icon: Icons.opacity,
                color: const Color(0xFFE3F2FD),
                textColor: Colors.blue,
                isAr: isAr,
              ),

              const SizedBox(height: 32),
              Text(
                loc.todayAlerts,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Today's Alerts
              _buildAlertCard(
                title: loc.pressureIsRising,
                time: '09:15 AM',
                icon: Icons.trending_up,
                color: Colors.grey.shade100,
                textColor: Colors.black,
                isAr: isAr,
              ),
              const SizedBox(height: 12),
              _buildAlertCard(
                title: loc.tempAbove37,
                time: '07:19 AM',
                icon: Icons.thermostat,
                color: Colors.grey.shade100,
                textColor: Colors.red,
                isAr: isAr,
              ),
              const SizedBox(height: 12),
              _buildAlertCard(
                title: loc.humidityAlert,
                time: '05:44 AM',
                icon: Icons.opacity,
                color: Colors.grey.shade100,
                textColor: Colors.green,
                isAr: isAr,
              ),

              const SizedBox(height: 32),
              // View All Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MessagesPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E60FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    loc.viewAll,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertCard({
    required String title,
    required String time,
    required IconData icon,
    required Color color,
    required Color textColor,
    required bool isAr,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          if (!isAr) Icon(icon, color: textColor, size: 32),
          if (!isAr) const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          if (isAr) const SizedBox(width: 16),
          if (isAr) Icon(icon, color: textColor, size: 32),
          const SizedBox(width: 8),
          Icon(
            isAr ? Icons.chevron_left : Icons.chevron_right,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
