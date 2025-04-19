import 'package:flutter/material.dart';
import 'package:rjs_store/core/utils/constants/image_strings.dart';
import 'widgets/onboarding_view_body.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var path in TImages.onboardingImages) {
      precacheImage(AssetImage(path), context);
    }
    for (var path in TImages.animations) {
      precacheImage(AssetImage(path), context);
    }
    for (var path in TImages.productImages) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: OnboardingViewBody()),
    );
  }
}
