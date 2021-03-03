import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/login_widget/text_field_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemAddress extends StatelessWidget {
  final String title;
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  const ItemAddress({
    Key key,
    this.title,
    this.hintText,
    this.onChanged,
    this.textEditingController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 140.0,
          padding: EdgeInsets.only(left: 10.0),
          child: Text("$title :",style: titleOrderDetail),
        ),
        Expanded(
          child: TextField(
            onChanged: onChanged,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 13.0,
              ),
              contentPadding: EdgeInsets.only(right: 10.0)
            ),
          ),
        ),
      ],
    );
  }
}
