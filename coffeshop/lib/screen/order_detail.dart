import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/screen/create_address.dart';
import 'package:flutter/material.dart';
class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Chi tiết đặt hàng'
        ),
        backgroundColor: BASE_APP_COLOR,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child:SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (item, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 100,
                          color: BASE_APP_COLOR,
                        );
                      }),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Phí dịch vụ:'),
                            Text('30.000 VND'),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền:'),
                            Text('100.000 VND'),
                          ],
                        ),
                      )
                    ],
                  ),
            )

            ),
            SizedBox(
              width: Utils.width(context),
              child: RaisedButton(onPressed: () {

              },
                  child: Text(
                    'Thanh toán',
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