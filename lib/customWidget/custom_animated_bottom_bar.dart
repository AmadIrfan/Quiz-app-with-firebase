import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/utility/app_theme.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';

import '../resizer/fetch_pixels.dart';
import '../resizer/widget_utils.dart';
import '../utility/constants.dart';

class CustomAnimatedBottomBar extends StatelessWidget {
  const CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    required this.backgroundColor,
    required this.isDarkMode,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 4),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final bool isDarkMode;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: SafeArea(
        child: Container(
          height: containerHeight,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              if (showElevation)
                BoxShadow(
                  color: getShadowColor(context),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  containerHeight: containerHeight,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: backgroundColor,
                  itemCornerRadius: itemCornerRadius,
                  isDarkMode: isDarkMode,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final bool isDarkMode;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final double containerHeight;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.isDarkMode,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.containerHeight,
    required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    double width = (FetchPixels.getWidthPercentSize(100) / 4.3);
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? (width * 1.2) : (width / 1.1),
            color: backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isSelected
                    ? Container(
                        height: FetchPixels.getPixelWidth(105),
                        width: FetchPixels.getPixelWidth(105),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: primaryColor
                                      .withOpacity(isDarkMode ? 0.1 : 0.3),
                                  spreadRadius: 0,
                                  blurRadius: isDarkMode ? 3 : 10,
                                  offset: Offset(0, isDarkMode ? 5 : 3))
                            ]),
                        child: Center(
                          child: Image.asset(
                            isSelected
                                ? '${tabAssetPath}selected_${item.imageName!}'
                                : tabAssetPath + item.imageName!,
                            height: (item.iconSize! / 1.1),
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          (isDarkMode)
                              ? '${tabAssetPath}dark_${item.imageName!}'
                              : '$tabAssetPath${item.imageName!}',
                          height: (item.iconSize! / 1.3),
                        ),
                      ),
                getHorizontalSpace(15),
                if (isSelected)
                  Expanded(
                    flex: 1,
                    child: getCustomFont(
                        item.title!,
                        FetchPixels.getPixelHeight(80),
                        getFontColor(context),
                        1,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w600),
                  )
                else
                  Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
    this.imageName,
    this.iconSize,
    this.title,
  });

  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
  final String? imageName;
  final String? title;
  final double? iconSize;
}
