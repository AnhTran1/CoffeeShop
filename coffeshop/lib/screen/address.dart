import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/item_address.dart';
import 'package:flutter/material.dart';
class Address extends StatefulWidget {
  // type = add && edit
  String  type;
  Address({this.type});
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  var arrList = ["Họ và tên","Số địa thoại","Địa chỉ chi tiết"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm địa chỉ"),
        backgroundColor: BASE_APP_COLOR,
        centerTitle: true,
      ),
      body:Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                  itemCount: arrList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ItemAddress(
                          title: arrList[index],
                          hintText: arrList[index],
                          onChanged: (value){},
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        )
                      ],
                    );
                  }
              ),
            ),
          ),
          Container(
            width: Utils.width(context),
            padding: EdgeInsets.only(left: 10.0,right: 10.0),
            child: RaisedButton(
              onPressed: (){
              },
              color: PRICE_COLOR,
              disabledColor: PRICE_COLOR,
              padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Text(
                "Xác nhận đơn hàng",
                style: TextStyle(
                    color: WHITE_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}


