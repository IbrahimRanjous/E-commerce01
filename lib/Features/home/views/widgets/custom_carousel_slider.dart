import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rjs_store/core/utils/constants/colors.dart';
import 'package:rjs_store/core/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MySliderImage extends StatefulWidget {
  const MySliderImage({super.key});

  @override
  State<MySliderImage> createState() => _MySliderImageState();
}

class _MySliderImageState extends State<MySliderImage> {
  int activeIndex = 0;

  final urlImages = [
    //  images
    'assets/images/banners/banner_1.jpg',
    'assets/images/banners/banner_2.jpg',
    'assets/images/banners/banner_3.jpg',
    'assets/images/banners/banner_4.jpg',
    'assets/images/banners/banner_5.jpg',
    'assets/images/banners/banner_6.jpg',
    'assets/images/banners/banner_7.jpg',
    'assets/images/banners/banner_8.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlimage = urlImages[index];
              return buildImage(urlimage, index);
            },
            options: CarouselOptions(
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                autoPlay: true,
                height: 200,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index)),
          ),
          const SizedBox(
            height: TSizes.sm,
          ),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
          dotWidth: 10,
          dotHeight: 5,
          activeDotColor: TColors.primary,
        ),
        activeIndex: activeIndex,
        count: urlImages.length,
      );
}

//////////////////////////////////////// IMAGE ////////////////////////////////////////
Widget buildImage(String urlimage, int index) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        child: Image.asset(
          urlimage,
          fit: BoxFit.fill,
        ),
      ),
    );

//////////////////////////////////////// IMAGE ////////////////////////////////////////
///////////////////////////////// Not Used right now /////////////////////////////////
class IRoundedImage extends StatelessWidget {
  const IRoundedImage({
    super.key,
    this.width = 150,
    this.height = 158,
    required this.imageUrl,
    this.applyImageRadius = false,
    this.border,
    this.backgroundColor = TColors.light,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    required this.borderRadius,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            fit: fit,
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
