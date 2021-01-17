import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/model/m_cart.dart';
import 'package:coffeshop/notifier/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartList extends StatelessWidget {
  List<MCart> cartList;
  CartList({this.cartList});
  @override
  Widget build(BuildContext context) {
    final cartVm = Provider.of<CartModel>(context);
    return cartList != null ? (cartList.length > 0 ? ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartList.length,
      padding: EdgeInsets.zero,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      cartList[index].name,
                      style: title,
                  ),
                  SizedBox(
                    width:20.0,
                    height: 20.0,
                    child: Transform.scale(
                      scale: 1.1,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.white,
                        ),
                        child: Checkbox(
                          value: cartList[index].isCheck,
                          onChanged: (bool value) {
                            cartVm.onSelectItem(value,index);
                          },
                          activeColor: PRICE_COLOR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      child: CachedNetworkImage(
                        imageUrl: cartList[index].imgUrl,
                        placeholder: (context, url) =>  Image.asset(image_placeholder,fit: BoxFit.cover,),
                        errorWidget: (context, url, error) => Image.asset(image_placeholder,fit: BoxFit.cover),
                        fit: BoxFit.cover,
                        width: 85,
                        height:85,
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
                               child:Text(
                                   "Cà phê espresso được đổ vào đáy cốc, tiếp theo là một lượng sữa nóng tương tự, được chuẩn bị bằng cách làm nóng và tạo kết cấu sữa bằng vòi hơi củ",
                                   style: TextStyle(
                                       color: WHITE_COLOR,
                                       fontWeight: FontWeight.w400,
                                       fontSize: 14.0,
                                       height: 1.5,
                                   ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                               )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      cartList[index].priceQuantity != null ? "${cartList[index].priceQuantity} VND" : "${cartList[index].price} VND",
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
                                  width: 110,
                                  padding: EdgeInsets.only(left:2.0,right: 2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      color:BASE_APP_COLOR
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          cartVm.onIncrementQtt(index);
                                        },
                                        color: ITEM_COLOR,
                                        textColor: Colors.white,
                                        child: Icon(
                                          Icons.add,
                                          size: 12,
                                        ),
                                        padding: EdgeInsets.all(5.0),
                                        shape: CircleBorder(),
                                        height: 20.0,
                                        minWidth: 20.0,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      Text(
                                          cartList[index].quantity > 10 ? "${cartList[index].quantity}" : "0${cartList[index].quantity}" ,
                                          textScaleFactor: 1.1,
                                          style: TextStyle(
                                            color: WHITE_COLOR,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.0,
                                          )
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          cartVm.onDecreaseQtt(index);
                                        },
                                        color: PRICE_COLOR,
                                        textColor: Colors.white,
                                        child: Icon(
                                          Icons.remove,
                                          size: 12,
                                        ),
                                        padding: EdgeInsets.all(5.0),
                                        shape: CircleBorder(),
                                        height: 20.0,
                                        minWidth: 20.0,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
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
    ) : Container(
      height: (Utils.height(context) / 3) * 2,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: BASE_APP_COLOR,
        ),
      ),
    )) : Text("Khong co san pham trong gio hang");
  }
}
