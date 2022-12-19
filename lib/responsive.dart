import 'package:flutter/material.dart';

double responsiveHeight(double height, BuildContext context) {
  var mediaQuery = MediaQuery.of(context).size;
  var divide = 920 / height;
  var height1 = mediaQuery.height / divide;
  return height1;
}

double responsiveWidth(double width, BuildContext context) {
  var mediaQuery = MediaQuery.of(context).size;

  var divide = 390 / width;
  var width1 = mediaQuery.width / divide;
  return width1;
}

double responsiveText(double size, BuildContext context) {
  return (responsiveHeight(size, context) + responsiveWidth(size, context)) / 2;
}

double responsiveHeightLogin(double height, BuildContext context) {
  var mediaQuery = MediaQuery.of(context).size;
  var divide = 880 / height;
  var height1 = mediaQuery.height / divide;
  return height1;
}

double responsiveWidthLogin(double width, BuildContext context) {
  var mediaQuery = MediaQuery.of(context).size;

  var divide = 390 / width;
  var width1 = mediaQuery.width / divide;
  return width1;
}

double responsiveTextLogin(double size, BuildContext context) {
  return (responsiveHeightLogin(size, context) +
          responsiveWidthLogin(size, context)) /
      2;
}
