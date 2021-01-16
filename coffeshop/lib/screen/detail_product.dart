import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class DetailProduct extends StatefulWidget {
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: Utils.width(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(7.0),topLeft: Radius.circular(7.0)),
                      child: CachedNetworkImage(
                        imageUrl: noImage,
                        placeholder: (context, url) =>  Image.asset(image_placeholder,fit: BoxFit.cover,),
                        errorWidget: (context, url, error) => Image.asset(image_placeholder,fit: BoxFit.cover),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: Utils.paddingTop(context),left: 16),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios,color: WHITE_COLOR)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
