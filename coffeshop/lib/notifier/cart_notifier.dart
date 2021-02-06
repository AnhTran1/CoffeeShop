import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/model/m_address.dart';
import 'package:coffeshop/model/m_cart.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:coffeshop/notifier/product_detail_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CartModel extends ChangeNotifier {
  MResults mCartResult = MResults(loading: true,loaded: false,loadFailed: false,loadMore: false,message: "",data: null);
  MCart mCart;
  MAddressData mDeliveryAddress;
  int totalPrice = 0;
  bool selectAll = false;
  bool changePrice = false;
  bool isActiveOrder = false;
  List<MCartData> mOrderDetail = new List();
  onSelectAll(value){
    if(mCart != null && mCart.data.length > 0){
      if(selectAll) {
        selectAll = value;
        mCart.data.forEach((element) {
          element.isCheck = false;
        });
      }
      else {
        selectAll = value;
        mCart.data.forEach((element) {
          element.isCheck = true;
        });
      }
    }
    onTotalPrice();
    notifyListeners();
  }
  onSelectItem(value,index){
    mCart.data[index].isCheck = value;
    onTotalPrice();
    notifyListeners();
  }
  onIncrementQtt(index){
    mCart.data[index].quantity += 1;
    onSetPriceQuantity(index);
    onTotalPrice();
    notifyListeners();
  }
  onDecreaseQtt(index){
    if(mCart.data[index].quantity > 1){
      mCart.data[index].quantity -= 1;
    }
    onSetPriceQuantity(index);
    onTotalPrice();
    notifyListeners();
  }
  onTotalPrice() async{
    var arr = [];
    var arrChecks = [];
    if(mOrderDetail != null){
      mOrderDetail.clear();
    }
    await Future.delayed(Duration.zero,(){
      mCart.data.forEach((element) {
        if(element.isCheck){
          arr.add(element.quantity * element.price);
          arrChecks.add(element.isCheck);
          mOrderDetail.insert(0, element);
        }
      });
    });
    if(arrChecks.length != mCart.data.length){
      selectAll = false;
    }else {
      selectAll = true;
    }
    totalPrice = arr.fold(0, (p, c) => p + c);
    if(totalPrice > 0){
      isActiveOrder = true;
    }  else {
      isActiveOrder = false;
    }
    onChangePrice();
    notifyListeners();
  }
  onSetPriceQuantity(index){
    mCart.data[index].priceQuantity  = mCart.data[index].quantity * mCart.data[index].price;
    notifyListeners();
  }
  onChangePrice(){
    changePrice = true;
    Future.delayed(Duration(milliseconds: 10),(){
      changePrice = false;
    });
    notifyListeners();
  }
  void onReturnCart(){
    totalPrice = 0;
    selectAll = false;
    changePrice = false;
    isActiveOrder = false;
    if(mOrderDetail != null){
      mOrderDetail.clear();
    }
    if(mCart != null && mCart.data.length > 0) {
      mCart.data.forEach((element) {
        element.isCheck = false;
      });
    }
    notifyListeners();
  }
  void setDeliveryAddress (MAddressData data){
    mDeliveryAddress = data;
    notifyListeners();
  }
  // api
  void getCart(context) async{
    mCartResult = await ApiResponse.getListCart();
    if(mCartResult.loaded){
      mCart = MCart.fromJson(mCartResult.data);
      if(mCart != null && mCart.data != null){
        var prdVM = Provider.of<ProductDetailModel>(context,listen: false);
        prdVM.setBadge(mCart.data.length);
      }
    }
    notifyListeners();
  }
  Future<MResults> updateByAddCart() async{
    MResults mUpdateByAddCart = MResults(loading: true,loaded: false,loadFailed: false,loadMore: false,message: "",data: null);
    mUpdateByAddCart = await ApiResponse.getListCart();
    if(mUpdateByAddCart.loaded){
      mCart = MCart.fromJson(mCartResult.data);
    }
    return mUpdateByAddCart;
  }
  Future<MResults> removeCart(context,cartId) async{
    MResults mRemoveCart = MResults(loading: true,loaded: false,loadFailed: false,loadMore: false,message: "",data: null);
    mRemoveCart = await ApiResponse.removeCart(field: [{"cart_id":cartId}]);
    getCart(context);
    return mRemoveCart;
  }
}