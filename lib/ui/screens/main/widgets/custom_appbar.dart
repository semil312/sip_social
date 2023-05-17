import 'package:flutter/material.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/screens/main/main_viewmodel.dart';
import 'package:sip_social/ui/widgets/app_icons.dart';
import 'package:stacked/stacked.dart';

class CustomAppBar extends ViewModelWidget<MainViewModel> {
  final int pageIndex;
  final int previousPageIndex;
  final bool hasSkipButton;
  final Function() onSkip;

  const CustomAppBar({
    Key? key,
    required this.pageIndex,
    required this.hasSkipButton,
    required this.onSkip,
    required this.previousPageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel viewModel) {
    return AppBar(
      backgroundColor: $styles.colors.backgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          viewModel.setIndex(index: previousPageIndex);
        },
        icon: pageIndex == 0 ? Container() : const AppIcon(AppIcons.arrow_left_cupertino),
      ),
      centerTitle: true,
      title: SizedBox(
        height: 6,
        child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return indicator(isActive: index == pageIndex);
          },
        ),
      ),
      actions: [
        hasSkipButton
            ? Padding(
                padding: EdgeInsets.only(right: $styles.insets.s),
                child: Center(
                  child: GestureDetector(
                    onTap: onSkip,
                    child: Text(
                      "Skip",
                      style: $styles.text.bodyMedium.copyWith(
                        color: $styles.colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}

Widget indicator({required bool isActive}) {
  return Padding(
    padding: const EdgeInsets.only(right: 4),
    child: Container(
      width: isActive ? 30 : 8,
      decoration: BoxDecoration(
        color: isActive ? $styles.colors.primaryPurpleColor : $styles.colors.dotColor,
        borderRadius: BorderRadius.circular($styles.corners.xs),
      ),
    ),
  );
}
