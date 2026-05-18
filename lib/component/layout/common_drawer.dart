import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/core/routing/app_routes.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  void _navigateTo(String route) {
    // If we're already on that route, just close the drawer
    if (Get.currentRoute == route) {
      Get.back();
      return;
    }
    // Close drawer and navigate
    Get.back();
    Get.offAllNamed(route);
  }

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context);
    Get.back(); // Close drawer first

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CommonText(
          'Logout',
          variant: TextVariant.title,
          weight: TextWeight.bold,
        ),
        content: CommonText(
          'Are you sure you want to log out of your account?',
          variant: TextVariant.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: CommonText(
              'Cancel',
              variant: TextVariant.body,
              color: Colors.grey,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Clean navigation stack and head to welcome/login screen
              Get.offAllNamed(AppRoutes.authWelcome);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: CommonText(
              'Logout',
              variant: TextVariant.body,
              color: Colors.white,
              weight: TextWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: theme.brightness == Brightness.dark
          ? theme.colorScheme.surface
          : Colors.white,
      elevation: 0,
      width: 280.w,
      child: Column(
        children: [
          // Header - Premium User Profile Card
          _buildProfileHeader(context, isDark),

          // Drawer Body - Scrolling Menu List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              children: [
                _buildMenuItem(
                  context: context,
                  icon: Icons.home_rounded,
                  label: 'Home',
                  route: AppRoutes.home,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.person_rounded,
                  label: 'My Profile',
                  route: AppRoutes.profile,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  route: AppRoutes.settings,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.notifications_rounded,
                  label: 'Notifications',
                  route: AppRoutes.notifications,
                ),
                Divider(height: 32.h, thickness: 1.r, color: theme.dividerColor),
                
                // Theme Toggle Tile
                _buildThemeToggle(context, isDark),
              ],
            ),
          ),

          // Drawer Footer - Logout
          SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ListTile(
                onTap: () => _showLogoutDialog(context),
                leading: Icon(
                  Icons.logout_rounded,
                  color: theme.colorScheme.error,
                  size: 22.r,
                ),
                title: CommonText(
                  'Logout',
                  variant: TextVariant.body,
                  weight: TextWeight.medium,
                  color: theme.colorScheme.error,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                tileColor: theme.colorScheme.error.withValues(alpha: 0.08),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : theme.primaryColor.withValues(alpha: 0.04),
        border: Border(
          bottom: BorderSide(color: theme.dividerColor, width: 1.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: theme.primaryColor.withValues(alpha: 0.15),
                child: Icon(Icons.person_rounded, size: 28.r, color: theme.primaryColor),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CommonText(
                  'Starter PRO',
                  variant: TextVariant.caption,
                  weight: TextWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CommonText(
            'Md. Ibrahim Khalil',
            variant: TextVariant.title,
            weight: TextWeight.bold,
          ),
          SizedBox(height: 4.h),
          CommonText(
            'ibrahim@parentroots.com',
            variant: TextVariant.caption,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
  }) {
    final theme = Theme.of(context);
    final isSelected = Get.currentRoute == route;

    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: ListTile(
        onTap: () => _navigateTo(route),
        leading: Icon(
          icon,
          color: isSelected ? theme.primaryColor : Colors.grey.shade600,
          size: 22.r,
        ),
        title: CommonText(
          label,
          variant: TextVariant.body,
          weight: isSelected ? TextWeight.bold : TextWeight.medium,
          color: isSelected ? theme.primaryColor : null,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        selected: isSelected,
        selectedTileColor: theme.primaryColor.withValues(alpha: 0.08),
        splashColor: theme.primaryColor.withValues(alpha: 0.05),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: SwitchListTile(
        value: isDark,
        onChanged: (bool val) {
          Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
        },
        secondary: Icon(
          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          color: theme.primaryColor,
          size: 22.r,
        ),
        title: CommonText(
          isDark ? 'Dark Mode' : 'Light Mode',
          variant: TextVariant.body,
          weight: TextWeight.medium,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        activeColor: theme.primaryColor,
      ),
    );
  }
}
