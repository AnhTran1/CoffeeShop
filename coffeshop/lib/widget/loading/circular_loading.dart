import 'package:coffeshop/common/styles.dart';
import 'package:flutter/material.dart';
class CircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: BASE_APP_COLOR,
        valueColor: AlwaysStoppedAnimation<Color>(GREY_COLOR),
      ),
    );
  }
}
