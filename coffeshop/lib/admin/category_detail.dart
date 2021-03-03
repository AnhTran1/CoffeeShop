import 'package:coffeshop/admin/add_item_cate.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/home_widget/product_by_cate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class CategoryDetail extends StatefulWidget {
  String title;
  int id;
  CategoryDetail({this.title,this.id});
  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: ProductByCate(cateId:  (widget.id - 1).toString(),categoryName:widget.title,isAdmin: true)),
          InkWell(
            onTap: (){
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddItemCate(cateId: (widget.id - 1).toString())));
            },
            child: Container(
              decoration: CustomDecoration,
              height: 75.0,
              width: Utils.width(context) - 20,
              margin: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,color: Colors.black38),
                  Text("Thêm sản phẩm",style: addressStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
