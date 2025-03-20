import 'package:flutter/material.dart';
import 'widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingViewBody(),
    );
  }
}

// class _OnboardingViewState extends State<OnboardingView> {
//   List pageArr = [
//     {
//       "title": 'Discounted \n Secondhand Books',
//       "sub_title": "Used and near new secondhand books at great prices.",
//       "img": "assets/images/onboarding.png"
//     },
//     {
//       "title": "20 Book Grocers Nationally",
//       "sub_title": "We've successfully opened 20 stores across Australia.",
//       "img": "assets/images/onboarding.png"
//     },
//     {
//       "title": "Sell or Recycle Your Old Books With Us",
//       "sub_title":
//           "If you're looking to downsize, sell or recycle old books, the Book Grocer can help.",
//       "img": "assets/images/onboarding.png"
//     },
//   ];
//   int page = 0;
//   PageController controller = PageController();

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(() {
//       page = controller.page?.round() ?? 0;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             PageView.builder(
//               controller: controller,
//               itemCount: pageArr.length,
//               itemBuilder: (context, index) {
//                 var pObJ = pageArr[index] as Map? ?? {};
//                 return Container(
//                   width: mediaQuery.width,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomText(
//                         text: pObJ['title'].toString(),
//                         textStyle: const TextStyle(color: TColors.black),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       CustomText(
//                         text: pObJ['sub_title'].toString(),
//                         textStyle: const TextStyle(color: TColors.black),
//                       ),
//                       SizedBox(
//                         height: mediaQuery.height * .1,
//                       ),
//                       Image.asset(
//                         pObJ['img'].toString(),
//                         width: mediaQuery.width * .6,
//                         height: mediaQuery.height * .5,
//                         fit: BoxFit.fitWidth,
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//             BottomPartBody(
//               mediaQuery: mediaQuery,
//               pageArr: pageArr,
//               page: page,
//               controller: controller,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BottomPartBody extends StatelessWidget {
//   const BottomPartBody({
//     super.key,
//     required this.mediaQuery,
//     required this.pageArr,
//     required this.page,
//     required this.controller,
//   });

//   final Size mediaQuery;
//   final List pageArr;
//   final int page;
//   final PageController controller;
//   @override
//   Widget build(BuildContext context) {
//     int increasePage = page;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const CustomTextButton(
//                 // onPressed: () => context.go(AppRouter.kWelcomeView),
//                 text: 'Skip',
//                 color: TColors.buttonDisabled,
//               ),
//               SizedBox(
//                 width: mediaQuery.width * .05,
//               ),
//               DotsSideShow(
//                 pageArr: pageArr,
//                 page: increasePage,
//                 mediaQuery: mediaQuery,
//               ),
//               SizedBox(
//                 width: mediaQuery.width * .05,
//               ),
//               CustomTextButton(
//                 onPressed: () {
//                   if (increasePage < 2) {
//                     increasePage++;
//                     controller.jumpToPage(increasePage);
//                   } else {
//                     // context.go(AppRouter.kWelcomeView);
//                   }
//                 },
//                 text: 'Next',
//                 color: TColors.buttonDisabled,
//               ),
//               SizedBox(
//                 height: mediaQuery.height * .12,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomTextButton extends StatelessWidget {
//   const CustomTextButton({
//     super.key,
//     required this.text,
//     this.onPressed,
//     required this.color,
//   });

//   final String text;
//   final Color color;
//   final void Function()? onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       splashColor: TColors.buttonDisabled,
//       onTap: onPressed,
//       child: Text(
//         text,
//         style:
//             TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 17),
//       ),
//     );
//   }
// }

// class DotsSideShow extends StatelessWidget {
//   const DotsSideShow({
//     super.key,
//     required this.pageArr,
//     required this.page,
//     required this.mediaQuery,
//   });

//   final List pageArr;
//   final int page;
//   final Size mediaQuery;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: pageArr.map((pObJ) {
//         var index = pageArr.indexOf(pObJ);
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           width: 15,
//           height: 15,
//           decoration: BoxDecoration(
//             color: page == index ? TColors.buttonPrimary : TColors.secondary,
//             borderRadius: BorderRadius.circular(8),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// class CustomText extends StatelessWidget {
//   const CustomText({
//     super.key,
//     required this.text,
//     required this.textStyle,
//   });
//   final String text;
//   final TextStyle textStyle;

//   @override
//   Widget build(BuildContext context) {
//     return Text(text, textAlign: TextAlign.center, style: textStyle);
//   }
// }
