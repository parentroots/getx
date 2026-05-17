import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<T?> runBusy<T>(Future<T> Function() task) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      return await task();
    } catch (error) {
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
