import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';

class SmartHomeDashboard extends StatelessWidget {
  const SmartHomeDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(loc.translate('smartHome.smartHome')),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('smartHome.welcomeHome'),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildDeviceCard(loc.translate('smartHome.smartLamp'), Icons.lightbulb, true),
                _buildDeviceCard(loc.translate('smartHome.airConditioner'), Icons.ac_unit, false),
                _buildDeviceCard(loc.translate('smartHome.smartTV'), Icons.tv, true),
                _buildDeviceCard(loc.translate('smartHome.securityCamera'), Icons.videocam, false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(String title, IconData icon, bool isActive) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: isActive ? theme.colorScheme.primary.withOpacity(0.14) : theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: theme.colorScheme.primary) : null,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: isActive ? theme.colorScheme.primary : theme.iconTheme.color),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive
                  ? theme.colorScheme.primary
                  : theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isActive ? 'ON' : 'OFF',
            style: TextStyle(
              color: isActive
                  ? theme.colorScheme.primary
                  : theme.textTheme.bodyMedium?.color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
