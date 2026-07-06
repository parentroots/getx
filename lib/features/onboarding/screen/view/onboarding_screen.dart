import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/utils/constants/app_colors.dart';
import 'package:getx_template/features/onboarding/screen/controller/onboarding_controller.dart';

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
                          child: const CommonText(
                            'Skip',
                            variant: TextVariant.body,
                            weight: TextWeight.medium,
                            color: Colors.grey,
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
                    icon: Icons.rocket_launch_rounded,
                    title: "Fast Development",
                    description: "Pre-wired boilerplate with GetX, routing, dependency injection, and theme management ready to roll.",
                    colors: [Color(0xFFFF8C00), Color(0xFFFF3E00)],
                  ),
                  _OnboardingPage(
                    icon: Icons.cloud_sync_rounded,
                    title: "Robust Networking",
                    description: "Fully integrated Dio API client with status mapping, auto token refresh, and complete error handling.",
                    colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                  ),
                  _OnboardingPage(
                    icon: Icons.auto_awesome_rounded,
                    title: "Beautiful UI Components",
                    description: "Interactive pre-built widgets like animated buttons, indicators, loaders, and glassmorphic navigation bars.",
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
                  Obx(() => _buildIndicators(controller.currentIndex.value)),
                  SizedBox(height: 32.h),

                  // Next / Explore Now Button
                  Obx(() {
                    final isLast = controller.currentIndex.value == 2;
                    return CommonButton(
                      titleText: isLast ? "Explore Now" : "Next",
                      buttonWidth: double.maxFinite,
                      onTap: controller.nextPage,
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

  Widget _buildIndicators(int currentIndex) {
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
                ? AppColors.primary 
                : AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final IconData icon;
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(28.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.first.withOpacity(0.3),
                  blurRadius: 24.r,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 80.r,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 48.h),
          CommonText(
            title,
            variant: TextVariant.title,
            weight: TextWeight.bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          CommonText(
            description,
            variant: TextVariant.body,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
