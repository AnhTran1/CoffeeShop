import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeshop/admin/add_item_cate.dart';
import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/screen/detail_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class ItemProduct extends StatelessWidget {
  ItemProduct({Key key,this.product,this.animationController,this.animation,this.isAdmin,this.cateName,this.cateId}): super(key: key);
  MProduct product;
  String cateName;
  String cateId;
  bool isAdmin;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  @override
  Widget build(BuildContext context) {
    final prdVM = Provider.of<ProductDetailModel>(context);
    final pVM = Provider.of<ProductModel>(context);
    print(cateName);
    return AnimatedBuilder(
      animation: animationController,
     builder: (context, child) {
       return FadeTransition(
       opacity: animation,
         child: InkWell(
           onTap: (){
             prdVM.initData(product.price);
             Navigator.push(
               context,
               PageRouteBuilder(
                 pageBuilder: (c, a1, a2) => DetailProduct(mProductData: product,isAdmin: isAdmin,cateName: cateName),
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
                     isAdmin ? Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           InkWell(
                             onTap: (){
                               Provider.of<ProductModel>(context,listen: false).setEditItemControl(name: product.name,quantity: product.quantity,price: product.price,description: product.description);
                               Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddItemCate(cateId: cateId,isAdd: false,imageLink: product.fileImage,id: product.id.toString())));
                             },
                             child: Container(
                               padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 10.0,right: 10.0),
                               decoration: BoxDecoration(
                                 color: BASE_APP_COLOR,
                                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
                               ),
                               child: Text('Sửa',style: profileMail),
                             ),
                           ),
                           SizedBox(width: 5.0),
                           InkWell(
                             onTap: () async{
                               Utils.showAlertConfirm("Thông báo", "Xác nhận xóa danh mục: ${product.name}", "Hủy", "Đồng ý", context, () {
                                 Utils.showLoading(context);
                                 ApiResponse.removeItem(field: [{"item_id":product.id}]).then((value){
                                   Navigator.pop(context);
                                   if(value.loaded){
                                     pVM.getProduct(cateId: cateId,page: 1);
                                     Utils.showAlertMessage(context, "Xóa thành công");
                                   } else if(value.loadFailed) {
                                     Utils.showAlertMessage(context, value.message);
                                   }
                                 });
                               });
                             },
                             child: Container(
                                 padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 10.0,right: 10.0),
                                 decoration: BoxDecoration(
                                   color: Colors.red,
                                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                 ),
                                 child: Text('Xóa',style: profileMail),
                             ),
                           ),
                         ],
                       ),
                     ) : SizedBox(),
                     isAdmin ?  SizedBox() : Row(
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
                           child: Text("${product.price}.0 VND",style: price)),
                     ],
                   ),
                 )
               ],
             ),
           ),
         ),
       );
     },
    );
  }
}
