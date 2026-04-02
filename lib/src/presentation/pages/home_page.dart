import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/config/routes/app_routes.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';
import 'package:smartcast/src/presentation/bloc/health_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadHealthData();
  }

  void _loadHealthData() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticatedState) {
      context.read<HealthBloc>().add(
            GetHealthDataHistoryEvent(userId: authState.user.id),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: _buildDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final name = state is AuthAuthenticatedState
                ? state.user.fullName
                : 'Guest';
            return Text(
              '${loc.welcomeBack} $name',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticatedState) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        child: RefreshIndicator(
          onRefresh: () async => _loadHealthData(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/homeScreenImage1.jpg',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  loc.appName,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMetricCard(
                  title: loc.pressure,
                  value: '38',
                  unit: 'mmHg',
                  status: loc.normal,
                  statusColor: AppColors.success,
                  icon: Icons.show_chart,
                ),
                const SizedBox(height: 12),
                _buildMetricCard(
                  title: loc.temperature,
                  value: '38.6',
                  unit: '°C',
                  status: loc.high,
                  statusColor: AppColors.error,
                  icon: Icons.thermostat,
                ),
                const SizedBox(height: 12),
                _buildMetricCard(
                  title: loc.humidity,
                  value: '45',
                  unit: '%',
                  status: '',
                  statusColor: AppColors.primary,
                  icon: Icons.opacity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Drawer(
      child: Container(
        color: const Color(0xFF0A0E21),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isAr) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.show_chart, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 12),
                ],
                Column(
                  crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.smartCastAr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Smart Cast',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                if (isAr) ...[
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.show_chart, color: Colors.white, size: 28),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 40),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final name = state is AuthAuthenticatedState ? state.user.fullName : 'User';
                return _buildDrawerItem(name, Icons.person_outline, isAr);
              },
            ),
            const Divider(color: Colors.white12, height: 40),
            _buildDrawerItem(loc.home, Icons.home_outlined, isAr, onTap: () => Navigator.of(context).pop()),
            _buildDrawerItem(loc.analytics, Icons.bar_chart, isAr),
            _buildDrawerItem(loc.patients, Icons.person_outline, isAr),
            _buildDrawerItem(loc.devices, Icons.settings_input_component_outlined, isAr, onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppRoutes.devices);
            }),
            _buildDrawerItem(loc.settings, Icons.settings_outlined, isAr),
            const Spacer(),
            _buildDrawerItem(loc.logout, Icons.logout, isAr, onTap: () {
              context.read<AuthBloc>().add(const AuthLogoutEvent());
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, bool isAr, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isAr) ...[
              Icon(icon, color: Colors.white, size: 26),
              const SizedBox(width: 16),
            ],
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isAr) ...[
              const SizedBox(width: 16),
              Icon(icon, color: Colors.white, size: 26),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String unit,
    required String status,
    required Color statusColor,
    required IconData icon,
  }) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isAr) Icon(
            icon,
            size: 40,
            color: title == loc.temperature
                ? AppColors.error
                : AppColors.primary,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: title == loc.temperature
                        ? AppColors.error
                        : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (isAr) Text(
                      unit,
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (isAr) const SizedBox(width: 6),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!isAr) const SizedBox(width: 6),
                    if (!isAr) Text(
                      unit,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                if (status.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isAr) Icon(Icons.circle, size: 10, color: statusColor),
                      if (!isAr) const SizedBox(width: 4),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 16,
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isAr) const SizedBox(width: 4),
                      if (isAr) Icon(Icons.circle, size: 10, color: statusColor),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (!isAr) Icon(
            icon,
            size: 40,
            color: title == loc.temperature
                ? AppColors.error
                : AppColors.primary,
          ),
        ],
      ),
    );
  }
}
