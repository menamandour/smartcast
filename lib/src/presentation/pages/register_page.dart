import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';
import 'package:smartcast/src/presentation/pages/login_page.dart';
import 'package:smartcast/src/core/providers/locale_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    context.read<AuthBloc>().add(
      AuthRegisterEvent(
        email: _emailController.text,
        password: _passwordController.text,
        fullName: _fullNameController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
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
              // Title
              Text(
                loc.createNewAccount,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 32),

              // Full Name Field
              Text(loc.fullName, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: _fullNameController,
                textAlign: isAr ? TextAlign.right : TextAlign.left,
                decoration: const InputDecoration(hintText: 'John Doe'),
              ),
              const SizedBox(height: 24),

              // Email Field
              Text(loc.email, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: isAr ? TextAlign.right : TextAlign.left,
                decoration: const InputDecoration(
                  hintText: 'example@email.com',
                ),
              ),
              const SizedBox(height: 24),

              // Phone Field
              Text(loc.phone, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textAlign: isAr ? TextAlign.right : TextAlign.left,
                decoration: const InputDecoration(
                  hintText: '+1 (555) 123-4567',
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
              const SizedBox(height: 24),

              // Confirm Password Field
              Text(
                loc.confirmPassword,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscurePassword,
                textAlign: isAr ? TextAlign.right : TextAlign.left,
                decoration: const InputDecoration(hintText: '••••••••'),
              ),
              const SizedBox(height: 36),

              // Register Button
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoadingState;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleRegister,
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
                          : Text(loc.signUp),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Login Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(loc.alreadyHaveAccount),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      ),
                      child: Text(
                        loc.login,
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
                    onTap: () => localeProvider.setLocale(const Locale('en')),
                  ),
                  ListTile(
                    title: const Text('العربية'),
                    onTap: () => localeProvider.setLocale(const Locale('ar')),
                  ),
                ],
              ),
              _buildDrawerExpansionTile(
                title: loc.translate('drawer.changeFont'),
                isAr: isAr,
                children: const [
                  ListTile(title: Text('Default')),
                  ListTile(title: Text('Serif')),
                ],
              ),
              _buildDrawerExpansionTile(
                title: loc.translate('drawer.brightnessLevel'),
                isAr: isAr,
                children: const [
                  ListTile(title: Text('Light')),
                  ListTile(title: Text('Dark')),
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
