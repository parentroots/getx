import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/common_card.dart';
import 'package:getx_template/component/common_phone_text_field.dart';
import 'package:getx_template/component/common_rating_bar.dart';
import 'package:getx_template/component/common_search_bar.dart';
import 'package:getx_template/component/common_switch.dart';
import 'package:getx_template/component/common_tab_bar.dart';
import 'package:getx_template/component/common_text_field.dart';
import 'package:getx_template/component/layout/common_list_view.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/loading/shimmer_box.dart';
import 'package:getx_template/component/pickers/common_country_picker.dart';
import 'package:getx_template/component/pickers/common_date_picker.dart';
import 'package:getx_template/core/utils/date_formatter.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';

class ComponentShowcaseScreen extends StatelessWidget {
  const ComponentShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CommonScaffold(
      appBar: const CommonAppBar(
        title: 'Widget Showcase',
        showBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              "UI component library and interactive playground",
              variant: TextVariant.header,
              weight: TextWeight.bold,
            ),
            SizedBox(height: 8.h),
            CommonText(
              "Explore standard and animated widgets in GetX boilerplate.",
              variant: TextVariant.body,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            SizedBox(height: 24.h),

            // Section 1: Buttons
            _buildSectionHeader("Core Buttons"),
            CommonCard(
              child: Column(
                children: [
                  CommonButton(
                    titleText: "Filled Button (Active)",
                    buttonWidth: double.maxFinite,
                    onTap: () {},
                  ),
                  SizedBox(height: 12.h),
                  CommonButton(
                    titleText: "Filled Button (Loading)",
                    buttonWidth: double.maxFinite,
                    isLoading: true,
                    onTap: () {},
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Outlined"),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Text Button"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Section 2: Core Inputs
            _buildSectionHeader("Form Fields & Inputs"),
            CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonTextField(
                    hint: "Enter your full name",
                    label: "Name Field",
                    prefixIcon: Icons.person_outline,
                  ),
                  SizedBox(height: 16.h),
                  const CommonTextField(
                    hint: "Enter secure password",
                    label: "Obscured Password Input",
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                  ),
                  SizedBox(height: 16.h),
                  CommonPhoneTextField(
                    label: "International Phone Input",
                    borderRadius: 12,
                    initialCountryCode: 'BD',
                    controller: controller.phoneController,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText("IOS-Style Elastomeric Switch:"),
                      Obx(
                        () => CommonSwitch(
                          value: controller.isSwitchOn.value,
                          onChanged: (val) => controller.isSwitchOn.value = val,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Section 3: Interactive Pickers
            _buildSectionHeader("Interactive Pickers"),
            CommonCard(
              child: Column(
                children: [
                  // Country Picker
                  Obx(() {
                    final selected = controller.selectedCountry.value;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Text(
                        selected?.flagEmoji ?? '🌍',
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      title: CommonText(
                        selected?.name ?? "Country Picker",
                        weight: selected != null ? TextWeight.bold : TextWeight.regular,
                      ),
                      subtitle: selected != null
                          ? CommonText(
                              "Code: ${selected.code} | Prefix: ${selected.dialCode}",
                              variant: TextVariant.caption,
                            )
                          : const CommonText("Tap to pick a country", variant: TextVariant.caption),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () async {
                        final result = await CommonCountryPicker.show(
                          context: context,
                          selectedCountryCode: selected?.code,
                        );
                        if (result != null) {
                          controller.selectedCountry.value = result;
                        }
                      },
                    );
                  }),
                  const Divider(),
                  // Date Picker
                  Obx(() {
                    final selected = controller.selectedDate.value;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today_rounded),
                      title: CommonText(
                        selected != null
                            ? DateFormatter.date(selected)
                            : "Date Picker",
                        weight: selected != null ? TextWeight.bold : TextWeight.regular,
                      ),
                      subtitle: selected != null
                          ? CommonText("API format: ${DateFormatter.apiDate(selected)}", variant: TextVariant.caption)
                          : const CommonText("Tap to pick a date", variant: TextVariant.caption),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () async {
                        final result = await CommonDatePicker.show(
                          context: context,
                          initialDate: selected ?? DateTime.now(),
                          maximumDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (result != null) {
                          controller.selectedDate.value = result;
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Section 4: Rating & Navigation
            _buildSectionHeader("Rating & Tab Control"),
            CommonCard(
              child: Column(
                children: [
                  Obx(
                    () => CommonText(
                      "Rating: ${controller.appRating.value.toStringAsFixed(1)} stars",
                      weight: TextWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => CommonRatingBar(
                      rating: controller.appRating.value,
                      size: 28.0,
                      allowHalf: true,
                      onRatingChanged: (rating) {
                        controller.appRating.value = rating;
                      },
                    ),
                  ),
                  const Divider(height: 24),
                  const CommonText("Dynamic TabBar Control:"),
                  SizedBox(height: 12.h),
                  Obx(
                    () => CommonTabBar(
                      tabs: controller.tabList,
                      selectedIndex: controller.currentTabIndex.value,
                      onTabChanged: controller.onTabChanged,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Section 5: Lists & Search
            _buildSectionHeader("Paginating Lists & Search"),
            CommonCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.r),
                    child: CommonSearchBar(
                      backgroundColor: isDark ? const Color(0xFF1F2937) : Colors.grey.shade100,
                      hintText: "Search items (debounced)...",
                      onChanged: (q) => debugPrint("Query: $q"),
                    ),
                  ),
                  SizedBox(
                    height: 180.h,
                    child: CommonListView<String>(
                      onLoadPage: controller.loadPageData,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      separatorWidget: const Divider(),
                      itemBuilder: (context, item, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: CircleAvatar(
                            radius: 12.r,
                            child: Text((index + 1).toString(), style: TextStyle(fontSize: 11.sp)),
                          ),
                          title: CommonText(item, variant: TextVariant.body),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Section 6: Loading Skeletal Indicators
            _buildSectionHeader("Shimmer & Overlay Skeletons"),
            CommonCard(
              child: Column(
                children: [
                  const CommonText("Shimmer Loading Box:"),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      ShimmerBox(

                          width: 80.w, height: 80.h, borderRadius: 12.r),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerBox(width: 120.w, height: 16.h, borderRadius: 4.r),
                            SizedBox(height: 10.h),
                            ShimmerBox(width: 180.w, height: 12.h, borderRadius: 4.r),
                            SizedBox(height: 10.h),
                            ShimmerBox(width: 90.w, height: 12.h, borderRadius: 4.r),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
      child: CommonText(
        title,
        variant: TextVariant.title,
        weight: TextWeight.bold,
      ),
    );
  }
}
