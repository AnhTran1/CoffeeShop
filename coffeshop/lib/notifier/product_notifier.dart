import 'dart:collection';
import 'dart:convert';
import 'package:coffeshop/common/storage_manager.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:coffeshop/api/api_response.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/model/m_category.dart';
import 'package:coffeshop/model/m_product.dart';
import 'package:coffeshop/model/m_results.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

class ProductModel extends ChangeNotifier {
  MCategory mCategory;
  MResults mProductResult = MResults(
      loading: true,
      loaded: false,
      loadFailed: false,
      loadMore: false,
      message: "",
      data: null);
  File imagePicker ;
  HashMap<String, List<MProduct>> mProductList;
  HashMap productList = new HashMap<String, List<MProduct>>();
  var addCateList = ['', ''];
  var addProductList = ['', '','',''];
  var arrEditControl = [];
  var cateNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var productNameController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();

  Future getCategory() async {
    MResults mResults;
    mResults = await ApiResponse.getCategory();
    if (mResults.loaded) {
      mCategory = MCategory.fromJson(mResults.data);
    }
    notifyListeners();
    return mResults;
  }
  void setEditCateControl({cateName,description}){
    onChangeAddCate(0,cateName);
    onChangeAddCate(1,description);
    cateNameController.text = cateName;
    descriptionController.text = description;
    notifyListeners();
  }
  void setEditItemControl({name,price,quantity,description}){
    arrEditControl = [];
    descriptionController.text = description;
    productNameController.text = name;
    quantityController.text = quantity.toString();
    priceController.text = price.toString();
    onChangeFormAddProduct(0,name);
    onChangeFormAddProduct(1,price.toString());
    onChangeFormAddProduct(2,quantity.toString());
    onChangeFormAddProduct(3,description);
    arrEditControl.add(productNameController);
    arrEditControl.add(priceController);
    arrEditControl.add(quantityController);
    arrEditControl.add(descriptionController);
    imagePicker = null;
    notifyListeners();
  }
  void reCall() {
    mProductResult = MResults(
        loading: true,
        loaded: false,
        loadFailed: false,
        loadMore: false,
        message: "",
        data: null);
    notifyListeners();
  }
  void getProduct({String cateId, int page}) async {
    await Future.delayed(Duration(milliseconds: 1000), () async {
      mProductResult =
          await ApiResponse.getProductByCate(params: {"category_id": cateId});
      if (mProductResult.loaded && mProductResult.data != null) {
        var jsonList =
            jsonDecode(jsonEncode(mProductResult.data))["data"] as List;
        productList[cateId] =
            jsonList.map((i) => MProduct.fromJson(i)).toList();
        mProductList = productList;
      }
    });
    notifyListeners();
  }
  void cleanAddCateList(){
    addCateList = ['',''];
    notifyListeners();
  }
  void resetAddProductList(){
    addProductList = ['', '','',''];
    notifyListeners();
  }
  void setImagePicker(File value){
    imagePicker = value;
    notifyListeners();
  }
  void onChangeAddCate(int type, String value) {
    switch (type) {
      case 0:
        addCateList[0] = value.trim();
        break;
      case 1:
        addCateList[1] = value.trim();
        break;
    }
    notifyListeners();
  }

  void onChangeFormAddProduct(int type, String value) {
    switch (type) {
      case 0:
        addProductList[0] = value.trim();
        break;
      case 1:
        addProductList[1] = value.trim();
        break;
      case 2:
        addProductList[2] = value.trim();
        break;
      case 3:
        addProductList[3] = value.trim();
        break;
    }
    notifyListeners();
  }
  Future<MResults> addCategory(context) async {
    MResults mResults = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    if (addCateList[0].toString().length < 1 || addCateList[1].toString().length < 1 ) {
      Utils.showAlertMessage(context, 'Vui lòng nhập đầy đủ thông tin');
    } else {
      Utils.showLoading(context);
      mResults =  await ApiResponse.addCategory(field: [
        {"name": "${addCateList[0]}"},
        {"description": "${addCateList[1]}"}
      ]);
      Navigator.pop(context);
      Navigator.pop(context);
    }
    return mResults;
  }
  Future<MResults> updateCategory(context,id) async {
    MResults mResults = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    if (addCateList[0].toString().length < 1 || addCateList[1].toString().length < 1 ) {
      Utils.showAlertMessage(context, 'Vui lòng nhập đầy đủ thông tin');
    } else {
      Utils.showLoading(context);
      mResults =  await ApiResponse.updateCategory(field: [
        {"name": "${addCateList[0]}"},
        {"description": "${addCateList[1]}"},
        {"id":id}
      ]);
      Navigator.pop(context);
      Navigator.pop(context);
    }
    return mResults;
  }
  validateFormAddProduct({isAdd}){
    print(">>>> ${imagePicker}");
    if(isAdd){
      if (addProductList[0].toString().length < 1 || addProductList[1].toString().length < 1 || addProductList[2].toString().length < 1 || addProductList[3].toString().length < 1 || imagePicker == null ){
        return false;
      } else {
        return true;
      }
    } else {
      if (addProductList[0].toString().length < 1 || addProductList[1].toString().length < 1 || addProductList[2].toString().length < 1 || addProductList[3].toString().length < 1 ){
        return false;
      } else {
        return true;
      }
    }
  }
  // ignore: missing_return
  Future<MResults> createProduct ({category_id}) async{
    MResults mResults = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    FormData formData  = FormData.fromMap({
    "category_id": category_id,
    "name": addProductList[0],
    "description": addProductList[3],
    "price":addProductList[1],
    "quantity":addProductList[2],
    "file_image":imagePicker != null ? await MultipartFile.fromFile(
      imagePicker.path,
      filename: imagePicker.path.split('/').last,
      contentType: new MediaType("image", "jpeg"),
    ) : null,
    });
    try {
      Response response = await Dio().post('http://coffee.pacom-dev.com/api/v1/add-item',data: formData,options: Options(
          headers:  {
      "Authorization": "${await StorageManager.readData("token")}"
      },
      contentType: "multipart/form-data"
      ));
      if (response.statusCode == 200) {
        mResults = MResults(loading: false,loaded: true,loadMore: false,loadFailed: false,message: "",data: null);
        return mResults;
      }
    } on SocketException {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: "No internet connected",data: null);
      return mResults;
    } on HttpException {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: "HttpException",data: null);
      return mResults;
    } on FormatException {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: "FormatException",data: null);
      return mResults;
    } on Exception {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: "Exception",data: null);
      return mResults;
    }  catch (e) {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: e.toString(),data: null);
      return mResults;
    }
  }
  Future<MResults> updateProduct ({category_id,id}) async{
    MResults mResults = MResults(loading: true,loaded: false,loadMore: false,loadFailed: false,message: "",data: null);
    FormData formData  = FormData.fromMap({
      "category_id": category_id,
      "name": addProductList[0],
      "description": addProductList[3],
      "price":addProductList[1],
      "quantity":addProductList[2],
      "id":id,
      "file_image":imagePicker != null ? await MultipartFile.fromFile(
        imagePicker.path,
        filename: imagePicker.path.split('/').last,
        contentType: new MediaType("image", "jpeg"),
      ) : null,
    });
    try {
      Response response = await Dio().post('http://coffee.pacom-dev.com/api/v1/update-item',data: formData,options: Options(
          headers:  {
            "Authorization": "${await StorageManager.readData("token")}"
          },
          contentType: "multipart/form-data"
      ));
      if (response.statusCode == 200) {
        mResults = MResults(loading: false,loaded: true,loadMore: false,loadFailed: false,message: "",data: null);
        return mResults;
      }
    } on SocketException {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: "No internet connected",data: null);
      return mResults;
    } on HttpException {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: "HttpException",data: null);
      return mResults;
    } on FormatException {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: "FormatException",data: null);
      return mResults;
    } catch (e) {
      mResults = MResults(loading: false,loaded: false,loadMore: false,loadFailed: true,message: e.toString(),data: null);
      return mResults;
    }
  }
}
