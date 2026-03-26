import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appName),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showMenu(context),
          ),
        ],
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthAuthenticatedState) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${loc.welcome}, ${state.user.fullName}!',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(color: AppColors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                loc.monitorYourHealth,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 24),

                // Vital Signs Section
                Text(
                  loc.vitalSigns,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                BlocBuilder<HealthBloc, HealthState>(
                  builder: (context, state) {
                    if (state is HealthDataHistoryState &&
                        state.healthDataList.isNotEmpty) {
                      final latest = state.healthDataList.first;
                      return GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: [
                          _buildVitalCard(
                            title: loc.pressure,
                            value: '${latest.pressure.toStringAsFixed(1)} mmHg',
                            icon: Icons.favorite,
                          ),
                          _buildVitalCard(
                            title: loc.temperature,
                            value: '${latest.temperature.toStringAsFixed(1)}°C',
                            icon: Icons.thermostat,
                          ),
                          _buildVitalCard(
                            title: loc.circulation,
                            value: '${latest.circulation.toStringAsFixed(1)}%',
                            icon: Icons.favorite_border,
                          ),
                          _buildVitalCard(
                            title: loc.movementTracking,
                            value:
                                '${latest.movementTracking.toStringAsFixed(1)}%',
                            icon: Icons.directions_walk,
                          ),
                        ],
                      );
                    } else if (state is HealthLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Center(child: Text(loc.noData));
                  },
                ),
                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/health'),
                        icon: const Icon(Icons.add),
                        label: Text(loc.recordHealthData),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _loadHealthData,
                        icon: const Icon(Icons.refresh),
                        label: Text(loc.viewHistory),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVitalCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.greyLighter,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final loc = AppLocalizations.of(context);
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000, 50, 0, 0),
      items: [
        PopupMenuItem(
          onTap: () => Navigator.pushNamed(context, '/health'),
          child: Row(
            children: [
              const Icon(Icons.favorite),
              const SizedBox(width: 8),
              Text(loc.healthData),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            context.read<AuthBloc>().add(const AuthLogoutEvent());
          },
          child: Row(
            children: [
              const Icon(Icons.logout),
              const SizedBox(width: 8),
              Text(loc.logout),
            ],
          ),
        ),
      ],
    );
  }
}
