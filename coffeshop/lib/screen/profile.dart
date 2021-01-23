import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/screen/address_list.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trang cá nhân"
        ),
        backgroundColor: BASE_APP_COLOR,
        actions: [
          MaterialButton(
            onPressed: () {

            },
            child: Icon(
              Icons.logout,
              size: 20,
              color: Colors.white,
            ),
            padding: EdgeInsets.only(right: 10,left: 10,bottom: 0,top: 0),
            height: 20.0,
            minWidth: 20.0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
      body: Container(
        width: Utils.width(context),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: BASE_APP_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 4, spreadRadius:1.5)
                        ]),
                    child: Row(
//                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            'assets/image/user.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tran Tuan Anh',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            Text(
                              'tuananbk93@gmail.com',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context,index) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tên địa chỉ:',
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: BASE_APP_COLOR
                                ),
                              ),
                              Text('Nhà của Tuấn Anh'),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Utils.width(context),
              child: RaisedButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressList()),
                );
              },
                  child: Text(
                    'Danh sách địa chỉ',
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
