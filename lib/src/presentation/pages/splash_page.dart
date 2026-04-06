import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcast/src/config/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  void _navigateToNextPage() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/LoadingScreen.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.white,
                child: const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
              ),
            ),
          ),
          // Content Overlay
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                // "SmartCast" Text (from SVG)
                Text(
                  'SmartCast',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF105EEE),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),
                // Logo / Loading circles (Approximating the SVG shapes)
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Grey-ish Circle
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFAEAEB2),
                            width: 3,
                          ),
                        ),
                      ),
                      // Inner Blue Loading Indicator
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0088FF)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
