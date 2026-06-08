import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/common_card.dart';
import 'package:getx_template/component/common_image.dart';
import 'package:getx_template/component/common_phone_text_field.dart';
import 'package:getx_template/component/common_rating_bar.dart';
import 'package:getx_template/component/common_search_bar.dart';
import 'package:getx_template/component/common_switch.dart';
import 'package:getx_template/component/common_tab_bar.dart';
import 'package:getx_template/component/common_text_field.dart';
import 'package:getx_template/component/layout/common_bottom_nav_bar.dart';
import 'package:getx_template/component/layout/common_list_view.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/loading/common_shimmer_card.dart';
import 'package:getx_template/component/loading/loading_overlay.dart';
import 'package:getx_template/component/loading/shimmer_box.dart';
import 'package:getx_template/component/pickers/common_country_picker.dart';
import 'package:getx_template/component/pickers/common_date_picker.dart';
import 'package:getx_template/core/constants/app_assets.dart';
import 'package:getx_template/core/utils/date_formatter.dart';
import 'package:getx_template/core/utils/screen_extensions.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return CommonScaffold(
      bottomNavigationBar: CommonBottomNavBar(),
      appBar: const CommonAppBar(backgroundColor: Colors.blue, title: 'Log in'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonButton(
              buttonWidth: double.maxFinite,
              isLoading: true,
              titleText: "Button",
              onTap: () {},
            ),

            16.height,

            CommonText(variant: TextVariant.title, "This Is CommonText"),
            10.height,
            CommonCard(
              elevation: 5,
              borderRadius: 5,
              borderWidth: 1,
              child: Column(children: [CommonText("This Is Common Card")]),
            ),
            16.height,

            CommonPhoneTextField(
              borderRadius: 4,
              initialCountryCode: 'bd',
              controller: controller.phoneController,
            ),

            24.height,
            CommonText(variant: TextVariant.title, "Rating Bar Demos"),
            12.height,

            CommonCard(
              elevation: 2,
              borderRadius: 8,
              borderWidth: 1,
              borderColor: Colors.grey.shade200,
              child: Column(
                children: [
                  Obx(
                    () => CommonText(
                      "Your Rating: ${controller.appRating.value.toStringAsFixed(1)}",
                      variant: TextVariant.body,
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
                ],
              ),
            ),

            16.height,
            CommonText(variant: TextVariant.title, "Search Bar Demo"),
            12.height,
            CommonSearchBar(
              backgroundColor: Colors.white,
              hintText: "Type to search (400ms debounce)...",
              onChanged: (query) {
                // Auto-debounced callback
                debugPrint("Debounced Search Query: $query");
              },
            ),

            Obx(
              () => CommonSwitch(
                onChanged: (value) {
                  controller.isSwitchOn.value = value;
                },
                value: controller.isSwitchOn.value,
              ),
            ),

            Obx(
              () => CommonTabBar(

                tabs: controller.tabList,
                selectedIndex: controller.currentTabIndex.value,
                onTabChanged: controller.onTabChanged,
              ),
            ),


            CommonTextField(
              hint: "Search Here",

            ),
            
            // CommonShimmerList(
            //
            //   itemCount: 10,
            //
            // ),
            
            
            LoadingOverlay(isLoading: true, child: CommonText("Hello")),

            ShimmerBox(

            ),

            24.height,
            CommonText(variant: TextVariant.title, "Paginated List View Demo"),
            12.height,
            CommonCard(
              elevation: 2,
              borderRadius: 12,
              borderWidth: 1,
              borderColor: Colors.grey.shade200,
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 220.h,
                child: CommonListView<String>(
                  onLoadPage: controller.loadPageData,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  separatorWidget: const Divider(),
                  itemBuilder: (context, item, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 16.r,
                        child: Text((index + 1).toString()),
                      ),
                      title: CommonText(item, variant: TextVariant.body),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),

            24.height,
            CommonText(variant: TextVariant.title, "Country Picker Demo"),
            12.height,
            Obx(() {
              final selected = controller.selectedCountry.value;
              return CommonCard(
                elevation: 2,
                borderRadius: 12,
                borderWidth: 1,
                borderColor: Colors.grey.shade200,
                onTap: () async {
                  final result = await CommonCountryPicker.show(
                    context: context,
                    selectedCountryCode: selected?.code,
                  );
                  if (result != null) {
                    controller.selectedCountry.value = result;
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    children: [
                      if (selected != null) ...[
                        Text(
                          selected.flagEmoji,
                          style: TextStyle(fontSize: 28.sp),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                selected.name,
                                variant: TextVariant.body,
                                weight: TextWeight.bold,
                              ),
                              SizedBox(height: 4.h),
                              CommonText(
                                "Code: ${selected.code}  |  Dial Code: ${selected.dialCode}",
                                variant: TextVariant.caption,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        const Icon(Icons.public, color: Colors.grey),
                        SizedBox(width: 16.w),
                        const Expanded(
                          child: CommonText(
                            "Tap to Select Country",
                            variant: TextVariant.body,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              );
            }),

            24.height,
            CommonText(variant: TextVariant.title, "Date Picker Demo"),
            12.height,
            Obx(() {
              final selected = controller.selectedDate.value;
              return CommonCard(
                elevation: 2,
                borderRadius: 12,
                borderWidth: 1,
                borderColor: Colors.grey.shade200,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_rounded, color: Colors.grey),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              selected != null
                                  ? DateFormatter.date(selected)
                                  : "Tap to Select Date",
                              variant: TextVariant.body,
                              weight: selected != null ? TextWeight.bold : TextWeight.regular,
                              color: selected != null ? null : Colors.grey,
                            ),
                            if (selected != null) ...[
                              SizedBox(height: 4.h),
                              CommonText(
                                "Raw API format: ${DateFormatter.apiDate(selected)}",
                                variant: TextVariant.caption,
                                color: Colors.grey,
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
