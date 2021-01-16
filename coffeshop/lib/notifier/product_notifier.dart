import 'package:coffeshop/common/dumy/product.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:flutter/cupertino.dart';

class ProductModel extends ChangeNotifier {
  List<MProduct> productList = new List();
  void getProduct() {
    if(productList.length == 0){
      productList = ProductList().arr.map((value) => MProduct.fromJson(value)).toList();
    }
    notifyListeners();
  }
}