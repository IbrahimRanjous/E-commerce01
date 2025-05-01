// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rjs_store/firebase_options.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'core/utils/repositories/authentication_repository.dart';
import 'my_app.dart';

Future<void> main() async {
  // Create a Cloudinary instance and set your cloud name.
  CloudinaryContext.cloudinary =
      Cloudinary.fromCloudName(cloudName: "dolast4ks");

  /// Widget Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // init local storage :
  /// -- GetX Local Storage
  await GetStorage.init();

  /// -- Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}
