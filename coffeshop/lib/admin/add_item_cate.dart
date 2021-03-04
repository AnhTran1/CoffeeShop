import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/widget/item_address.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
class AddItemCate extends StatefulWidget {
  String cateId;
  bool isAdd;
  String imageLink;
  String id;
  AddItemCate({this.cateId,this.isAdd = true,this.imageLink,this.id});
  @override
  _AddItemCateState createState() => _AddItemCateState();
}

class _AddItemCateState extends State<AddItemCate> {
  var arrTitle = ["Tên sản phẩm","Giá sản phẩm","Số lượng","Mô tả"];
  final picker = ImagePicker();
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 50),(){
      if(widget.isAdd){
        Provider.of<ProductModel>(context,listen: false).setImagePicker(null);
        Provider.of<ProductModel>(context,listen: false).resetAddProductList();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final pVM = Provider.of<ProductModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isAdd ? "Thêm sản phẩm" : "Sửa sản phẩm"),
        backgroundColor: BASE_APP_COLOR,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 16.0,bottom: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: (){
                  showModal(context);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    widget.isAdd ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      child: pVM.imagePicker != null ? Image.file(pVM.imagePicker,width: 150,height: 150,fit: BoxFit.cover): Image.asset('assets/images/placeholder.png',width: 150,height: 150,fit: BoxFit.cover,),
                    ) : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      child: pVM.imagePicker != null ? Image.file(pVM.imagePicker,width: 150,height: 150,fit: BoxFit.cover): Image.network(widget.imageLink,width: 150,height: 150,fit: BoxFit.cover,),
                    ),
                    widget.isAdd ? (pVM.imagePicker != null ? SizedBox() : Icon(Icons.add,size: 32,color: BASE_APP_COLOR)) : SizedBox()
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: arrTitle.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ItemAddress(
                        textEditingController: widget.isAdd ? null : pVM.arrEditControl[index],
                        title: arrTitle[index],
                        hintText: "nhập ${arrTitle[index]}".toLowerCase(),
                        onChanged: (value) {
                          pVM.onChangeFormAddProduct(index, value);
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 32),
              SizedBox(
                width: Utils.width(context) - 32,
                child: RaisedButton(
                    onPressed: () async{
                      if(pVM.validateFormAddProduct(isAdd: widget.isAdd)){
                        Utils.showLoading(context);
                        widget.isAdd ? pVM.createProduct(category_id: widget.cateId).then((value) {
                          Navigator.of(context).pop();
                          if(value.loaded){
                            pVM.reCall();
                            pVM.getProduct(cateId: widget.cateId,page: 1);
                            Navigator.pop(context);
                          } else if(value.loadFailed){
                            Utils.showAlertMessage(context, value.message);
                          }
                        }) : pVM.updateProduct(category_id: widget.cateId,id: widget.id).then((value) {
                          Navigator.of(context).pop();
                          if(value.loaded){
                            pVM.reCall();
                            pVM.getProduct(cateId: widget.cateId,page: 1);
                            Navigator.pop(context);
                          } else if(value.loadFailed){
                            Utils.showAlertMessage(context, value.message);
                          }
                        });
                      }
                      else {
                        Utils.showAlertMessage(context, "Vui lòng nhập đủ thông tin");
                      }
                    },
                    color: PRICE_COLOR,
                    padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child:Text(
                      widget.isAdd ? "Thêm sản phẩm" : "Sửa sản phẩm",
                      style: TextStyle(
                          color: WHITE_COLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0
                      ),
                    )
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
  showModal(context,){
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0)),
      ),
      builder: (BuildContext context) {
        final pVM = Provider.of<ProductModel>(context);
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 16.0, bottom: 10.0),
                    child: Text("Chọn ảnh",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: BASE_APP_COLOR)),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Utils.width(context) - 32,
                          child: RaisedButton(
                              onPressed: () async{
                                final pickedFile = await picker.getImage(source: ImageSource.gallery);
                                pVM.setImagePicker(File(pickedFile.path));
                                Navigator.pop(context);
                              },
                              color: PRICE_COLOR,
                              padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child:Text(
                                "Thư viện",
                                style: TextStyle(
                                    color: WHITE_COLOR,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0
                                ),
                              )
                          ),
                        ),
                        SizedBox(
                          width: Utils.width(context) - 32,
                          child: RaisedButton(
                              onPressed: () async{
                                final pickedFile = await picker.getImage(source: ImageSource.camera);
                                pVM.setImagePicker(File(pickedFile.path));
                                Navigator.pop(context);
                              },
                              color: PRICE_COLOR,
                              padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child:Text(
                                "Máy Ảnh",
                                style: TextStyle(
                                    color: WHITE_COLOR,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        );
      },
    );
  }
}
