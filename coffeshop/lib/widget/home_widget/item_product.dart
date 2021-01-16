import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:coffeshop/screen/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class ItemProduct extends StatelessWidget {
  List<MProduct> product;
  ItemProduct({this.product});
  @override
  Widget build(BuildContext context) {
    return product.length > 0 ? StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        padding: EdgeInsets.only(top:0.0),
        itemCount: product.length,
        itemBuilder: (BuildContext context, int index) {
          return item(context,product[index]);
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0
    ) : Container(
      height: (Utils.height(context) / 3) * 2,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: BASE_APP_COLOR,
        ),
      ),
    );
  }
}
Widget item(context,MProduct product){
  final prdVM = Provider.of<ProductDetailModel>(context);
  return InkWell(
    onTap: (){
      prdVM.initData(double.parse(product.price));
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => DetailProduct(mProduct: product),
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
                  tag: product.imgUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    child: CachedNetworkImage(
                      imageUrl: product.imgUrl,
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
                    child: Text(product.price,style: price)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
