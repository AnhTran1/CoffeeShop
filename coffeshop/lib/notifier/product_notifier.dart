import 'dart:convert';

import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/common/dumy/product.dart';
import 'package:coffeshop/model/m_category.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:flutter/cupertino.dart';

class ProductModel extends ChangeNotifier {
  MCategory mCategory;
  List<MProduct> productList = new List();

  Future getCategory() async{
    MResults mResults;
    mResults = await ApiResponse.getCategory();
    if(mResults.loaded){
      mCategory = MCategory.fromJson(mResults.data);
    }
    notifyListeners();
    return mResults;
  }
  void getProduct() {
    if(productList.length == 0){
      productList = ProductList().arr.map((value) => MProduct.fromJson(value)).toList();
    }
    notifyListeners();
  }
}