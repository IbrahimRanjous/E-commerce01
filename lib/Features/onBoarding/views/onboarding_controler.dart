import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rjs_store/Features/login/views/login_view.dart';

class OnboardingControler {
  static OnboardingControler get instance => Get.find();

  //// Vaiables
  final pageController = PageController();
  // obs : this is the observer which will change the design without using stateful widget
  Rx<int> currentPageIndex = 0.obs;

  //// Update Current Index when Page Scroll
  void updatePageIndecator(index) {
    currentPageIndex.value = index;
  }

  /// Jump to the specific dot seleted page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Update Current Index & Jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(() => const LoginView());
    } else {
      currentPageIndex.value += 1;
      pageController.jumpToPage(currentPageIndex.value);
      dotNavigationClick(currentPageIndex.value);
    }
  }

  /// Update current Index & jump to the Last page
  void skipPage() {
    Get.offAll(() => const LoginView());
  }
}
