import 'package:coffeshop/common/dumy/product.dart';
import 'package:coffeshop/model/m_cart.dart';
import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  List<MCart> cartList = new List();
  double totalPrice = 0.0;
  bool selectAll = false;
  void getCart() {
    cartList = ProductList().arr.map((value) => MCart.fromJson(value)).toList();
    notifyListeners();
  }
  onSelectAll(value){
    if(cartList != null && cartList.length > 0){
      if(selectAll) {
        selectAll = value;
        cartList.forEach((element) {
          element.isCheck = false;
        });
      }
      else {
        selectAll = value;
        cartList.forEach((element) {
          element.isCheck = true;
        });
      }
    }
    onTotalPrice();
    notifyListeners();
  }
  onSelectItem(value,index){
    cartList[index].isCheck = value;
    onTotalPrice();
    notifyListeners();
  }
  onIncrementQtt(index){
    cartList[index].quantity += 1;
    onSetPriceQuantity(index);
    onTotalPrice();
    notifyListeners();
  }
  onDecreaseQtt(index){
    if(cartList[index].quantity > 1){
      cartList[index].quantity -= 1;
    }
    onSetPriceQuantity(index);
    onTotalPrice();
    notifyListeners();
  }
  onTotalPrice(){
    var arr = [];
    cartList.forEach((element) {
      if(element.isCheck){
        arr.add(element.quantity.toDouble() * double.parse(element.price));
      }
    });
    totalPrice = arr.fold(0, (p, c) => p + c);
  }
  onSetPriceQuantity(index){
    cartList[index].priceQuantity  = cartList[index].quantity.toDouble() * double.parse(cartList[index].price);
    notifyListeners();
  }
}