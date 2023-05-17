import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/profile/profile_view_model.dart';
import 'package:sip_social/ui/widgets/app_icons.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:sip_social/ui/widgets/custom_circle_button.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      disposeViewModel: false,
      fireOnViewModelReadyOnce: true,
      onViewModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: $styles.colors.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                profileDetailsWidget(),
                profileListWidget(),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}

Widget profileDetailsWidget() {
  return Container(
    decoration: BoxDecoration(
      color: $styles.colors.profileBackgroundColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular($styles.corners.lg),
        bottomRight: Radius.circular($styles.corners.lg),
      ),
    ),
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: $styles.insets.m,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  AppIcon(AppIcons.profile_setting),
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: SvgPicture.asset(
                    'assets/images/background_image_star.svg',
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: $styles.colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: $styles.colors.black,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: $styles.colors.white,
                          child: Padding(
                            padding: EdgeInsets.all($styles.insets.xxs),
                            child: ClipOval(
                              child: Image.asset('assets/images/login_sample_image_1.png'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: $styles.insets.l * 3, left: $styles.insets.xl * 2),
                        child: CustomCircleButton(
                          icon: AppIcons.profile_edit_image,
                          onTap: () {},
                          backgroundColor: $styles.colors.greyColor,
                          borderRadius: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 70, top: 125),
                    child: SvgPicture.asset(
                      'assets/images/background_image_star.svg',
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Jennifer Brown",
              style: $styles.text.titleLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "@ Good Listener",
                  style: $styles.text.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap($styles.insets.xs),
                Padding(
                  padding: EdgeInsets.only(top: $styles.insets.xxs),
                  child: CircleAvatar(
                    radius: 2,
                    backgroundColor: $styles.colors.black,
                  ),
                ),
                Gap($styles.insets.xs),
                Text(
                  "New York",
                  style: $styles.text.titleLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              "member since 2020",
              style: $styles.text.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.l * 2, vertical: $styles.insets.s),
              child: Text(
                "A popular social media influencer living in New York. Love to share my passion for drinks fashion and travel with my fellow sippers and meet up with like-minded people",
                textAlign: TextAlign.center,
                style: $styles.text.bodyMedium.copyWith(color: $styles.colors.black, fontSize: 12, height: 1.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.xxxl * 2, vertical: $styles.insets.xs),
              child: CustomButton(
                title: 'Edit Profile',
                onTap: () {},
                isSecondary: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: $styles.insets.s),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  singleColumn(icon: AppIcons.hiw_find_your_sipper, text: "Social", num: "7", hasDivider: true),
                  singleColumn(icon: AppIcons.hiw_join_club, text: "Clubs", num: "3", hasDivider: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const AppIcon(
                            AppIcons.profile_follower,
                            size: 25,
                          ),
                          Gap($styles.insets.xxs),
                          Text(
                            "Followers",
                            style: $styles.text.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                              color: $styles.colors.primaryPurpleColor,
                            ),
                          ),
                          Gap($styles.insets.xxs),
                          Text(
                            '9090',
                            style: $styles.text.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                              color: $styles.colors.primaryPurpleColor,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
                        child: Container(
                          width: 2,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: $styles.colors.primaryPurpleColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  singleColumn(icon: AppIcons.profile_following, text: "Following", num: "32", hasDivider: false),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget profileListWidget() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: $styles.insets.s),
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: $styles.insets.m, left: $styles.insets.m, right: $styles.insets.m),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/login_sample_image_1.png',
                      height: 56,
                    ),
                  ),
                  Gap($styles.insets.m),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alex lee",
                        style: $styles.text.bodyMedium.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      Text(
                        "@ Adventurer",
                        style: $styles.text.bodySmall.copyWith(color: $styles.colors.body, fontSize: 12),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "4 ",
                              style: $styles.text.bodyMedium.copyWith(color: $styles.colors.primaryPurpleColor, fontWeight: FontWeight.w700,),
                            ),
                            TextSpan(
                              text: "Sipper, ",
                              style: $styles.text.bodyMedium.copyWith(color: $styles.colors.black),
                            ),
                            TextSpan(
                              text: "3 ",
                              style: $styles.text.bodyMedium.copyWith(color: $styles.colors.primaryPurpleColor, fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: "Clubs in common",
                              style: $styles.text.bodyMedium.copyWith(color: $styles.colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  const AppIcon(AppIcons.profile_chat, size: 28),
                  Gap($styles.insets.xxs),
                  const AppIcon(AppIcons.profile_block, size: 28),
                ],
              )
            ],
          ),
        );
      },
    ),
  );
}

Widget singleColumn({
  required AppIcons icon,
  required String text,
  required String num,
  required bool hasDivider,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          AppIcon(
            icon,
            size: 25,
          ),
          Gap($styles.insets.xxs),
          Text(
            text,
            style: $styles.text.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap($styles.insets.xxs),
          Text(
            num,
            style: $styles.text.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      hasDivider
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
              child: Container(
                width: 2,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: $styles.colors.primaryPurpleColor,
                ),
              ),
            )
          : Container(),
    ],
  );
}
