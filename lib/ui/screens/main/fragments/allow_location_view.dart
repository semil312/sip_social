import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:stacked/stacked.dart';

class AllowLocationView extends ViewModelWidget<MainViewModel> {
  const AllowLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: $styles.colors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            viewModel.setIndex(index: 1);
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
            allowLocationHeaderWidget(viewModel: viewModel),
            allowLocationContentWidget(viewModel: viewModel),
            const Spacer(),
            allowLocationFooterWidget(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}

Widget allowLocationHeaderWidget({required MainViewModel viewModel}) {
  return SvgPicture.asset('assets/images/allow_notification_bg.svg');
}

Widget allowLocationContentWidget({required MainViewModel viewModel}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What \nabout allowing",
          textAlign: TextAlign.start,
          style: $styles.text.displayMedium.copyWith(
            fontWeight: FontWeight.w900,
            height: 0,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: $styles.insets.xs),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color(0xff9D7EE6),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 5, right: 12),
              child: Text(
                "Location?",
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
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget allowLocationFooterWidget({required MainViewModel viewModel}) {
  return Padding(
    padding: EdgeInsets.all($styles.insets.s),
    child: Column(
      children: [
        CustomButton(
          title: 'Allow Location',
          onTap: () async {
            await viewModel.askLocationPermission(
              () => viewModel.setIndex(index: 3),
            );
          },
        ),
        Gap($styles.insets.xs),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.m),
          child: InkWell(
            onTap: () async {
              viewModel.setIndex(index: 3);
            },
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
