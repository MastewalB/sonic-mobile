import 'package:flutter/material.dart';

class MediaQueryManager {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double safeAreaHorizontal;
  static late double safeAreaVertical;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    final EdgeInsets padding = _mediaQueryData.padding;
    safeAreaHorizontal = (screenWidth - padding.left - padding.right) / 100;
    safeAreaVertical = (screenHeight - padding.top - padding.bottom) / 100;
  }

  static double getSafeAreaPaddingTop() {
    return _mediaQueryData.padding.top;
  }

  static double getSafeAreaPaddingBottom() {
    return _mediaQueryData.padding.bottom;
  }

  static double getSafeAreaPaddingLeft() {
    return _mediaQueryData.padding.left;
  }

  static double getSafeAreaPaddingRight() {
    return _mediaQueryData.padding.right;
  }
}
