import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.helpCenter),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.helpCenter,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('If you need help, contact support at support@smartcast.com.'),
            const SizedBox(height: 16),
            const Text('FAQ:'),
            const SizedBox(height: 8),
            const Text('• How to connect a device?'),
            const Text('• How to update my profile?'),
            const Text('• How to change language?'),
          ],
        ),
      ),
    );
  }
}
