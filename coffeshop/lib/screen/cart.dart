import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/cart_notifier.dart';
import 'package:coffeshop/widget/cart_widget/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  bool showClose;
  Cart({this.showClose});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart>  with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> offsetAnimation;
  @override
  void initState() {
    getData();
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    offsetAnimation = Tween(begin: 0.0, end: 5.0).chain(CurveTween(curve: Curves.elasticIn)).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    super.initState();
  }
  getData(){
    var cartVm = Provider.of<CartModel>(context,listen: false);
    Future.delayed(Duration(milliseconds: 50),(){
      cartVm.getCart();
    });
  }
  @override
  Widget build(BuildContext context) {
    final cartVm = Provider.of<CartModel>(context);
    if(cartVm.changePrice){
      controller.forward(from: 0.0);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BASE_APP_COLOR,
        title: Text("Cart"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: widget.showClose ?IconButton(
          icon: Icon(Icons.close, color:WHITE_COLOR),
          onPressed: () => Navigator.of(context).pop(),
        ) : null,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            alignment: Alignment.center,
            child: Text(
                "Select all",
              style: TextStyle(
              color: WHITE_COLOR,
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
            ),
            ),
          ),
          SizedBox(
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
                  controller.forward(from: 0.0);
                },
                activeColor: PRICE_COLOR,
                focusColor: Colors.red,
              ),
            ),
          ),
          SizedBox(width: 20.0)
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: CartList(cartList: cartVm.cartList),
              ),
            ),
            Container(
              color: BASE_APP_COLOR,
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RaisedButton(
                        onPressed: (){

                        },
                        color: PRICE_COLOR,
                        disabledColor: PRICE_COLOR,
                        padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Text(
                          "Order Now",
                          style: TextStyle(
                              color: TAB_COLOR,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0
                          ),
                        )
                    ),
                  ),AnimatedBuilder(
                    animation: offsetAnimation,
                    builder: (buildContext, child) {
                      return Container(
                        padding: EdgeInsets.only(left: 16.0,top: offsetAnimation.value + 5.0, bottom: 5.0 - offsetAnimation.value),
                        child: Text( "${cartVm.totalPrice} VND", style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                        )),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}
