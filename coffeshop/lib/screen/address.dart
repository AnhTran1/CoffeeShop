import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_address.dart';
import 'package:coffeshop/notifier/address_notifier.dart';
import 'package:coffeshop/widget/item_address.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Address extends StatefulWidget {
  // type = true ? add : edit
  bool  type;
  MAddressData mAddressData;
  Address({this.type,this.mAddressData});
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  var arrList = ["Tên người nhận","Số điện thoại","Địa chỉ chi tiết"];
  var arrEdit ;
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var addressController = new TextEditingController();
  @override
  void initState() {
    if(!widget.type){
      nameController.text = widget.mAddressData.name;
      phoneController.text = widget.mAddressData.phoneNumber;
      addressController.text = widget.mAddressData.addressDetail;
      arrEdit = [nameController,phoneController,addressController];
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final addVm = Provider.of<AddressModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type ? "Thêm địa chỉ" : "Chỉnh sửa địa chỉ"),
        backgroundColor: BASE_APP_COLOR,
        centerTitle: true,
      ),
      body:Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                  itemCount: arrList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ItemAddress(
                          title: arrList[index],
                          hintText: arrList[index],
                          textEditingController: widget.type ? null : arrEdit[index],
                          onChanged: (value){
                            addVm.onChangeAdd(index, value);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        )
                      ],
                    );
                  }
              ),
            ),
          ),
          Container(
            width: Utils.width(context),
            padding: EdgeInsets.only(left: 10.0,right: 10.0),
            child: RaisedButton(
              onPressed: (){
                if(widget.type){
                  addVm.actionAdd(context).then((value) {
                    if(value.loaded){
                      Navigator.of(context).pop();
                      addVm.resetForm();
                      addVm.getAddressList(context);
                    }if(value.loadFailed){
                      Utils.showAlertMessage(context, value.message);
                    }
                  });
                } else {
                  Navigator.pop(context);
                }
              },
              color: PRICE_COLOR,
              disabledColor: PRICE_COLOR,
              padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Text(
                "Xác Nhận",
                style: TextStyle(
                    color: WHITE_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}


