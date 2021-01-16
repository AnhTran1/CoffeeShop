import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/home_widget/item_carousel.dart';
import 'package:flutter/material.dart';
class Coffee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body:SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: ItemCarousel(),
      )
    );
  }
}
