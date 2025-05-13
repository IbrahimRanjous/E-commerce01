import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/onBoarding/data/controllers/onboarding_controler.dart';
 import 'package:rjs_store/core/utils/constants/texts.dart';
import '../../../../core/utils/constants/image_strings.dart';
import 'onboarding_dot_navigation.dart';
import 'onboarding_next_button.dart';
import 'onboarding_item.dart';
import 'onboarding_skip.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingControler());

    return SafeArea(
      child: Stack(
        children: [
          // Horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: (value) {
              controller.updatePageIndecator(value);
            },
            children: const [
              OnBoardingItem(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingItem(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingItem(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          // skip button
          const OnboardingSkip(),
          // dot naviagtion smoothpageindicator
          const OnboardingDotNavigation(),
          // cirular button
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}
