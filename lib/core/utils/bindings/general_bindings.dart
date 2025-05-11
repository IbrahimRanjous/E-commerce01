import 'package:get/get.dart';
import 'package:rjs_store/Features/Signin/data/cubit/signup_controller.dart';
import 'package:rjs_store/Features/login/data/cubit/login_controller.dart';
import 'package:rjs_store/core/utils/network/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.lazyPut(
      () => SignupController(),
    );
    Get.lazyPut(
      () => LoginController(),
    );
  }
}
