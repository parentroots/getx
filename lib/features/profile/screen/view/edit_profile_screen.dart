import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/common_text_field.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/features/profile/screen/controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return CommonScaffold(
      appBar: const CommonTopBar(title: 'Edit profile'),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          children: [
            CommonTextField(
              label: 'Name',
              controller: controller.nameController,
              validator: (value) => Validators.required(value, field: 'Name'),
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: AppSpacing.md.h),
            CommonTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: AppSpacing.lg.h),
            CommonButton(label: 'Save changes', onPressed: controller.saveProfile),
          ],
        ),
      ),
    );
  }
}
