// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/how_it_works/how_it_works_view_model.dart';
import 'package:sip_social/ui/screens/how_it_works/widgets/expandable_widget.dart';
import 'package:sip_social/ui/widgets/app_icons.dart';
import 'package:stacked/stacked.dart';

class HowItWorksView extends StatelessWidget {
  const HowItWorksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      body: SafeArea(
        child: ViewModelBuilder<HowItWorksViewModel>.reactive(
          builder: (context, viewModel, child) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: $styles.insets.s,
                vertical: $styles.insets.m,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hiwHeaderWidget(viewModel: viewModel),
                    Gap($styles.insets.xl),
                    expandableList(viewModel: viewModel),
                    Gap($styles.insets.xxxl * 3),
                    hiwFooterWidget(viewModel: viewModel),
                  ],
                ),
              ),
            );
          },
          viewModelBuilder: () => HowItWorksViewModel(),
        ),
      ),
    );
  }
}

Widget hiwHeaderWidget({required HowItWorksViewModel viewModel}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SvgPicture.asset('assets/images/hiw_bg_image.svg'),
      Gap($styles.insets.m),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "How it",
            style: $styles.text.displayMedium.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Gap($styles.insets.xxs),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: $styles.colors.primaryOrangeColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "works?",
                style: $styles.text.titleSmall.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget expandableList({required HowItWorksViewModel viewModel}) {
  return Column(
    children: const [
      ExpandableWidget(
        title: 'Create Your Sipper',
        caption: 'Craft your Sipper profile and showcase your unique personality. Choose a persona that best represents you: Social Butterfly, Mindful Mixer or more!',
        icon: AppIcons.hiw_profile_single,
        hasDivider: true,
      ),
      ExpandableWidget(
        title: 'Find your Socials',
        caption: 'Explore nearby Socials, join a group of like-minded Sippers, and share an unforgettable experience together',
        icon: AppIcons.hiw_find_your_sipper,
        hasDivider: true,
      ),
      ExpandableWidget(
        title: 'Join a Club',
        caption: 'Find your tribe and join Clubs that align with your interests. Create your own Club and connect with Sippers that share your passion.',
        icon: AppIcons.hiw_join_club,
        hasDivider: true,
      ),
      ExpandableWidget(
        title: 'Sip Radar',
        caption: 'Activate your Sip Radar and uncover trending Socials and Clubs in your area. Expand your horizons and embark on new adventures.',
        icon: AppIcons.hiw_sip_radar,
        hasDivider: false,
      ),
    ],
  );
}

Widget hiwFooterWidget({required HowItWorksViewModel viewModel}) {
  return Stack(
    children: [
      SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(
          value: 0.25,
          color: $styles.colors.black,
          backgroundColor: $styles.colors.greyMedium,
        ),
      ),
      Positioned(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
        child: GestureDetector(
          onTap: () => viewModel.navigateToMobileNumberEmailView(),
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
