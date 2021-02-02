import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/animation/animation_counter/AnimationCounter.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_cart.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:coffeshop/notifier/cart_notifier.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:coffeshop/screen/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_sidekick/flutter_sidekick.dart';
import 'package:provider/provider.dart';

import '../common/Utils.dart';
import '../common/styles.dart';
// ignore: must_be_immutable
class DetailProduct extends StatefulWidget {
  MProduct mProductData;
  DetailProduct({this.mProductData});
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  SidekickController controller;
  @override
  void initState() {
    controller = SidekickController(vsync: this, duration: Duration(milliseconds: 1000));
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final prdVM = Provider.of<ProductDetailModel>(context);
    final cartVM = Provider.of<CartModel>(context);
    return Scaffold(
        key: _key,
        body:  Container(
          height: Utils.height(context),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Hero(
                        tag: widget.mProductData.id.toString() + widget.mProductData.name,
                        child: SizedBox(
                          height: (Utils.height(context) / 3) + 50,
                          width: Utils.width(context),
                          child: CachedNetworkImage(
                            imageUrl: widget.mProductData.fileImage,
                            placeholder: (context, url) =>  Image.asset(image_placeholder,fit: BoxFit.cover,),
                            errorWidget: (context, url, error) => Image.asset(image_placeholder,fit: BoxFit.cover),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: Utils.paddingTop(context),left: 16),
                            padding: EdgeInsets.only(left: 7.0),
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                                color: BASE_APP_COLOR,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Icon(Icons.arrow_back_ios,color: WHITE_COLOR)
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(_createRoute());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 16.0,top:Utils.paddingTop(context)),
                            child: Stack(
                              alignment: AlignmentDirectional(0.8, -0.8),
                              children: <Widget>[
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: BASE_APP_COLOR,
                                    )),
                                Stack(
                                  children: [
                                    Sidekick(
                                      tag: 'source',
                                      targetTag: 'target',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        child: CircleAvatar(
                                            radius: 10.0,
                                            child: Image.network(noImage1,width: 24,height: 24,fit: BoxFit.cover)
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 10.0,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        "${prdVM.badge}",
                                        style: TextStyle(color: Colors.white, fontSize: 13.0),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
              Container(
                height: (Utils.height(context) / 3) * 2 ,
                width: Utils.width(context),
                decoration: BoxDecoration(
                    color: BASE_APP_COLOR,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.mProductData.name,
                            style: titleDetail,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16.0)),
                              color: PRICE_COLOR,
                            ) ,
                            padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 2.0,bottom: 2.0),
                            child: Text(prdVM.category),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.0,bottom: 10.0),
                            child: Text(
                              "About",
                              style: title,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "Cà phê espresso được đổ vào đáy cốc, tiếp theo là một lượng sữa nóng tương tự, được chuẩn bị bằng cách làm nóng và tạo kết cấu sữa bằng vòi hơi của máy pha cà phê espresso. Phần ba trên cùng của thức uống bao gồm bọt sữa; bọt này có thể được trang trí bằng các hình vẽ nghệ thuật được làm bằng cùng một loại sữa, được gọi là nghệ thuật pha cà phê .",
                                  style: descriptionDetail,
                                ),
                              ),
                              Container(
                                height: 175.0,
                                width: 50,
                                margin: EdgeInsets.only(left: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    color:ITEM_COLOR
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        prdVM.onIncrement(widget.mProductData.price);
                                      },
                                      color: PRICE_COLOR,
                                      textColor: Colors.white,
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                      ),
                                      padding: EdgeInsets.all(5.0),
                                      shape: CircleBorder(),
                                    ),
                                    Text(
                                        prdVM.totalQuantity < 10 ? "0${prdVM.totalQuantity}" : "${prdVM.totalQuantity}",
                                        textScaleFactor: 1.5,
                                        style: TextStyle(
                                          color: WHITE_COLOR,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16.0,
                                        )
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        prdVM.onDecrease(widget.mProductData.price);
                                      },
                                      color: BASE_APP_COLOR,
                                      textColor: Colors.white,
                                      child: Icon(
                                        Icons.remove,
                                        size: 18,
                                      ),
                                      padding: EdgeInsets.all(5.0),
                                      shape: CircleBorder(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Stack(
                              fit: StackFit.passthrough,
                              children: [
                                RaisedButton(
                                    onPressed: () async{
                                      Utils.showLoading(context);
                                      prdVM.addCart(widget.mProductData.id, prdVM.totalQuantity).then((value) {
                                        if(value.loaded){
                                          cartVM.updateByAddCart().then((value) async{
                                            Navigator.pop(context);
                                            if(value.loaded){
                                              prdVM.initData(widget.mProductData.price);
                                              MCart mCart = MCart.fromJson(value.data);
                                              controller.moveToSource(context);
                                              await Future.delayed(Duration(milliseconds: 1000),(){
                                                prdVM.setBadge(mCart.data.length);
                                              });
                                            }
                                          });
                                        } else if(value.loadFailed){
                                          Navigator.pop(context);
                                          Utils.showAlertMessage(context, value.message);
                                        }
                                      });
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
                                Sidekick(
                                  tag: 'target',
                                  child: RaisedButton(
                                      onPressed: () async{
                                        Utils.showLoading(context);
                                        prdVM.addCart(widget.mProductData.id, prdVM.totalQuantity).then((value) {
                                          if(value.loaded){
                                            cartVM.updateByAddCart().then((value) async{
                                              Navigator.pop(context);
                                              if(value.loaded){
                                                prdVM.initData(widget.mProductData.price);
                                                MCart mCart = MCart.fromJson(value.data);
                                                controller.moveToSource(context);
                                                await Future.delayed(Duration(milliseconds: 1000),(){
                                                  prdVM.setBadge(mCart.data.length);
                                                });
                                              }
                                            });
                                          } else if(value.loadFailed){
                                            Navigator.pop(context);
                                            Utils.showAlertMessage(context, value.message);
                                          }
                                        });
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
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: AnimationCounter(
                              duration: Duration(milliseconds: 750),
                              value: prdVM.totalPrice.toInt(), /* pass in a number like 2014 */
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Cart(showClose: true),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

