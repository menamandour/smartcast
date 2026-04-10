import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(loc.translate('profile.history')),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: theme.cardColor,
            title: Text('${loc.translate('profile.history')} ${index + 1}', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
            subtitle: Text('Activity or device usage record details go here.', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            leading: Icon(Icons.history, color: theme.iconTheme.color),
          );
        },
      ),
    );
  }
}
