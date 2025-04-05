import 'package:flutter/material.dart';
import 'widgets/product_image_slider.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              /// -- Product Image Slider -- ///
              TProductImageSlider(),

              /// -- Product Details --///
            ],
          ),
        ),
      ),
    );
  }
}
