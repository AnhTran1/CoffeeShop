import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeshop/common/Utils.dart';
import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/screen/order_status_detail.dart';
import 'package:flutter/material.dart';
class ItemOrderStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount:5,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderStatusDetail()),
            );
          },
          child: Container(
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
                  "Name",
                  style: title,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      child: CachedNetworkImage(
                        imageUrl:noImage1,
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
                                    "10000VND",
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
                                  padding: EdgeInsets.only(left:15,right: 15.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      color:BASE_APP_COLOR
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "01",
                                          textScaleFactor: 1.1,
                                          style: TextStyle(
                                            color: WHITE_COLOR,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12.0,
                                          )
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
          ),
        );
      },
    );
  }
}
