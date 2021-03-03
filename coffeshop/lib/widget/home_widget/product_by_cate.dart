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
  bool isAdmin;
  ProductByCate({this.categoryName,this.cateId,this.isAdmin});
  @override
  _ProductByCateState createState() => _ProductByCateState();
}

class _ProductByCateState extends State<ProductByCate>   with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController( duration: const Duration(milliseconds: 750), vsync: this,animationBehavior: AnimationBehavior.preserve);
    initData();
    super.initState();
  }

  initData() async{
    var prdVM = Provider.of<ProductDetailModel>(context,listen: false);
    var pVM = Provider.of<ProductModel>(context,listen: false);
    await Future.delayed(Duration(milliseconds: 10),(){
      pVM.reCall();
      prdVM.setCategory(this.widget.categoryName);
      pVM.getProduct(cateId: widget.cateId,page: 1);
    });
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
                  final int count = pVM.mProductList[widget.cateId].length;
                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return ItemProduct(
                      animationController: animationController,
                      animation: animation,
                      product:pVM.mProductList[widget.cateId][index],
                      isAdmin: widget.isAdmin,
                      cateName: widget.categoryName,
                      cateId:widget.cateId
                  );
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
