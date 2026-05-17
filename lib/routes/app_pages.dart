import 'package:get/get.dart';
import 'package:getx_template/modules/auth/bindings/auth_binding.dart';
import 'package:getx_template/modules/auth/views/auth_welcome_screen.dart';
import 'package:getx_template/modules/auth/views/forgot_password_screen.dart';
import 'package:getx_template/modules/auth/views/login_screen.dart';
import 'package:getx_template/modules/auth/views/otp_verification_screen.dart';
import 'package:getx_template/modules/auth/views/register_screen.dart';
import 'package:getx_template/modules/home/bindings/home_binding.dart';
import 'package:getx_template/modules/home/views/home_screen.dart';
import 'package:getx_template/modules/notifications/bindings/notifications_binding.dart';
import 'package:getx_template/modules/notifications/views/notification_screen.dart';
import 'package:getx_template/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:getx_template/modules/onboarding/views/onboarding_screen.dart';
import 'package:getx_template/modules/profile/bindings/profile_binding.dart';
import 'package:getx_template/modules/profile/views/edit_profile_screen.dart';
import 'package:getx_template/modules/profile/views/profile_screen.dart';
import 'package:getx_template/modules/settings/bindings/settings_binding.dart';
import 'package:getx_template/modules/settings/views/settings_screen.dart';
import 'package:getx_template/modules/splash/bindings/splash_binding.dart';
import 'package:getx_template/modules/splash/views/splash_screen.dart';
import 'package:getx_template/modules/system/bindings/system_binding.dart';
import 'package:getx_template/modules/system/views/error_screen.dart';
import 'package:getx_template/modules/system/views/maintenance_screen.dart';
import 'package:getx_template/modules/system/views/no_internet_screen.dart';
import 'package:getx_template/modules/system/views/update_required_screen.dart';
import 'package:getx_template/routes/app_routes.dart';

abstract final class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.authWelcome,
      page: () => const AuthWelcomeScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.noInternet,
      page: () => const NoInternetScreen(),
      binding: SystemBinding(),
    ),
    GetPage(
      name: AppRoutes.updateRequired,
      page: () => const UpdateRequiredScreen(),
      binding: SystemBinding(),
    ),
    GetPage(
      name: AppRoutes.maintenance,
      page: () => const MaintenanceScreen(),
      binding: SystemBinding(),
    ),
    GetPage(
      name: AppRoutes.error,
      page: () => const ErrorScreen(),
      binding: SystemBinding(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.error,
    page: () => const ErrorScreen(
      title: 'Page not found',
      message: 'The route you opened is not registered in this app.',
    ),
    binding: SystemBinding(),
  );
}
