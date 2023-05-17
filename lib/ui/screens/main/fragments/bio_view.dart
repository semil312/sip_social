import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/screens/main/widgets/custom_appbar.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:sip_social/ui/widgets/custom_textfield.dart';
import 'package:sip_social/ui/widgets/textfield_label.dart';
import 'package:stacked/stacked.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class BioView extends ViewModelWidget<MainViewModel> {
  const BioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          pageIndex: 2,
          hasSkipButton: true,
          onSkip: () => viewModel.setIndex(index: 5),
          previousPageIndex: 3,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
            child: Column(
              children: [
                bioHeaderWidget(viewModel: viewModel),
                Gap($styles.insets.xxxl),
                bioTextfieldWidget(viewModel: viewModel),
                Gap($styles.insets.xxxl * 1.5),
                bioFooterWidget(viewModel: viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget bioHeaderWidget({required MainViewModel viewModel}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap($styles.insets.xxxl * 3),
          SvgPicture.asset(
            "assets/images/background_image_star.svg",
            color: $styles.colors.black,
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

Widget bioTextfieldWidget({required MainViewModel viewModel}) {
  return Form(
    key: viewModel.bioFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFieldLabel(title: "WHAT’S YOUR SOCIAL STYLE?"),
        Gap($styles.insets.s),
        const DropDownMenu(),
        Gap($styles.insets.s),
        const TextFieldLabel(title: "WHEN WHERE YOU BORN?"),
        Gap($styles.insets.s),
        CustomTextField(
          controller: viewModel.bioController,
          maxLength: 1000,
          maxLines: 4,
          validator: (value) => viewModel.validateBio(value),
          onChanged: (p0) {
            viewModel.notifyListeners();
          },
          keyboardType: TextInputType.number,
        ),
        Gap($styles.insets.xs),
        const TextFieldLabel(title: "WHAT’S YOUR GO-TO DRINK?"),
        Gap($styles.insets.xs),
        CustomTextField(
          controller: viewModel.choiceOfDrinkController,
          validator: (value) => viewModel.validateChoiceOfDrink(value),
          onChanged: (p0) {
            viewModel.notifyListeners();
          },
        ),
        Gap($styles.insets.xs),
        Padding(
          padding: EdgeInsets.only(left: $styles.insets.xs, right: $styles.insets.s),
          child: Text(
            "Share your favourite drink so fellow Sippers know what to order when you meet up!",
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

Widget bioFooterWidget({required MainViewModel viewModel}) {
  return CustomButton(
    title: "Next",
    onTap: () {
      viewModel.navigateToUploadImageView();
    },
  );
}

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String? selectedValue;

  List<String> items = [
    "Adventurers",
    "Loki",
    "Thor",
    "Thanos",
    "IronMan",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: $styles.colors.white,
      child: DropdownButton2(
        hint: Text(
          'Select One',
          style: $styles.text.labelLarge.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        value: selectedValue,
        underline: Container(),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: $styles.text.labelLarge.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value as String?;
          });
        },
        isExpanded: true,
        icon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(CupertinoIcons.chevron_down, color: $styles.colors.black),
        ),
        iconSize: 22,
        iconOnClick: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(CupertinoIcons.chevron_up, color: $styles.colors.black),
        ),
        buttonElevation: 0,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: $styles.colors.black,
          ),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: $styles.colors.white,
          border: Border.all(
            color: $styles.colors.black,
            width: 1,
          ),
        ),
        dropdownElevation: 0,
      ),
    );
  }
}
