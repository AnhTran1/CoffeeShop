import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../common/Utils.dart';
import '../common/styles.dart';
class DetailProduct extends StatelessWidget {
  MProduct mProduct;
  DetailProduct({this.mProduct});
  @override
  Widget build(BuildContext context) {
    final prdVM = Provider.of<ProductDetailModel>(context);
    return Scaffold(
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
                        tag: mProduct.imgUrl,
                        child: SizedBox(
                          height: (Utils.height(context) / 3) + 50,
                          width: Utils.width(context),
                          child: CachedNetworkImage(
                            imageUrl: mProduct.imgUrl,
                            placeholder: (context, url) =>  Image.asset(image_placeholder,fit: BoxFit.cover,),
                            errorWidget: (context, url, error) => Image.asset(image_placeholder,fit: BoxFit.cover),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: Utils.paddingTop(context),left: 16),
                        padding: EdgeInsets.only(left: 7.0),
                        width: 35.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                            color: BASE_APP_COLOR,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Icon(Icons.arrow_back_ios,color: WHITE_COLOR)
                    ),
                  ),
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
                            mProduct.name,
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
                                        prdVM.onIncrement(double.parse(mProduct.price));
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
                                        prdVM.total < 10 ? "0${prdVM.total}" : "${prdVM.total}",
                                        textScaleFactor: 1.5,
                                        style: TextStyle(
                                          color: WHITE_COLOR,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16.0,
                                        )
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        prdVM.onDecrease(double.parse(mProduct.price));
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
                          ),
                          Padding(
                            padding:EdgeInsets.only(left: 16.0),
                            child: Text(
                              "${prdVM.totalPrice} VND",
                              style: priceDetail,
                            ),
                          ),
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
}
