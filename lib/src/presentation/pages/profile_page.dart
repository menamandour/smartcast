import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/config/routes/app_routes.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticatedState) {
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
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
                          loc.translate('profile.profile'),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.headlineMedium?.color,
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
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.editProfile);
                          },
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${loc.welcomeBack} $userName',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: theme.textTheme.headlineMedium?.color,
                                ),
                              ),
                              Text(
                                phone,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: theme.textTheme.bodyMedium?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isAr) IconButton(
                          icon: const Icon(Icons.edit_note, color: Color(0xFF1E40AF), size: 32),
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutes.editProfile);
                          },
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
                    _buildSectionTitle(loc.translate('profile.accountSetting'), isAr, theme),
                    _buildSettingItem(
                      icon: Icons.location_on_outlined,
                      title: loc.translate('profile.address'),
                      isAr: isAr,
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.address),
                      theme: theme,
                    ),
                    _buildSettingItem(
                      icon: Icons.history,
                      title: loc.translate('profile.history'),
                      isAr: isAr,
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.history),
                      theme: theme,
                    ),
                    
                    const SizedBox(height: 24),
                    _buildSectionTitle(loc.translate('profile.appSetting'), isAr, theme),
                    _buildSettingItem(
                      icon: Icons.badge_outlined,
                      title: loc.translate('profile.language'),
                      isAr: isAr,
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.language),
                      theme: theme,
                    ),
                    _buildSettingItem(
                      icon: Icons.notifications_none_outlined,
                      title: loc.translate('profile.notification'),
                      isAr: isAr,
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.notifications),
                      theme: theme,
                    ),
                    
                    const SizedBox(height: 24),
                    _buildSectionTitle(loc.translate('profile.support'), isAr, theme),
                    _buildSettingItem(
                      icon: Icons.help_outline,
                      title: loc.translate('profile.helpCenter'),
                      isAr: isAr,
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.helpCenter),
                      theme: theme,
                    ),

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
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            loc.logout,
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
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

  Widget _buildSectionTitle(String title, bool isAr, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.headlineSmall?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required bool isAr,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isAr) ...[
                Icon(icon, color: theme.iconTheme.color, size: 28),
                const SizedBox(width: 16),
              ],
              if (isAr) Icon(Icons.arrow_back_ios, size: 18, color: theme.iconTheme.color?.withOpacity(0.7)),
              if (isAr) const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              if (!isAr) const Spacer(),
              if (!isAr) Icon(Icons.arrow_forward_ios, size: 18, color: theme.iconTheme.color?.withOpacity(0.7)),
              if (isAr) ...[
                const SizedBox(width: 16),
                Icon(icon, color: theme.iconTheme.color, size: 28),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
