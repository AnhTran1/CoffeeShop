import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/order_status/Item_order_status.dart';
import 'package:flutter/material.dart';
enum STATUS {PROCESSING,SHIPPING,COMPLETED}
class OrderStatusByType extends StatefulWidget {
  STATUS status;
  OrderStatusByType({this.status});
  @override
  _OrderStatusByTypeState createState() => _OrderStatusByTypeState();
}

class _OrderStatusByTypeState extends State<OrderStatusByType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WHITE_COLOR,
        body:SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(10),
          child: ItemOrderStatus(),
        )
    );
  }
}
