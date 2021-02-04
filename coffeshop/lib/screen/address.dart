import 'package:coffeshop/common/styles.dart';
import 'package:flutter/material.dart';
class Address extends StatefulWidget {
  // type = add && edit
  String  type;
  Address({this.type});
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm địa chỉ"),
        backgroundColor: BASE_APP_COLOR,
        centerTitle: true,
      ),
      body:SingleChildScrollView(

      ),
    );
  }
}

