import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/text_field/common_text_field.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';
import 'package:getx_template/utils/extensions/screen_extensions.dart';
import 'package:getx_template/utils/helper/validators.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Change Password",
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.changePasswordFormKey,
          child: Column(
            children: [
              60.height,

              CommonTextField(
                hint: "Enter Current Password",
                controller:
                    controller.currentPasswordTEController,
                obscureText: true,
                validator: (value) => Validators.required(
                  value,
                  field: 'Current Password',
                ),
              ),

              10.height,

              CommonTextField(
                hint: "Enter New Password",
                controller:
                    controller.newPasswordTEController,
                obscureText: true,
                validator: Validators.password,
              ),
              10.height,

              CommonTextField(
                hint: "Confirm New Password",
                controller: controller
                    .confirmNewPasswordTEController,
                obscureText: true,
                validator: (value) {
                  final requiredError = Validators.required(
                    value,
                    field: 'Confirm Password',
                  );
                  if (requiredError != null)
                    return requiredError;
                  if (value !=
                      controller
                          .newPasswordTEController
                          .text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              30.height,

              Obx(
                () => CommonButton(
                  buttonWidth: double.maxFinite,
                  isLoading: controller.isLoading.value,
                  onTap: () {
                    controller.changePassword();
                  },
                  titleText: 'Change Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
