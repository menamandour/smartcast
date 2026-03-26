import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';
import 'package:smartcast/src/presentation/bloc/auth_bloc.dart';
import 'package:smartcast/src/presentation/bloc/health_bloc.dart';

class HealthMonitoringPage extends StatefulWidget {
  const HealthMonitoringPage({Key? key}) : super(key: key);

  @override
  State<HealthMonitoringPage> createState() => _HealthMonitoringPageState();
}

class _HealthMonitoringPageState extends State<HealthMonitoringPage> {
  late TextEditingController _pressureController;
  late TextEditingController _temperatureController;
  late TextEditingController _circulationController;
  late TextEditingController _movementController;

  @override
  void initState() {
    super.initState();
    _pressureController = TextEditingController();
    _temperatureController = TextEditingController();
    _circulationController = TextEditingController();
    _movementController = TextEditingController();
  }

  @override
  void dispose() {
    _pressureController.dispose();
    _temperatureController.dispose();
    _circulationController.dispose();
    _movementController.dispose();
    super.dispose();
  }

  void _recordHealthData() {
    if (_pressureController.text.isEmpty ||
        _temperatureController.text.isEmpty ||
        _circulationController.text.isEmpty ||
        _movementController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticatedState) {
      context.read<HealthBloc>().add(
        RecordHealthDataEvent(
          userId: authState.user.id,
          pressure: double.parse(_pressureController.text),
          temperature: double.parse(_temperatureController.text),
          circulation: double.parse(_circulationController.text),
          movementTracking: double.parse(_movementController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.recordHealthData), elevation: 1),
      body: BlocListener<HealthBloc, HealthState>(
        listener: (context, state) {
          if (state is HealthDataRecordedState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(loc.loginSuccess)));
            Navigator.of(context).pop();
          } else if (state is HealthErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.greyLighter,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    loc.attachSmartSensor,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Pressure Field
              Text(loc.pressure, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: _pressureController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'mmHg',
                  suffixText: 'mmHg',
                ),
              ),
              const SizedBox(height: 24),

              // Temperature Field
              Text(
                loc.temperature,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _temperatureController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: '°C',
                  suffixText: '°C',
                ),
              ),
              const SizedBox(height: 24),

              // Circulation Field
              Text(
                loc.circulation,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _circulationController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: '%',
                  suffixText: '%',
                ),
              ),
              const SizedBox(height: 24),

              // Movement Tracking Field
              Text(
                loc.movementTracking,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _movementController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: '%',
                  suffixText: '%',
                ),
              ),
              const SizedBox(height: 48),

              // Submit Button
              BlocBuilder<HealthBloc, HealthState>(
                builder: (context, state) {
                  final isLoading = state is HealthLoadingState;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _recordHealthData,
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
                          : Text(loc.save),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
