import 'package:get/get.dart';
import 'package:rjs_store/core/utils/network/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    // Get.lazyPut(
    //   () => SignupController(),
    // );
    // Get.lazyPut(
    //   () => LoginController(),
    // );
  }
}
