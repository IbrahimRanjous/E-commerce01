import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../popups/loaders.dart';

class NetworkManager extends GetxController {
  // Provides a static way to access the NetworkManager instance using Get.find().
  static NetworkManager get instance => Get.find();

  // Connectivity instance to check network state.
  final Connectivity _connectivity = Connectivity();

  // Subscription to the connectivity changes.
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Observable variable to keep track of the connectivity status.
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    // Map the list of ConnectivityResult to a single ConnectivityResult and
    // Listen for changes. If the emitted list is not empty, use the first element.
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .map((results) =>
            results.isNotEmpty ? results.first : ConnectivityResult.none)
        .listen(_updateConnectionStatus);
  }

  // Updates the connectivity status and shows a warning if not connected.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      // Display a warning snack bar (assuming TLoaders.warningSnackBar is defined)
      TLoaders.warningSnackBar(title: 'No Internet Connection');
    }
  }

  // Checks if the device is currently connected to the internet.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    // Cancel the subscription when the controller is disposed.
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
