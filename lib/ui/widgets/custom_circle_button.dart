import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/widgets/app_icons.dart';

class CustomCircleButton extends StatefulWidget {
  final double? borderRadius;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool? isDisable;
  final bool isSecondary;
  final Color? backgroundColor;
  final AppIcons icon;
  final Function() onTap;

  const CustomCircleButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.isDisable = false,
    this.isSecondary = false,
    this.borderRadius,
    this.backgroundColor,
    this.buttonHeight = 55,
    this.buttonWidth = 55,
  }) : super(key: key);

  @override
  State<CustomCircleButton> createState() => _CustomCircleButtonState();
}

class _CustomCircleButtonState extends State<CustomCircleButton> {
  bool isButtonPressed = false;
  Color iconColor = $styles.colors.black;
  Color backgroundColor = $styles.colors.primaryPurpleColor;

  @override
  Widget build(BuildContext context) {
    if (widget.isSecondary) {
      iconColor = $styles.colors.black;
      backgroundColor = $styles.colors.white;
    }

    if (widget.isDisable!) {
      return Container(
        height: 55,
        width: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xffBBB7AD),
          ),
        ),
        child: Center(
          child: AppIcon(
            widget.icon,
            color: iconColor,
          ),
        ),
      );
    }

    return GestureDetector(
      onTapDown: (details) {
        buttonPressed(true);
        Future.delayed(const Duration(milliseconds: 200), () {
          widget.onTap();
        });
      },
      onLongPressEnd: (details) {
        buttonPressed(false);
      },
      onLongPressCancel: () {
        buttonPressed(false);
      },
      onTapUp: (details) {
        buttonPressed(false);
      },
      child: SizedBox(
        height: 65,
        width: 65,
        child: Stack(
          children: [
            Positioned(
              left: 5,
              bottom: 3,
              right: 3,
              child: Container(
                height: widget.buttonHeight,
                width: widget.buttonWidth,
                decoration: BoxDecoration(
                  color: $styles.colors.black,
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
                ),
              ),
            ),
            AnimatedPadding(
              duration: 100.ms,
              padding: EdgeInsets.only(
                right: isButtonPressed ? 4 : 10,
                left: isButtonPressed ? 4 : 0,
                bottom: isButtonPressed ? 0 : 10,
                top: isButtonPressed ? 6 : 0,
              ),
              child: Container(
                height: widget.buttonHeight,
                width: widget.buttonWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 4),
                  color: widget.backgroundColor ?? backgroundColor,
                  border: Border.all(
                    color: $styles.colors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: AppIcon(
                      widget.icon,
                      color: $styles.colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buttonPressed(bool value) {
    setState(() {
      isButtonPressed = value;
    });
  }
}
