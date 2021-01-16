import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/screen/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class ItemCarousel extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        padding: EdgeInsets.only(top:0.0),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return item(context,index);
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0
    );
  }
}
Widget item(context,index){
  return InkWell(
    onTap: (){
      Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(pageBuilder: (_, __, ___) => new DetailProduct()));
    },
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFF7F460A),
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment:Alignment.topRight,
            children: [
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  child: CachedNetworkImage(
                    imageUrl: index %2 == 0 ? noImage :noImage1,
                    placeholder: (context, url) =>  Image.asset(image_placeholder,fit: BoxFit.cover,),
                    errorWidget: (context, url, error) => Image.asset(image_placeholder,fit: BoxFit.cover),
                    fit: BoxFit.cover,
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
                Text("Cappuchino $index",style: title),
                Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text("10.000 VND",style: price)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
