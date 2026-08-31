import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/image/common_image.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/utils/constants/app_colors.dart';
import 'package:getx_template/utils/constants/app_string.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';
import 'package:getx_template/features/onboarding/presentation/controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return CommonScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with Skip Button
            Obx(() {
              final isLast = controller.currentIndex.value == 2;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IgnorePointer(
                      ignoring: isLast,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isLast ? 0.0 : 1.0,
                        child: TextButton(
                          onPressed: controller.finish,
                          child: CommonText(
                            AppString.skip,
                            fontWeight: FontWeight.w500,
                            color: context.appColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // Slides (3 Page Views)
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.updateIndex,
                children: const [
                  _OnboardingPage(
                    icon: "assets/images/onboarding_one.png",
                    title: AppString.fastDevelopment,
                    description: AppString.fastDevelopmentDesc,
                    colors: [Color(0xFFFF8C00), Color(0xFFFF3E00)],
                  ),
                  _OnboardingPage(
                    icon: "assets/images/onboarding_two.png",
                    title: AppString.robustNetworking,
                    description: AppString.robustNetworkingDesc,
                    colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                  ),
                  _OnboardingPage(
                    icon: "assets/images/onboarding_three.png",
                    title: AppString.beautifulUi,
                    description: AppString.beautifulUiDesc,
                    colors: [Color(0xFF9D50BB), Color(0xFF6E48AA)],
                  ),
                ],
              ),
            ),

            // Bottom Actions (Indicator and Button)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  // Page Indicators
                  Obx(
                    () => _buildIndicators(
                      context,
                      controller.currentIndex.value,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Next / Explore Now Button
                  Obx(() {
                    final isLast = controller.currentIndex.value == 2;
                    return CommonButton(
                      borderColor: context.appColors.white,
                      borderWidth: 1,
                      buttonColor: context.appColors.primary,
                      titleText: isLast ? AppString.exploreNow : AppString.next,
                      buttonWidth: double.maxFinite,
                      onTap: isLast ? controller.finish : controller.nextPage,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicators(BuildContext context, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isSelected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: isSelected ? 24.w : 8.w,
          decoration: BoxDecoration(
            color: isSelected
                ? context.appColors.primary
                : context.appColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final List<Color> colors;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonImage(src: icon),

          SizedBox(height: 48.h),
          CommonText(
            title,
            // Using standard titleLarge for slide header
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          CommonText(
            description,
            color: context.appColors.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
