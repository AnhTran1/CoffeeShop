import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:coffeshop/screen/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class ItemProduct extends StatelessWidget {
  MProduct product;
  ItemProduct({this.product});
  @override
  Widget build(BuildContext context) {
    final prdVM = Provider.of<ProductDetailModel>(context);
    return InkWell(
      onTap: (){
        prdVM.initData(product.price.toDouble());
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => DetailProduct(mProductData: product),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 350),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment:Alignment.topRight,
              children: [
                SizedBox(
                  child: Hero(
                    tag: product.id.toString()  + product.name,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      child: CachedNetworkImage(
                        imageUrl: product.fileImage != null ? product.fileImage : noImage1,
                        placeholder: (context, url) =>  Image.asset(image_placeholder,fit: BoxFit.cover,height: 200),
                        errorWidget: (context, url, error) => Image.asset(image_placeholder,fit: BoxFit.cover,height: 200),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: BASE_APP_COLOR
                      ),
                      child: Icon(Icons.add,color: WHITE_COLOR),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7.0),bottomRight:Radius.circular(7.0))
              ),
              padding:const EdgeInsets.all(10.0),
              width: Utils.width(context) - 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,style: title),
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text("${product.price}",style: price)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
