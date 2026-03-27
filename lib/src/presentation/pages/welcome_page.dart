import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcast/src/config/routes/app_routes.dart';
import 'package:smartcast/src/core/providers/locale_provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String _selectedLanguage = 'en';

  Future<void> _saveLanguageAndNavigate() async {
    await localeProvider.setLocale(Locale(_selectedLanguage));
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 31.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 52),
              // Logo
              Center(
                child: Image.asset(
                  'assets/images/smart_cast_logo.png',
                  width: 86,
                  height: 84,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 86,
                    height: 84,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tv, color: Color(0xFF105EEE), size: 40),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // Title
              Text(
                'SmartCast',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF074FAC),
                  letterSpacing: -0.5,
                ),
              ),
              const Spacer(flex: 2),
              // Subtitle / Question
              Text(
                _selectedLanguage == 'ar' ? 'اختر اللغة' : 'Choose the language',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),
              // English Button
              _buildLanguageButton(
                text: 'English',
                isSelected: _selectedLanguage == 'en',
                onPressed: () {
                  setState(() {
                    _selectedLanguage = 'en';
                  });
                },
              ),
              const SizedBox(height: 20),
              // Arabic Button
              _buildLanguageButton(
                text: 'العربية',
                isSelected: _selectedLanguage == 'ar',
                onPressed: () {
                  setState(() {
                    _selectedLanguage = 'ar';
                  });
                },
              ),
              const Spacer(flex: 3),
              // Bottom Next Action
              Align(
                alignment: _selectedLanguage == 'ar' ? Alignment.centerLeft : Alignment.centerRight,
                child: TextButton(
                  onPressed: _saveLanguageAndNavigate,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_selectedLanguage == 'ar') const Icon(Icons.arrow_back, color: Colors.black, size: 20),
                      Text(
                        _selectedLanguage == 'ar' ? 'التالي' : 'Next',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      if (_selectedLanguage == 'en') const Icon(Icons.arrow_forward, color: Colors.black, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required String text,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFF105EEE) : const Color(0xFFAEAEB2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
