import 'dart:convert';

import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/const.dart';
import 'package:coffeshop/common/storage_manager.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_address.dart';
import 'package:coffeshop/notifier/address_notifier.dart';
import 'package:coffeshop/notifier/cart_notifier.dart';
import 'package:coffeshop/screen/address.dart';
import 'package:coffeshop/screen/create_address.dart';
import 'package:coffeshop/widget/error_widget/error_screen.dart';
import 'package:coffeshop/widget/loading/circular_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AddressList extends StatefulWidget {
  bool showAppbar;
  AddressList({this.showAppbar});
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500),() async{
      var addVm = Provider.of<AddressModel>(context,listen: false);
      addVm.getAddressList(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: widget.showAppbar ? AppBar(
          title: Text('Danh sách địa chỉ'),
          backgroundColor: BASE_APP_COLOR,
          automaticallyImplyLeading: true,
          centerTitle: true,
        ) : null,
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 16.0),
                    physics: AlwaysScrollableScrollPhysics(),
                    child: buildList()
                )
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(
                  new CupertinoPageRoute<bool>(
                    fullscreenDialog: true,
                    builder: (BuildContext context) => new Address(type: true)
                  ),
                );
              },
              child: Container(
                decoration: CustomDecoration,
                height: 75.0,
                width: Utils.width(context) - 20,
                margin: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,color: Colors.black38),
                    Text("Thêm địa chỉ",style: addressStyle),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
  Widget buildList(){
    final addressVm = Provider.of<AddressModel>(context);
    final cartVm = Provider.of<CartModel>(context);
    if(addressVm.mAddressResult.loading){
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: Utils.height(context) / 3),
          child: CircularLoading(),
        ),
      );
    } else if(addressVm.mAddressResult.loaded){
      List<MAddressData> addressList = addressVm.mAddress.data;
      if(addressList != null && addressList.length > 0){
        return ListView.builder(
          itemCount: addressList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10.0,right: 10.0),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
               if(widget.showAppbar){
                 cartVm.setDeliveryAddress(addressList[index]);
                 Navigator.pop(context);
               }
              },
              child: Container(
                decoration: CustomDecoration,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${addressList[index].name}",style: titleOrderDetail),
                        Row(
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(
                                    context,
                                    new PageRouteBuilder(
                                        pageBuilder: (BuildContext context, _, __) {
                                          return new Address(type: false,mAddressData:addressList[index]);
                                        }
                                    )
                                );
                              },
                              child: Icon(Icons.edit,color: Colors.black38),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              onTap:(){
                                Utils.showAlertConfirm(title, "Xác nhận xóa địa chỉ này", "Hủy bỏ", "Đồng ý", context, () {
                                  Utils.showLoading(context);
                                  addressVm.removeAddress(address_id: addressList[index].id).then((value) {
                                    Navigator.pop(context);
                                    if(value.loaded){
                                      cartVm.setDeliveryAddress(null);
                                      addressVm.getAddressList(context);
                                    } else if(value.loadFailed){
                                      Utils.showAlertMessage(context, value.message);
                                    }
                                  });
                                });
                              },
                              child: Icon(Icons.delete,color: Colors.black38),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone,color: Colors.black38,size: 18.0),
                        SizedBox(width: 5.0),
                        Text("${addressList[index].phoneNumber}",style: addressStyle),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on,color: Colors.black38,size: 18.0),
                        SizedBox(width: 5.0),
                        Flexible(child: Text("${addressList[index].addressDetail}",style: addressStyle)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: widget.showAppbar ? Utils.height(context) / 3 : Utils.height(context) / 4),
            child: Text("Địa chỉ nhận hàng trống",style: messageStyle),
          ),
        );
      }
    } else if(addressVm.mAddressResult.loadFailed){
      return Expanded(
          child: ErrorScreen()
      );
    }
  }
}
