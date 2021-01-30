import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/widget/home_widget/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class Coffee extends StatefulWidget {
  String categoryName;
  Coffee({this.categoryName});
  @override
  _CoffeeState createState() => _CoffeeState();
}

class _CoffeeState extends State<Coffee> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async{
    var prdVM = Provider.of<ProductDetailModel>(context,listen: false);
    var pVM = Provider.of<ProductModel>(context,listen: false);
    await Future.delayed(Duration(milliseconds: 350),(){
      prdVM.setCategory(this.widget.categoryName);
      pVM.getProduct();
    });
  }
  @override
  Widget build(BuildContext context) {
    final pVM = Provider.of<ProductModel>(context);
    return Scaffold(
        backgroundColor: WHITE_COLOR,
        body: pVM.productList != null ? SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(10),
          child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              padding: EdgeInsets.only(top:0.0),
              itemCount: pVM.productList.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemProduct(product:pVM.productList[index]);
              },
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0
          )
        ) : SizedBox()
    );
  }
}
