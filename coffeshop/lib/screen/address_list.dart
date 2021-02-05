import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/screen/create_address.dart';
import 'package:flutter/material.dart';
class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Danh sách địa chỉ'
        ),
        backgroundColor: BASE_APP_COLOR,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 10.0,right: 10.0),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){

                        },
                        child: Container(
                          decoration: CustomDecoration,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Nguyễn Hồng Quang",style: titleOrderDetail),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap:(){},
                                        child: Icon(Icons.edit,color: BASE_APP_COLOR),
                                      ),
                                      SizedBox(width: 5.0),
                                      InkWell(
                                        onTap:(){},
                                        child: Icon(Icons.delete,color: BASE_APP_COLOR),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.phone,color: Colors.black38),
                                  SizedBox(width: 5.0),
                                  Text("0384453681",style: addressStyle),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on,color: Colors.black38),
                                  SizedBox(width: 5.0),
                                  Flexible(child: Text("Chung cư N04B2,khu đô thị cầu giấy, hà nội khu đô thị cầu giấy, hà nội ",style: addressStyle)),
                                ],
                              ),
                              index == 0 ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Địa chỉ mặc định",style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0
                                  )),
                                ],
                              ) : SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      decoration: CustomDecoration,
                      height: 100,
                      width: Utils.width(context) - 20,
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,color: Colors.black38),
                          Text("Thêm địa chỉ",style: addressStyle),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}