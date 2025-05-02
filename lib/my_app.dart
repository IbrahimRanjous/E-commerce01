import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/core/utils/bindings/general_bindings.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'core/utils/theme/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),

      /// Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: TCircularProgressIndicator(),
      ),
    );
  }
}

class TCircularProgressIndicator extends StatelessWidget {
  const TCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: TColors.white,
      ),
    );
  }
}
