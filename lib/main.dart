import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rjs_store/core/utils/constants/texts.dart';
import 'package:rjs_store/firebase_options.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'core/utils/repositories/authentication_repository.dart';
import 'my_app.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<void> main() async {
//   Get.testMode = true;
  // Create a Cloudinary instance and set your cloud name.
  // ignore: deprecated_member_use
  CloudinaryContext.cloudinary =
      Cloudinary.fromCloudName(cloudName: TTexts.kCloudName);

  // Parse initialize
  const keyApplicationId = 'VNTR17VrnY5tumqG9BxhmdfFH8GBD7ZxMMUD8Ahr';
  const keyClientKey = 'tZgRDmld3efbvz06U7HeDhTCn1GiT5HvAr49YudU';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: kDebugMode,
  );

///////////////////////// Check if I am connected to the server ///////////////////////
//   var firstObject = ParseObject('FirstClass')
//     ..set('message', 'Hey, Parse is now connected!🙂');
//   await firstObject.save();

//   if (kDebugMode) {
//     print('done');
//   }
  ///////////////////////// END Check if I am connected to the server ///////////////////////

  /// Widget Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// -- Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // init local storage :
  /// -- GetX Local Storage
  await GetStorage.init();

  /// -- Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}
