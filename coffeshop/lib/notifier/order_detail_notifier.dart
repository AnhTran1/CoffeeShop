import 'package:coffeshop/model/m_cart.dart';
import 'package:flutter/cupertino.dart';

class OrderDetailNotifier extends ChangeNotifier{
  List<MCartData> mOrderDetail = new List();
  
  void setOrderDetail(List<MCartData> value){
    mOrderDetail = value;
    notifyListeners();
  }
}