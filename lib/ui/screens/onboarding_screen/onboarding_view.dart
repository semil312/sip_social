// ignore_for_file: depend_on_referenced_packages, avoid_unnecessary_containers
import 'package:flutter/gestures.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/onboarding_screen/onboarding_viewModel.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.reactive(
      onViewModelReady: (viewModel) {},
      disposeViewModel: false,
      fireOnViewModelReadyOnce: true,
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: $styles.colors.backgroundColor,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                displayHeaderWidget(viewModel),
                screenTitleAndDescriptionWidget(viewModel),
                Gap($styles.insets.l),
                Expanded(
                  child: bottomSheetWidget(viewModel),
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => OnBoardingViewModel(),
    );
  }
}

Widget displayHeaderWidget(OnBoardingViewModel viewModel) {
  return SizedBox(
    width: 360,
    child: Stack(
      children: [
        imageWidget(),
        Positioned(
          left: $styles.insets.xxl,
          top: $styles.insets.s,
          child: SvgPicture.asset('assets/images/login_bg_image.svg'),
        ),
        Positioned(
          bottom: 0,
          left: 12,
          child: Text(
            "WHERE MIGHT",
            style: $styles.text.labelMedium.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget imageWidget() {
  return Padding(
    padding: EdgeInsets.only(top: $styles.insets.xxl),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: $styles.insets.xxxl),
          child: singleImageWidget(imagePath: "assets/images/login_sample_image_2.png"),
        ),
        Gap($styles.insets.xs),
        Column(
          children: [
            singleImageWidget(imagePath: "assets/images/login_sample_image_1.png"),
            Gap($styles.insets.xs),
            singleImageWidget(imagePath: "assets/images/login_sample_image_3.png"),
          ],
        ),
      ],
    ),
  );
}

Widget screenTitleAndDescriptionWidget(OnBoardingViewModel viewModel) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.m, vertical: $styles.insets.xs),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Next",
                  style: $styles.text.displayMedium.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: $styles.colors.primaryOrangeColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 5, right: 12),
                        child: Text(
                          "sip",
                          style: $styles.text.displayMedium.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "take you?",
                      style: $styles.text.displayMedium.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SvgPicture.asset('assets/images/background_image_star.svg')
          ],
        ),
      ),
      Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: $styles.insets.m, top: $styles.insets.xs),
            child: Text(
              "Get Ready to discover a world of \ndrinks, connections, and adventure.",
              textAlign: TextAlign.start,
              style: $styles.text.titleMedium.copyWith(
                fontWeight: FontWeight.w500,
                height: 0,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget bottomSheetWidget(OnBoardingViewModel viewModel) {
  return Container(
    decoration: BoxDecoration(
      color: $styles.colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: $styles.insets.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            title: 'Get Started',
            onTap: () {},
          ),
          Gap($styles.insets.s),
          CustomButton(
            title: 'Already a Member? Log in',
            onTap: () {
              viewModel.navigateToLoginView();
            },
            isSecondary: true,
          ),
          Gap($styles.insets.m),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "By continuing you agree with Sip Social’s ",
                    style: $styles.text.bodyMedium.copyWith(
                      color: $styles.colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "\nTerms of service ",
                    style: $styles.text.bodyMedium.copyWith(
                      color: $styles.colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w800,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        viewModel.launchLink("");
                      },
                  ),
                  TextSpan(
                    text: "and ",
                    style: $styles.text.bodyMedium.copyWith(
                      color: $styles.colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    style: $styles.text.bodyMedium.copyWith(
                      color: $styles.colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w800,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        viewModel.launchLink("");
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget singleImageWidget({required String imagePath}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular($styles.corners.sm),
      color: $styles.colors.black,
    ),
    child: Padding(
      padding: EdgeInsets.all($styles.corners.xxs),
      child: ClipRRect(
        borderRadius: BorderRadius.circular($styles.corners.sm),
        child: Image.asset(imagePath),
      ),
    ),
  );
}
