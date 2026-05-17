import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_app_bar.dart';
import 'package:getx_template/component/app_button.dart';
import 'package:getx_template/component/app_text_field.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/features/profile/screen/controller/profile_controller.dart';

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
