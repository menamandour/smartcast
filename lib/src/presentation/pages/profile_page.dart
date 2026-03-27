import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticatedState) {
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String userName = 'Guest';
              String phone = '010000000';
              
              if (state is AuthAuthenticatedState) {
                userName = state.user.fullName;
                phone = state.user.phone ?? '010000000';
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    // Header "profile"
                    Row(
                      mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isAr) ...[
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF1E40AF), width: 2),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: Color(0xFF1E40AF),
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Text(
                          loc.profile,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isAr) ...[
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF1E40AF), width: 2),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: Color(0xFF1E40AF),
                              size: 28,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 32),

                    // User Info Row
                    Row(
                      mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isAr) ...[
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFB9C6D9),
                          ),
                          const SizedBox(width: 16),
                        ],
                        if (isAr) IconButton(
                          icon: const Icon(Icons.edit_note, color: Color(0xFF1E40AF), size: 32),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${loc.welcomeBack} $userName',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                phone,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isAr) IconButton(
                          icon: const Icon(Icons.edit_note, color: Color(0xFF1E40AF), size: 32),
                          onPressed: () {},
                        ),
                        if (isAr) ...[
                          const SizedBox(width: 16),
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFB9C6D9),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Settings Sections
                    _buildSectionTitle(loc.accountSetting, isAr),
                    _buildSettingItem(Icons.location_on_outlined, loc.address, isAr),
                    _buildSettingItem(Icons.history, loc.history, isAr),
                    
                    const SizedBox(height: 24),
                    _buildSectionTitle(loc.appSetting, isAr),
                    _buildSettingItem(Icons.badge_outlined, loc.language, isAr),
                    _buildSettingItem(Icons.notifications_none_outlined, loc.notification, isAr),
                    
                    const SizedBox(height: 24),
                    _buildSectionTitle(loc.support, isAr),
                    _buildSettingItem(Icons.help_outline, loc.helpCenter, isAr),

                    const SizedBox(height: 40),

                    // Logout Button
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(const AuthLogoutEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E60FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            loc.logout,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isAr) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, bool isAr) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isAr) ...[
            Icon(icon, color: Colors.black87, size: 28),
            const SizedBox(width: 16),
          ],
          if (isAr) const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black54),
          if (isAr) const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (!isAr) const Spacer(),
          if (!isAr) const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
          if (isAr) ...[
            const SizedBox(width: 16),
            Icon(icon, color: Colors.black87, size: 28),
          ],
        ],
      ),
    );
  }
}
