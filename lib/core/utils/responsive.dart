import 'package:flutter/material.dart';

class Responsive {
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
