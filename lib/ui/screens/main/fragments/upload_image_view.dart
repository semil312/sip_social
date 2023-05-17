import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/screens/main/widgets/custom_appbar.dart';
import 'package:sip_social/ui/widgets/app_icons.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:sip_social/ui/widgets/custom_circle_button.dart';
import 'package:stacked/stacked.dart';

class UploadImageView extends ViewModelWidget<MainViewModel> {
  const UploadImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          pageIndex: 3,
          hasSkipButton: true,
          onSkip: () => viewModel.setIndex(index: 6),
          previousPageIndex: 4,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap($styles.insets.s),
                uploadImageHeaderWidget(),
                Gap($styles.insets.xxxl),
                uploadImageWidget(context, viewModel),
                Gap($styles.insets.xxxl),
                uploadImageFooterWidget(viewModel: viewModel),
                Gap($styles.insets.s),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget uploadImageHeaderWidget() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: $styles.insets.l),
    child: Stack(
      children: [
        SvgPicture.asset('assets/images/upload_image_bg.svg'),
        Padding(
          padding: EdgeInsets.only(top: $styles.insets.l * 2),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Profile",
                  style: $styles.text.displayMedium.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Gap($styles.insets.xxs),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: $styles.colors.secondaryVioletColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: $styles.insets.xs,
                      vertical: $styles.insets.xxs,
                    ),
                    child: Text(
                      "photo",
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
          ),
        ),
      ],
    ),
  );
}

Widget uploadImageWidget(BuildContext context, MainViewModel viewModel) {
  return Column(
    children: [
      SizedBox(
        height: 260,
        width: 220,
        child: Stack(
          children: [
            Center(child: SvgPicture.asset('assets/images/upload_image_frame.svg')),
            viewModel.image == null
                ? Center(
                    child: SizedBox(
                      child: CustomCircleButton(
                        icon: AppIcons.hiw_plus,
                        onTap: () {
                          // showModalBottomSheet(
                          //   backgroundColor: Colors.transparent,
                          //   context: context,
                          //   builder: (context) {
                          //     return imagePicketBottomSheet(viewModel, context);
                          //   },
                          // );

                          showPlatformModalSheet(
                            context: context,
                            builder: (context) {
                              return imagePicketBottomSheet(viewModel, context);
                            },
                            material: MaterialModalSheetData(
                              backgroundColor: Colors.transparent,
                            ),
                            cupertino: CupertinoModalSheetData(),
                          );
                        },
                        backgroundColor: $styles.colors.primaryOrangeColor,
                        borderRadius: 30,
                      ),
                    ),
                  )
                : Center(
                    child: Stack(
                      children: [
                        Center(
                          child: ClipOval(
                            child: Image.file(
                              viewModel.image!,
                              height: 180,
                              width: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomCircleButton(
                                  backgroundColor: $styles.colors.primaryOrangeColor,
                                  icon: AppIcons.upload_image_edit,
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return imagePicketBottomSheet(viewModel, context);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      Gap($styles.insets.xxl),
      Text(
        "Add a real photo of yourself and let fellow \nSippers see the face behind the sips.",
        textAlign: TextAlign.center,
        style: $styles.text.labelLarge.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ],
  );
}

Widget uploadImageFooterWidget({required MainViewModel viewModel}) {
  return CustomButton(
    title: 'Confirm & Start Sipping',
    onTap: () {
      viewModel.navigateToSavingProfile();
    },
  );
}

Widget imagePicketBottomSheet(MainViewModel viewModel, context) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: $styles.colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        viewModel.uploadImage(ImageSource.gallery);
                        viewModel.getNavigationService().back();
                      },
                      child: Text(
                        "Photo Gallery",
                        style: $styles.text.labelLarge.copyWith(
                          color: $styles.colors.primaryPurpleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.maxFinite,
                height: 1,
                color: $styles.colors.greyStrong,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        viewModel.uploadImage(ImageSource.camera);
                        viewModel.getNavigationService().back();
                      },
                      child: Text(
                        "Camera",
                        style: $styles.text.labelLarge.copyWith(
                          color: $styles.colors.primaryPurpleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Gap($styles.insets.s),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: $styles.colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    viewModel.getNavigationService().back();
                  },
                  child: Text(
                    "Cancel",
                    style: $styles.text.labelLarge.copyWith(
                      color: $styles.colors.primaryPurpleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
