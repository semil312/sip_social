import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:stacked/stacked.dart';

class AllowNotificationView extends ViewModelWidget<MainViewModel> {
  const AllowNotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: $styles.colors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            viewModel.setIndex(index: 0);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: $styles.colors.black,
            size: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/images/allow_notification_bg.svg'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
              child: Text(
                "Your Next \nabout allowing",
                textAlign: TextAlign.start,
                style: $styles.text.displayMedium.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.s, vertical: $styles.insets.xs),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color(0xff9D7EE6),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 5, right: 12),
                  child: Text(
                    "notification?",
                    style: $styles.text.displayMedium.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB($styles.insets.s, $styles.insets.s, $styles.insets.xl, $styles.insets.s),
              child: Text(
                "Enable notifications to be sure to know when someone creates a new club, discover Socials, Clubs, and Sippers near you.",
                textAlign: TextAlign.start,
                style: $styles.text.titleSmall.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            const Spacer(),
            footerWidget(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}

Widget footerWidget({required MainViewModel viewModel}) {
  return Padding(
    padding: EdgeInsets.all($styles.insets.s),
    child: Column(
      children: [
        CustomButton(
          title: 'Allow Notification',
          onTap: () {
            viewModel.askNotificationPermission(
              () {
                viewModel.navigateToAllowLocation();
              },
            );
          },
        ),
        Gap($styles.insets.xs),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.m),
          child: GestureDetector(
            onTap: () => viewModel.navigateToAllowLocation(),
            child: Text(
              "Not Now",
              textAlign: TextAlign.center,
              style: $styles.text.bodyLarge.copyWith(
                color: $styles.colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Gap($styles.insets.s),
      ],
    ),
  );
}
