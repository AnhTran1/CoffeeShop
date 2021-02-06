import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/const.dart';
import 'package:coffeshop/model/m_address.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:flutter/cupertino.dart';

class AddressModel extends  ChangeNotifier{
  MAddress mAddress;
  MAddressData mFormAdd  = MAddressData(name: "",phoneNumber: "",addressDetail: "");
  MResults mAddressResult = MResults(loading: true,loaded: false,loadFailed: false,loadMore: false,message: "",data: null);
  void onChangeAdd(int type,String value){
    switch (type) {
      case 0:
        mFormAdd.name = value.trim();
        break;
      case 1:
        mFormAdd.phoneNumber = value.trim();
        break;
      case 2:
        mFormAdd.addressDetail = value.trim();
        break;
    }
    notifyListeners();
  }
  void resetForm(){
    mFormAdd  = MAddressData(name: "",phoneNumber: "",addressDetail: "");
    notifyListeners();
  }
  addValidate() async{
    if(mFormAdd.name.isEmpty || mFormAdd.phoneNumber.isEmpty || mFormAdd.addressDetail.isEmpty){
      return Const.nullFormat;
    } else {
      if(!Utils.validatePhone(mFormAdd.phoneNumber)){
        return Const.phoneFormat;
      } else {
        return null;
      }
    }
  }
  Future<MResults> actionAdd(BuildContext context) async{
    MResults mResults = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    String onMessage = await addValidate();
    print(onMessage);
    if(onMessage != null){
      Utils.showAlertMessage(context, onMessage);
    }
    else {
      Utils.showLoading(context);
      mResults = await ApiResponse.addAddress(field:[{"name":"${mFormAdd.name}"},{"phone_number":"${mFormAdd.phoneNumber}"},{"address_detail":"${mFormAdd.addressDetail}"}]);
      Navigator.of(context).pop();
    }
    return mResults;
  }
  void getAddressList(context) async{
    mAddressResult = await ApiResponse.getAddressList();
    if(mAddressResult.loaded){
      mAddress = MAddress.fromJson(mAddressResult.data);
    }
    notifyListeners();
  }
  Future<MResults> removeAddress({address_id}) async{
    MResults mRemoveAddress = MResults(loading: true,loaded: false,loadFailed: false,loadMore: false,message: "",data: null);
    mRemoveAddress = await ApiResponse.removeAddress(field: [{"address_id":"${address_id}"}]);
    notifyListeners();
    return mRemoveAddress;
  }
}