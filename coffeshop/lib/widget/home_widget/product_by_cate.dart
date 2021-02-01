import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/widget/error_widget/error_screen.dart';
import 'package:coffeshop/widget/home_widget/item_product.dart';
import 'package:coffeshop/widget/loading/circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductByCate extends StatefulWidget {
  String categoryName;
  String cateId;
  ProductByCate({this.categoryName,this.cateId});
  @override
  _ProductByCateState createState() => _ProductByCateState();
}

class _ProductByCateState extends State<ProductByCate> {
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
      pVM.getProduct(cateId: widget.cateId,page: 1);
    });
  }
  @override
  Widget build(BuildContext context) {
    final pVM = Provider.of<ProductModel>(context);
    if(pVM.mProductResult.loading){
        return CircularLoading();
    } else if(pVM.mProductResult.loaded){
      if(pVM.mProductList[widget.cateId] != null && pVM.mProductList[widget.cateId].length > 0){
        return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(10),
            child: StaggeredGridView.countBuilder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                padding: EdgeInsets.only(top:0.0),
                itemCount: pVM.mProductList[widget.cateId].length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemProduct(product:pVM.mProductList[widget.cateId][index]);
                },
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0
            )
        );
      } else {
        return Center(
          child: Text("Chưa có sản phẩm nào trong danh mục !",style: messageStyle),
        );
      }
    } else if(pVM.mProductResult.loadFailed){
        return ErrorScreen();
    }
  }
}
