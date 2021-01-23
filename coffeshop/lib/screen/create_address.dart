import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/login_widget/rounded_input_field.dart';
import 'package:flutter/material.dart';
class CreateAddress extends StatefulWidget {
  @override
  _CreateAddressState createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Thêm địa chỉ'
        ),
        backgroundColor: BASE_APP_COLOR,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        width: Utils.width(context),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: Container (
                  child: Column(
                    children: [
                      RoundedInputField(
                        hintText: "Tên địa chỉ",
                        onChanged: (value) {},
                        icon: Icons.email,
                      ),
                      RoundedInputField(
                        hintText: "Số điện thoại",
                        onChanged: (value) {},
                        icon: Icons.email,
                      ),
                      RoundedInputField(
                        hintText: "Chi tiết địa chỉ",
                        onChanged: (value) {},
                        icon: Icons.email,
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(
              width: Utils.width(context),
              child: RaisedButton(onPressed: () {

              },
                  child: Text(
                    'Thêm',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: PRICE_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  )),
            )
          ],
        ),
      ),
    );
  }
}