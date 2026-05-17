import 'package:flutter/material.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Maintenance', showBack: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.engineering_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'We will be back soon',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Route here when remote config or your backend marks the app as temporarily unavailable.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
