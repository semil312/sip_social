// ignore_for_file: depend_on_referenced_packages

import 'package:sip_social/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final Function() onTap;
  final bool? isDisable;
  final bool isSecondary;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.isDisable = false,
    this.isSecondary = false,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isButtonPressed = false;
  Color textColor = $styles.colors.white;
  Color backgroundColor = $styles.colors.primaryPurpleColor;

  @override
  Widget build(BuildContext context) {
    if (widget.isSecondary) {
      textColor = $styles.colors.black;
      backgroundColor = $styles.colors.white;
    }

    if (widget.isDisable!) {
      return Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xffBBB7AD),
          ),
        ),
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: $styles.text.btn.copyWith(
              color: const Color(0xffBBB7AD),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
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
        child: Stack(
          children: [
            Positioned(
              left: 5,
              bottom: 3,
              right: 3,
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: $styles.colors.black,
                  borderRadius: BorderRadius.circular(4),
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
                height: 55,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: backgroundColor,
                  border: Border.all(
                    color: $styles.colors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      widget.title,
                      style: $styles.text.btn.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
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
