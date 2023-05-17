import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/widgets/app_icons.dart';
import 'package:stacked/stacked.dart';

class NameDOBZipcodeIntroView extends ViewModelWidget<MainViewModel> {
  const NameDOBZipcodeIntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.xxl),
            child: Column(
              children: [
                Gap($styles.insets.l),
                introHeaderWidget(viewModel: viewModel),
                Gap($styles.insets.xl),
                introTextWidget(viewModel: viewModel),
                Gap($styles.insets.xxl * 2),
                introFooterWidget(viewModel: viewModel),
                Gap($styles.insets.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget introHeaderWidget({required MainViewModel viewModel}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset('assets/images/personal_details_2_bg.svg'),
    ],
  );
}

Widget introTextWidget({required MainViewModel viewModel}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Let’s create",
            textAlign: TextAlign.start,
            style: $styles.text.displayMedium.copyWith(
              fontWeight: FontWeight.w900,
              height: 0,
            ),
          ),
        ],
      ),
      Gap($styles.insets.xs),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "your ",
            textAlign: TextAlign.start,
            style: $styles.text.displayMedium.copyWith(
              fontWeight: FontWeight.w900,
              height: 0,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: $styles.colors.primaryOrangeColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 5, right: 12),
              child: Text(
                "sipper",
                style: $styles.text.displayMedium.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "profile",
            textAlign: TextAlign.start,
            style: $styles.text.displayMedium.copyWith(
              fontWeight: FontWeight.w900,
              height: 0,
            ),
          ),
        ],
      ),
      Gap($styles.insets.xxxl),
      Text(
        "Share your real name, a genuine photo, and a few details about yourself. Authenticity helps make meaningful connections.",
        textAlign: TextAlign.start,
        style: $styles.text.titleSmall.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ],
  );
}

Widget introFooterWidget({required MainViewModel viewModel}) {
  return Stack(
    children: [
      SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(
          value: 0.75,
          color: $styles.colors.black,
          backgroundColor: $styles.colors.greyMedium,
          strokeWidth: 3,
        ),
      ),
      Positioned(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
        child: GestureDetector(
          onTap: () => viewModel.navigateToNameDOBZipcodeDetailsView(),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: $styles.colors.black,
            child: AppIcon(
              AppIcons.arrow_right,
              color: $styles.colors.white,
              size: 26,
            ),
          ),
        ),
      ),
    ],
  );
}
