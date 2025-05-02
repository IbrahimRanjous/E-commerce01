import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/popups/loaders.dart';

/// ----------------------------------
/// Connectivity Service
/// ----------------------------------
class NetworkManager extends GetxController {
  // This provides a shorthand for accessing the controller instance throughout your app
  // by calling NetworkManager.instance
  // (assuming you’ve properly registered it using Get.put(NetworkManager())
  // somewhere in your code).
  static NetworkManager get instance => Get.find();

  // An instance of the Connectivity class that lets you query or listen for changes in
  // network connection status.
  final Connectivity _connectivity = Connectivity();
  // A subscription that will hold the listener for connectivity changes.
  // Marked as late because it will be assigned in onInit().
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // A reactive (observable) variable holding the current connectivity status. It’s initialized to
  // ConnectivityResult.none (meaning, by default, no connection).
  // The .obs postfix makes it an observable, so views can react to changes.
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    /*
    Listening to Connectivity Changes:
    * _connectivity.onConnectivityChanged provides a stream that emits changes in connectivity.
    * Mapping the Stream: The stream now emits a list of connectivity results.
    * The map operator processes this list:
    ** It checks if the list is not empty.
    ** If it isn’t empty, it takes the first element.
    ** If it’s empty, it defaults to ConnectivityResult.none.
    * .listen(_updateConnectionStatus): Finally, each time a connectivity change is emitted
    (after mapping), the _updateConnectionStatus method is invoked with the new status.
    */
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .map((results) =>
            results.isNotEmpty ? results.first : ConnectivityResult.none)
        .listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      TLoaders.warningSnackBar(title: 'No internet Connection');
    }
  }

  /// Checks the internet connection status.
  /// Returns `true` if connected to a network, otherwise `false`.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      return result != ConnectivityResult.none;
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    // The connectivity subscription is cancelled to avoid any memory leaks or
    // unnecessary processing when the controller is no longer active
    _connectivitySubscription.cancel();
    // This method is part of the lifecycle of GetxControllers and is called when
    // the controller is being disposed.
    super.onClose();
  }
}
