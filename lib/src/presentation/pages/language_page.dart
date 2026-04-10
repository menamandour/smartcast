import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/core/providers/locale_provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = localeProvider.locale.languageCode;

  void _saveLanguage() async {
    await localeProvider.setLocale(Locale(_selectedLanguage));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).changeLanguage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.language),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile<String>(
              value: 'en',
              groupValue: _selectedLanguage,
              title: const Text('English'),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value ?? 'en';
                });
              },
            ),
            RadioListTile<String>(
              value: 'ar',
              groupValue: _selectedLanguage,
              title: const Text('العربية'),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value ?? 'ar';
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saveLanguage,
                child: Text(loc.changeLanguage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
