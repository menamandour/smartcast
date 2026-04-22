import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcast/src/config/routes/app_routes.dart';
import 'package:smartcast/src/config/service_locator.dart';
import 'package:smartcast/src/domain/repositories/auth_repository.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final authRepository = sl<AuthRepository>();
    final hasSeenOnboarding = await authRepository.hasSeenOnboarding();

    // Check auth status
    final authBloc = context.read<AuthBloc>();
    authBloc.add(const AuthCheckStatusEvent());

    // Wait for the status check to complete
    await for (final state in authBloc.stream) {
      if (state is AuthAuthenticatedState) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        return;
      } else if (state is AuthUnauthenticatedState || state is AuthErrorState) {
        if (hasSeenOnboarding) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
        }
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
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
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
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
