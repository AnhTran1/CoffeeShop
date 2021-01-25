import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/widget/home_widget/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
enum CATEGORY  {COFFEE,TEA,CHOCOLATE,FOOD}
class Coffee extends StatefulWidget {
  CATEGORY category;
  Coffee({this.category});
  @override
  _CoffeeState createState() => _CoffeeState();
}

class _CoffeeState extends State<Coffee> {
  @override
  void initState() {
    setCategory();
    getData();
    super.initState();
  }

  getData(){
    var pVM = Provider.of<ProductModel>(context,listen: false);
    Future.delayed(Duration(milliseconds: 50),(){
      pVM.getProduct();
    });
  }
  void setCategory(){
    var prdVM = Provider.of<ProductDetailModel>(context,listen: false);
    switch(widget.category){
      case CATEGORY.COFFEE:
        Future.delayed(Duration(milliseconds: 50),(){
          prdVM.setCategory("Coffee");
        });
        break;
      case CATEGORY.TEA:
        Future.delayed(Duration(milliseconds: 50),(){
          prdVM.setCategory("Tea");
        });
      break;
      case CATEGORY.CHOCOLATE:
        Future.delayed(Duration(milliseconds: 50),(){
          prdVM.setCategory("Chocolate");
        });
        break;
      case CATEGORY.FOOD:
        Future.delayed(Duration(milliseconds: 50),(){
          prdVM.setCategory("Food");
        });
        break;
    }
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
