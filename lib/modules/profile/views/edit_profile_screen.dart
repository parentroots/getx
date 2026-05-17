import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/modules/profile/controllers/profile_controller.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/app_button.dart';
import 'package:getx_template/widgets/app_text_field.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Edit profile'),
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            AppTextField(
              label: 'Name',
              controller: controller.nameController,
              validator: (value) => Validators.required(value, field: 'Name'),
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(label: 'Save changes', onPressed: controller.saveProfile),
          ],
        ),
      ),
    );
  }
}
