import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcast/src/config/routes/app_routes.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    
    final List<OnboardingData> _onboardingScreens = [
      OnboardingData(
        title: loc.translate('onboarding.screen1Title'),
        description: loc.translate('onboarding.screen1Subtitle'),
        image: "assets/images/page1Image.jpg",
      ),
      OnboardingData(
        title: loc.translate('onboarding.screen2Title'),
        description: loc.translate('onboarding.screen2Subtitle'),
        image: "assets/images/page2image.jpg",
      ),
      OnboardingData(
        title: loc.translate('onboarding.screen3Title'),
        description: loc.translate('onboarding.screen3Subtitle'),
        image: "assets/images/page3image.jpg",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingScreens.length,
            itemBuilder: (context, index) {
              return _buildPage(_onboardingScreens[index]);
            },
          ),
          // Navigation & Indicators
          Positioned(
            bottom: 40,
            left: 31,
            right: 31,
            child: Column(
              children: [
                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingScreens.length,
                    (index) => _buildDot(index),
                  ),
                ),
                const SizedBox(height: 40),
                // Primary Button
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _onboardingScreens.length - 1) {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF105EEE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage == _onboardingScreens.length - 1 ? loc.onboardingGetStarted : loc.next,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Secondary Button / Skip
                if (_currentPage != _onboardingScreens.length - 1)
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFAEAEB2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        loc.skip,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Column(
      children: [
        // Image with curved bottom
        ClipPath(
          clipper: CustomBottomClipper(),
          child: Container(
            height: 405,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F2F7),
            ),
            child: Image.asset(
              data.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.image, size: 100, color: Colors.grey)),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 31),
          child: Column(
            children: [
              // Use FittedBox or constrained sizes for flexible text
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100),
                child: SingleChildScrollView(
                  child: Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 24, // Slightly smaller base to allow more text
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Flexible container for description
              SizedBox(
                height: 140, // Fixed height area for description to prevent button overlap
                child: SingleChildScrollView(
                  child: Text(
                    data.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8E8E93),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      height: 12,
      width: 13,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF105EEE) : const Color(0xFF92979F),
        shape: BoxShape.circle,
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({required this.title, required this.description, required this.image});
}

class CustomBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 350);
    path.quadraticBezierTo(0, 405, 55, 405);
    path.lineTo(size.width - 55, 405);
    path.quadraticBezierTo(size.width, 405, size.width, 350);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
