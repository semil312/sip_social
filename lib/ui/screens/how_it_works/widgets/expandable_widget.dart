import 'package:flutter/material.dart';
import 'package:sip_social/main.dart';
import 'package:sip_social/ui/widgets/app_icons.dart';
import 'package:sip_social/ui/widgets/custom_circle_button.dart';

class ExpandableWidget extends StatefulWidget {
  final String title;
  final String caption;
  final AppIcons icon;
  final bool hasDivider;

  const ExpandableWidget({
    Key? key,
    required this.title,
    required this.caption,
    required this.icon,
    required this.hasDivider,
  }) : super(key: key);

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool isExpanded = false;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          collapsedTextColor: $styles.colors.black,
          title: Text(
            widget.title,
            style: $styles.text.titleMedium.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: $styles.colors.black,
            ),
          ),
          shape: InputBorder.none,
          leading: AppIcon(
            widget.icon,
            size: 30,
          ),
          trailing: SizedBox(
            height: 38,
            width: 38,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: $styles.colors.black,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: isExpanded ? $styles.colors.primaryPurpleColor : $styles.colors.primaryOrangeColor,
                        border: Border.all(
                          color: $styles.colors.black,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular($styles.corners.lg)),
                    child: Center(
                      child: AppIcon(
                        isExpanded ? AppIcons.hiw_minus : AppIcons.hiw_plus,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // trailing: CustomCircleButton(
          //   backgroundColor: isExpanded ? $styles.colors.primaryPurpleColor : $styles.colors.primaryOrangeColor,
          //   icon: isExpanded ? AppIcons.hiw_minus : AppIcons.hiw_plus,
          //   onTap: () {
          //     setState(() {
          //       isExpanded = !isExpanded;
          //     });
          //   },
          //   buttonHeight: 40,
          //   buttonWidth: 40,
          // ),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $styles.insets.xl, vertical: $styles.insets.xs),
              child: Text(
                widget.caption,
                style: $styles.text.bodyMedium.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        widget.hasDivider
            ? Divider(
                thickness: 2,
                color: $styles.colors.black,
              )
            : Container(),
      ],
    );
  }
}
