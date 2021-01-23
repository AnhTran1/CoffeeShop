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
      body: Container(
        width: Utils.width(context),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder (
                  padding: EdgeInsets.only(top: 10),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context,index) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: Utils.width(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(0.3), offset: Offset(0, 0), blurRadius: 4, spreadRadius:1.5)
                              ],
                              color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nhà',
                                      style:TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: BASE_APP_COLOR
                                      ),
                                    ),
                                    Text('Hà Nội'),
                                  ],
                                ),
                                Row(
                                  children: [

                                    MaterialButton(
                                      onPressed: () {

                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: BASE_APP_COLOR,
                                      ),
                                      padding: EdgeInsets.only(right: 5,left: 0,bottom: 0,top: 0),
                                      height: 20.0,
                                      minWidth: 20.0,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    MaterialButton(
                                      onPressed: () {

                                      },

                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: BASE_APP_COLOR,
                                      ),
                                      padding: EdgeInsets.zero,
                                      height: 20.0,
                                      minWidth: 20.0,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ],
                                )

                              ]
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    );
                  },
                )
            ),
            SizedBox(
              width: Utils.width(context),
              child: RaisedButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAddress()),
                );
              },
                  child: Text(
                    'Thêm địa chỉ',
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