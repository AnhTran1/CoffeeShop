import 'dart:ui';

import 'package:coffeshop/admin/category_detail.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/widget/home_widget/product_by_cate.dart';
import 'package:coffeshop/widget/item_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final pVM = Provider.of<ProductModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BASE_APP_COLOR,
        title: Text("Danh mục sản phẩm"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              child: StaggeredGridView.countBuilder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  padding: EdgeInsets.only(top:0.0),
                  itemCount: pVM.mCategory.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CategoryDetail(title: pVM.mCategory.data[index].name,id: pVM.mCategory.data[index].id)));
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 16.0,right: 16.0,bottom: 30,top: 30),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(7.0)),
                              boxShadow: [
                                BoxShadow(color: GREY_COLOR, offset: Offset(0, 0), blurRadius: 3, spreadRadius: 1)
                              ],
                            ),
                            child: Text(
                              pVM.mCategory.data[index].name,
                              style: TextStyle(
                                color: BASE_APP_COLOR,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: BASE_APP_COLOR,
                              borderRadius: BorderRadius.only(topRight:Radius.circular(7.0),bottomLeft: Radius.circular(40.0))
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0
              )
          )),
          InkWell(
            onTap: (){
              showModal(context);
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
                  Text("Thêm danh mục",style: addressStyle),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
  showModal(context,){
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                height: 300,
                child: Column(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 10.0),
                          child: Text("Thêm danh mục",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: BASE_APP_COLOR)),
                        ),
                        ItemAddress(
                          title: "Tên danh mục",
                          hintText: "nhập tên danh mục",
                          onChanged: (value) {},
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        ItemAddress(
                          title: "Mô tả",
                          hintText: "Nhập mô tả",
                          onChanged: (value) {},
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                          onPressed: () async{
                          },
                          color: PRICE_COLOR,
                          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child:Text(
                            "Thêm",
                            style: TextStyle(
                                color: WHITE_COLOR,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0
                            ),
                          )
                      ),
                    ),
                  ],
                )
            ));
      },
    );
  }
}
