import 'package:coffeshop/common/animation/animation_counter/AnimationCounter.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_cart.dart';
import 'package:coffeshop/notifier/cart_notifier.dart';
import 'package:coffeshop/notifier/order_detail_notifier.dart';
import 'package:coffeshop/screen/order_confirm.dart';
import 'package:coffeshop/widget/cart_widget/cart_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  bool showClose;
  Cart({this.showClose});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart>  with SingleTickerProviderStateMixin{
  @override
  void initState() {
    getData();
    super.initState();
  }
  void getData() async{
    await  Future.delayed(Duration(milliseconds: 1500),(){
      var cartVm = Provider.of<CartModel>(context,listen: false);
      cartVm.getCart(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final cartVm = Provider.of<CartModel>(context);
    final orderDetailVm = Provider.of<OrderDetailNotifier>(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: BASE_APP_COLOR,
          title: Text("Giỏ hàng"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: widget.showClose ? IconButton(
            icon: Icon(Icons.close, color:WHITE_COLOR),
            onPressed: () => Navigator.of(context).pop(),
          ) : null,
          actions: [
            cartVm.mCart != null && cartVm.mCart.data.length > 0 ? Container(
              margin: EdgeInsets.only(right: 10.0),
              alignment: Alignment.center,
              child: Text(
                  "Chọn tất cả",
                style: TextStyle(
                color: WHITE_COLOR,
                fontWeight: FontWeight.w700,
                fontSize: 13.0,
              ),
              ),
            ) : SizedBox(),
            cartVm.mCart != null && cartVm.mCart.data.length > 0 ? SizedBox(
              width:20.0,
              height: 20.0,
              child: Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.white,
                ),
                child: Checkbox(
                  value: cartVm.selectAll,
                  onChanged: (bool value) {
                    cartVm.onSelectAll(value);
                  },
                  activeColor: PRICE_COLOR,
                  focusColor: Colors.red,
                ),
              ),
            ) : SizedBox(),
            SizedBox(width: 20.0)
          ],
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child:SingleChildScrollView(
                    child: CartList())
              ),
              Container(
                color: BASE_APP_COLOR,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RaisedButton(
                          onPressed: () async{
                            if(cartVm.isActiveOrder){
                              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => OrderConfirm()));
                            }
                          },
                          color: cartVm.isActiveOrder ? PRICE_COLOR : Colors.grey,
                          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child:Text(
                            "Đặt hàng",
                            style: TextStyle(
                                color: WHITE_COLOR,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: AnimationCounter(
                        duration: Duration(milliseconds: 750),
                        value: cartVm.totalPrice.toInt(), /* pass in a number like 2014 */
                        color: Colors.white,
                        size: 16,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
