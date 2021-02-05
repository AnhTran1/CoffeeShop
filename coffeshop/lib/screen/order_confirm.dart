import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/cart_notifier.dart';
import 'package:coffeshop/screen/address.dart';
import 'package:coffeshop/screen/address_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderConfirm extends StatefulWidget {
  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
    final cartVm = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách địa chỉ'),
        backgroundColor: BASE_APP_COLOR,
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: CustomDecoration,
                margin: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartVm.mOrderDetail.length,
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: ITEM_COLOR,
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(top: index != 0 ? 10.0 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cartVm.mOrderDetail[index].name,
                                style: title,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                    child: CachedNetworkImage(
                                      imageUrl: cartVm.mOrderDetail[index].fileImage != null ? cartVm.mOrderDetail[index].fileImage : noImage,
                                      placeholder: (context, url) => Image.asset(
                                        image_placeholder,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(image_placeholder, fit: BoxFit.cover),
                                      fit: BoxFit.cover,
                                      width: 85,
                                      height: 85,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                              width: Utils.width(context) - 130,
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                "Cà phê espresso được đổ vào đáy cốc, tiếp theo là một lượng sữa nóng tương tự, được chuẩn bị bằng cách làm nóng và tạo kết cấu sữa bằng vòi hơi củ",
                                                style: TextStyle(
                                                  color: WHITE_COLOR,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                  height: 1.5,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(
                                                  "${cartVm.mOrderDetail[index].price}.0 VND",
                                                  style: TextStyle(
                                                    color: PRICE_COLOR,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.0,
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 25.0,
                                                padding:
                                                EdgeInsets.only(left: 15, right: 15.0),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20.0)),
                                                    color: BASE_APP_COLOR),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                        cartVm.mOrderDetail[index].quantity > 9 ? "${cartVm.mOrderDetail[index].quantity}" :"0${cartVm.mOrderDetail[index].quantity}",
                                                        textScaleFactor: 1.1,
                                                        style: TextStyle(
                                                          color: WHITE_COLOR,
                                                          fontWeight: FontWeight.w800,
                                                          fontSize: 12.0,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Phí giao hàng:",style: titleOrderDetail),
                              Text("+10000.0 VND",style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                              )),
                            ],
                          ),
                          SizedBox(height: 7.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tổng tiền:",style: titleOrderDetail),
                              Text("x ${cartVm.totalPrice + 10000}.0 VND",style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                              )),
                            ],
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            new PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) {
                                  return new AddressList();
                                }
                            )
                        );
                      },
                      child: Container(
                        decoration: CustomDecoration,
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.only(left: 10.0,top: 10.0,bottom: 10.0),
                        width: Utils.width(context) - 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Địa chỉ nhận hàng:",style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                )),
                                Text("name",style: titleOrderDetail),
                                Text("address",style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                ))
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_sharp),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: Utils.width(context),
            padding: EdgeInsets.only(left: 10.0,right: 10.0),
            child: RaisedButton(
              onPressed: (){
              },
              color: PRICE_COLOR,
              disabledColor: PRICE_COLOR,
              padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Text(
                "Xác nhận đơn hàng",
                style: TextStyle(
                    color: WHITE_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
