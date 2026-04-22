import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';
import 'package:smartcast/src/presentation/pages/register_page.dart';
import 'package:smartcast/src/core/providers/locale_provider.dart';
import 'package:smartcast/src/core/providers/settings_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    context.read<AuthBloc>().add(
      AuthLoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
        rememberMe: _rememberMe,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: _buildAuthDrawer(loc, isAr),
      appBar: AppBar(
        elevation: 0, 
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.grey, size: 32),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticatedState) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Logo
              Center(
                child: Image.asset(
                  'assets/images/smart_cast_logo.png',
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Center(
                child: Text(
                  loc.appName,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  loc.appSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),

              // Email Field
              Text(loc.email, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: isAr ? TextAlign.right : TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'example@email.com',
                  suffixIcon: const Icon(Icons.check, color: AppColors.success),
                ),
              ),
              const SizedBox(height: 24),

              // Password Field
              Text(loc.password, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textAlign: isAr ? TextAlign.right : TextAlign.left,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() => _rememberMe = value ?? false);
                        },
                        activeColor: AppColors.primary,
                      ),
                      Text(loc.rememberMe),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: Text(
                      loc.forgotPassword,
                      style: const TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Login Button
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoadingState;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(loc.login),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Sign Up Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(loc.dontHaveAccount),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      ),
                      child: Text(
                        loc.signUp,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthDrawer(AppLocalizations loc, bool isAr) {
    return Drawer(
      child: Container(
        color: const Color(0xFFB9C6D9).withOpacity(0.5),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                loc.translate('drawer.select'),
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              
              _buildDrawerExpansionTile(
                title: loc.translate('drawer.changeLanguage'),
                isAr: isAr,
                children: [
                  ListTile(
                    title: const Text('English'),
                    onTap: () {
                      localeProvider.setLocale(const Locale('en'));
                      Navigator.of(context).pop();
                    },
                    selected: localeProvider.locale.languageCode == 'en',
                  ),
                  ListTile(
                    title: const Text('العربية'),
                    onTap: () {
                      localeProvider.setLocale(const Locale('ar'));
                      Navigator.of(context).pop();
                    },
                    selected: localeProvider.locale.languageCode == 'ar',
                  ),
                ],
              ),
              _buildDrawerExpansionTile(
                title: loc.translate('drawer.changeFont'),
                isAr: isAr,
                children: [
                  ListTile(
                    title: const Text('Inter'),
                    onTap: () {
                      settingsProvider.setFontFamily('Inter');
                      Navigator.of(context).pop();
                    },
                    selected: settingsProvider.fontFamily == 'Inter',
                  ),
                  ListTile(
                    title: const Text('Tajawal'),
                    onTap: () {
                      settingsProvider.setFontFamily('Tajawal');
                      Navigator.of(context).pop();
                    },
                    selected: settingsProvider.fontFamily == 'Tajawal',
                  ),
                ],
              ),
              _buildDrawerExpansionTile(
                title: loc.translate('drawer.brightnessLevel'),
                isAr: isAr,
                children: [
                  ListTile(
                    title: const Text('Light'),
                    onTap: () {
                      settingsProvider.setThemeMode(ThemeMode.light);
                      Navigator.of(context).pop();
                    },
                    selected: settingsProvider.themeMode == ThemeMode.light,
                  ),
                  ListTile(
                    title: const Text('Dark'),
                    onTap: () {
                      settingsProvider.setThemeMode(ThemeMode.dark);
                      Navigator.of(context).pop();
                    },
                    selected: settingsProvider.themeMode == ThemeMode.dark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerExpansionTile({required String title, required bool isAr, required List<Widget> children}) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          title,
          textAlign: isAr ? TextAlign.right : TextAlign.left,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        trailing: const Icon(Icons.arrow_drop_down, color: Colors.black),
        children: children,
      ),
    );
  }
}
