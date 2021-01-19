import 'package:coffeshop/common/styles.dart';
import 'package:flutter/material.dart';
class OrderStatusDetail extends StatefulWidget {
  @override
  _OrderStatusDetailState createState() => _OrderStatusDetailState();
}

class _OrderStatusDetailState extends State<OrderStatusDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Status Detail"),
        centerTitle: true,
        backgroundColor: BASE_APP_COLOR,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#999",
                  style: TextStyle(
                    color: Colors.black ,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "ETA: 20 mins",
                  style: TextStyle(
                    color: Colors.black ,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            ListView.builder(
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:35,
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                          "10:00 AM",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        color: Colors.black ,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        children: [
                          MaterialButton(
                            onPressed: () {
                            },
                            color: index == 0 || index == 1 ? Colors.red : Colors.grey,
                            textColor: Colors.white,
                            child: Icon(
                              index == 0 ? Icons.watch_later_sharp : index == 1 ? Icons.confirmation_num : index == 2 ? Icons.drive_eta : Icons.done,
                              size: 20,
                            ),
                            padding: EdgeInsets.all(5.0),
                            shape: CircleBorder(),
                            height: 40.0,
                            minWidth: 40.0,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          index != 3 ? Container(
                            width: 1,
                            height: 70,
                            color: Colors.red,
                          ) : SizedBox()
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              index == 0 ? "Oder Placed" : index == 1 ? "Accepted by Restaurant" : index == 2 ? "Picked Up By Delivery Driver" : "Delivered",
                              style: TextStyle(
                                color: index == 0 || index == 1 ? Colors.red : Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              index == 0 ? "Order Received. Awaiting restaurant confirmation" : index == 1 ? "Accepted By Delivery Driver Delivery Driver is on a way to the restaurant to pickupp the order" : index == 2 ? "Picked Up By Delivery Driver Delivery Driver has picked up the order Food is on way to deliver" : "Delivered",
                              style: TextStyle(
                                color: index == 0 || index == 1 ? Colors.black : Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        )
      ),
    );
  }
}
