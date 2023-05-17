import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/authentication/fragments/login_view.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/screens/main/widgets/custom_appbar.dart';
import 'package:sip_social/ui/widgets/custom_button.dart';
import 'package:sip_social/ui/widgets/custom_textfield.dart';
import 'package:sip_social/ui/widgets/textfield_label.dart';
import 'package:stacked/stacked.dart';

class EmailUserNameView extends ViewModelWidget<MainViewModel> {
  const EmailUserNameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return Scaffold(
      backgroundColor: $styles.colors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          pageIndex: viewModel.currentIndex,
          hasSkipButton: false,
          previousPageIndex: 0,
          onSkip: () {
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: $styles.insets.s),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: headerWidget(),
              ),
              Flexible(
                child: SingleChildScrollView(
                  controller: viewModel.mobileNumberEmailViewScrollController,
                  child: Column(
                    children: [
                      Gap($styles.insets.xs),
                      textFieldsWithTitleWidget(viewModel: viewModel, context: context),
                      Gap($styles.insets.xxxl * 2),
                      personalDetailsViewFooterWidget(viewModel: viewModel),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textFieldsWithTitleWidget({required MainViewModel viewModel, required BuildContext context}) {
  return Form(
    key: viewModel.mobileEmailFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap($styles.insets.m),
        const TextFieldLabel(title: "EMAIL ADDRESS (OPTIONAL)"),
        Gap($styles.insets.xs),
        CustomTextField(
          controller: viewModel.emailController,
          validator: (value) {
            return null;
          },
          onChanged: (p0) {
            viewModel.notifyListeners();
          },
        ),
        Gap($styles.insets.xs),
        Text(
          "In case you change your number and need account recovery. No spam, promise.",
          textAlign: TextAlign.start,
          style: $styles.text.labelMedium.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        Gap($styles.insets.m),
        const TextFieldLabel(title: "SIP SOCIAL ALIAS"),
        Gap($styles.insets.xs),
        CustomTextField(
          controller: viewModel.pincodeController,
          validator: (value) => viewModel.validateName(value),
          onChanged: (p0) {
            viewModel.notifyListeners();
          },
          onTap: () => viewModel.maintainTextFieldPosition(viewModel.mobileNumberEmailViewScrollController.position.maxScrollExtent / 2),
        ),
        Gap($styles.insets.xs),
        Text(
          "Choose a unique alias that represents you on SipSocial. This will be visible to others and helps you connect with fellow Sippers.",
          textAlign: TextAlign.start,
          style: $styles.text.labelMedium.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget personalDetailsViewFooterWidget({required MainViewModel viewModel}) {
  return Column(
    children: [
      CustomButton(
        title: 'Let’s Get Started!',
        onTap: () {
          viewModel.navigateToAllowNotification();
        },
        isDisable: viewModel.pincodeController.text.isEmpty,
      ),
      Gap($styles.insets.xs),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: $styles.insets.m),
        child: Text(
          "By continuing you will receive an SMS for \nverification. Message and data rates may apply.",
          textAlign: TextAlign.center,
          style: $styles.text.bodyMedium.copyWith(
            color: $styles.colors.black,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ),
      Gap($styles.insets.s),
    ],
  );
}
