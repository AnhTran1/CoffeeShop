import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/login_widget/text_field_container.dart';
import 'package:flutter/material.dart';
class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hint;
  const RoundedPasswordField({
    Key key,
    this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          icon: Icon(
            Icons.lock,
            color: BASE_APP_COLOR,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
