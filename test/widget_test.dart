import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_template/app/app.dart';
import 'package:getx_template/app/app_config.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('starter app boots to splash screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesService.init();

    await tester.pumpWidget(const StarterApp(config: AppConfig()));

    expect(find.text('GetX Starter'), findsOneWidget);

    Get.reset();
  });
}
