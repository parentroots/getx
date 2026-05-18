import 'package:flutter/material.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/theme/app_spacing.dart';

class UpdateRequiredScreen extends StatelessWidget {
  const UpdateRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: const CommonTopBar(title: 'Update required', showBack: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.system_update_alt_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Update required',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Your app can route users here when a minimum supported version is enforced.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          CommonButton(label: 'Open store', onPressed: () {}),
        ],
      ),
    );
  }
}
