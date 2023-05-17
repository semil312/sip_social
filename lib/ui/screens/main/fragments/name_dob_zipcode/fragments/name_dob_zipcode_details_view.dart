// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/widgets/app_icons.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:sip_social/ui/widgets/custom_textfield.dart';
import 'package:sip_social/ui/widgets/textfield_label.dart';
import 'package:stacked/stacked.dart';

class NameDOBZipcodeDetailsView extends ViewModelWidget<MainViewModel> {
  const NameDOBZipcodeDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
            child: Column(
              children: [
                nameDOBZipcodeHeaderWidget(viewModel: viewModel),
                Gap($styles.insets.xxxl),
                nameDOBZipcodeTextfieldWidget(viewModel: viewModel),
                Gap($styles.insets.xxxl),
                nameDOBZipcodeFooterWidget(viewModel: viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget nameDOBZipcodeHeaderWidget({required MainViewModel viewModel}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap($styles.insets.xxxl * 3),
          SvgPicture.asset(
            "assets/images/background_image_star.svg",
            color: $styles.colors.primaryTurquoiseColor,
          ),
        ],
      ),
      Gap($styles.insets.xs),
      Text(
        "Let’s get to know",
        textAlign: TextAlign.start,
        style: $styles.text.displayMedium.copyWith(
          fontWeight: FontWeight.w900,
          height: 0,
        ),
      ),
      Gap($styles.insets.xs),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: $styles.colors.secondaryVioletColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 5, right: 12),
              child: Text(
                "the real",
                style: $styles.text.displayMedium.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Text(
            " you",
            textAlign: TextAlign.center,
            style: $styles.text.displayMedium.copyWith(
              fontWeight: FontWeight.w900,
              height: 0,
            ),
          ),
        ],
      )
    ],
  );
}

Widget nameDOBZipcodeTextfieldWidget({required MainViewModel viewModel}) {
  return Form(
    key: viewModel.nameDOBZipcodeFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFieldLabel(title: "WHAT’S YOUR NAME SIPPER?"),
        Gap($styles.insets.xs),
        CustomTextField(
          controller: viewModel.nameDOBZipcodeNameController,
          validator: (value) => viewModel.validateName(value),
          onChanged: (p0) {
            viewModel.notifyListeners();
          },
        ),
        Gap($styles.insets.m),
        const TextFieldLabel(title: "WHEN WHERE YOU BORN?"),
        Gap($styles.insets.xs),
        Row(
          children: [
            viewModel.countryCode == "+1"
                ? dobTextFieldWidget(
                    controller: viewModel.nameDOBZipcodeMonthController,
                    viewModel: viewModel,
                  )
                : dobTextFieldWidget(
                    controller: viewModel.nameDOBZipcodeDayController,
                    viewModel: viewModel,
                  ),
            Gap($styles.insets.xs),
            viewModel.countryCode == "+1"
                ? dobTextFieldWidget(
                    controller: viewModel.nameDOBZipcodeDayController,
                    viewModel: viewModel,
                  )
                : dobTextFieldWidget(
                    controller: viewModel.nameDOBZipcodeMonthController,
                    viewModel: viewModel,
                  ),
            Gap($styles.insets.xs),
            dobTextFieldWidget(
              controller: viewModel.nameDOBZipcodeYearController,
              viewModel: viewModel,
            ),
          ],
        ),
        Gap($styles.insets.xs),
        viewModel.dobErrorText.isEmpty
            ? Container()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs),
                child: Text(
                  viewModel.dobErrorText,
                  textAlign: TextAlign.start,
                  style: $styles.text.labelMedium.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: $styles.colors.error,
                  ),
                ),
              ),
        Gap($styles.insets.xs),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.xs),
          child: Text(
            "Verify you’re 21 or older. We want to ensure everyone enjoys Sip Social responsibly. We never show your age on profile.",
            textAlign: TextAlign.start,
            style: $styles.text.labelMedium.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        Gap($styles.insets.m),
        const TextFieldLabel(title: "WHERE DO YOU USUALLY SIP?"),
        Gap($styles.insets.xs),
        CustomTextField(
          controller: viewModel.nameDOBZipcodeZipcodeController,
          validator: (value) => viewModel.validateZipCode(value),
          onChanged: (p0) {
            viewModel.notifyListeners();
          },
          keyboardType: TextInputType.number,
          prefixIcon: const AppIcon(AppIcons.search),
        ),
        Gap($styles.insets.xs),
        Padding(
          padding: EdgeInsets.only(left: $styles.insets.xs, right: $styles.insets.s),
          child: Text(
            "Share your approximate location to discover Socials, Clubs, and Sippers near you.",
            textAlign: TextAlign.start,
            style: $styles.text.labelMedium.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget dobTextFieldWidget({
  required TextEditingController controller,
  required MainViewModel viewModel,
}) {
  return Expanded(
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: $styles.colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: viewModel.isDOBValidate ? $styles.colors.black : $styles.colors.error,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.l),
        child: TextFormField(
          controller: controller,
          cursorHeight: 22,
          cursorColor: $styles.colors.black,
          keyboardType: TextInputType.number,
          style: $styles.text.labelLarge.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: $styles.colors.black,
          ),
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    ),
  );
}

Widget nameDOBZipcodeFooterWidget({required MainViewModel viewModel}) {
  return CustomButton(
    title: "Next",
    onTap: () {
      viewModel.navigateToBioView();
    },
  );
}
