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
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    const Color inputBackgroundColor = Color(0xFFD6D6D6);
    const Color buttonColor = Color(0xFF074FAC);

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.show_chart,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                loc.createNewAccount,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                loc.registerSubtitle,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Input Fields
              _buildTextField(_fullNameController, loc.fullName, isAr, inputBackgroundColor),
              const SizedBox(height: 16),
              _buildTextField(_emailController, loc.email, isAr, inputBackgroundColor, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField(_passwordController, loc.password, isAr, inputBackgroundColor, obscureText: true),
              const SizedBox(height: 16),
              _buildTextField(_confirmPasswordController, loc.confirmPassword, isAr, inputBackgroundColor, obscureText: true),
              const SizedBox(height: 32),

              // Register Button
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoadingState;

                  return SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              loc.signUp,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isAr ? "لدي حساب بالفعل؟" : "Already have an account? ",
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    ),
                    child: Text(
                      loc.login,
                      style: const TextStyle(
                        color: Color(0xFF074FAC),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    bool isAr,
    Color backgroundColor, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: isAr ? TextAlign.right : TextAlign.left,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 18),
        filled: true,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
