import 'package:flutter/material.dart';

class Utils {
  static width(context) {
    return MediaQuery.of(context).size.width;
  }

  static height(context) {
    return MediaQuery.of(context).size.height;
  }
  static paddingBottom(context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static paddingTop(context) {
    return MediaQuery.of(context).padding.top;
  }
}
