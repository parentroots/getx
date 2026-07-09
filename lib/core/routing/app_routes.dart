import 'package:get/get.dart';
import 'package:getx_template/features/auth/screen/view/auth_welcome_screen.dart';
import 'package:getx_template/features/auth/screen/view/change_password_screen.dart';
import 'package:getx_template/features/auth/screen/view/forgot_password_screen.dart';
import 'package:getx_template/features/auth/screen/view/login_screen.dart';
import 'package:getx_template/features/auth/screen/view/otp_verification_screen.dart';
import 'package:getx_template/features/auth/screen/view/register_screen.dart';
import 'package:getx_template/features/notifications/screen/view/notification_screen.dart';
import 'package:getx_template/features/onboarding/screen/view/onboarding_screen.dart';
import 'package:getx_template/features/profile/screen/view/edit_profile_screen.dart';
import 'package:getx_template/features/settings/screen/view/settings_screen.dart';
import 'package:getx_template/features/splash/screen/view/splash_screen.dart';
import 'package:getx_template/features/system/screen/view/error_screen.dart';
import 'package:getx_template/features/system/screen/view/maintenance_screen.dart';
import 'package:getx_template/features/system/screen/view/no_internet_screen.dart';
import 'package:getx_template/features/system/screen/view/update_required_screen.dart';
import 'package:getx_template/component/main_bottom_nav/main_bottom_nav_screen.dart';

class AppRoutes {
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String authWelcome = '/auth/welcome';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String otpVerification = '/auth/otp-verification';
  static const String mainBottomNavScreen = '/main-bottom-nav-screen';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String editProfile = '/profile/edit';
  static const String noInternet = '/no-internet';
  static const String updateRequired = '/update-required';
  static const String maintenance = '/maintenance';
  static const String error = '/error';
  static const String changePassword = '/change-password-screen';

  final List<GetPage<dynamic>> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: authWelcome, page: () => const AuthWelcomeScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: otpVerification, page: () => const OtpVerificationScreen()),
    GetPage(name: mainBottomNavScreen, page: () => const MainBottomNavScreen()),
    GetPage(name: notifications, page: () => const NotificationScreen()),
    GetPage(name: settings, page: () => const SettingsScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: noInternet, page: () => const NoInternetScreen()),
    GetPage(name: updateRequired, page: () => const UpdateRequiredScreen()),
    GetPage(name: maintenance, page: () => const MaintenanceScreen()),
    GetPage(name: error, page: () => const ErrorScreen()),
    GetPage(name: changePassword, page: () => const ChangePasswordScreen()),
  ];

  final unknownRoute = GetPage(
    name: error,
    page: () => const ErrorScreen(
      title: 'Page not found',
      message: 'The route you opened is not registered in this app.',
    ),
  );
}
