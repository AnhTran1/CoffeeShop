import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/login_widget/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: BASE_APP_COLOR,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
