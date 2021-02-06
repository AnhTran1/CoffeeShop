import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/widget/order_status/order_status_by_type.dart';
import 'package:flutter/material.dart';
class OrderStatus extends StatefulWidget {
  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> with SingleTickerProviderStateMixin{
  TabController tabController;
  final tabBody = <Widget>[];
  final tabs = <Tab>[];
  var orderStatusList = ["Đang xử lý","Đang vận chuyển ","Đã giao"];
  @override
  void initState() {
    initTabBar();
    super.initState();
  }
  initTabBar(){
    tabController = TabController(vsync: this, length: orderStatusList.length);
    orderStatusList.forEach((element) {
      tabs.add(_customTab(element));
    });
    tabBody.add(OrderStatusByType(status: STATUS.PROCESSING));
    tabBody.add(OrderStatusByType(status: STATUS.SHIPPING));
    tabBody.add(OrderStatusByType(status: STATUS.COMPLETED));
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: orderStatusList.length,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: Theme(
                data: new ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor:Colors.grey.withOpacity(0.05),
                ),
                child: AppBar(
                  title: Text("Trạng thái đơn hàng"),
                  backgroundColor: BASE_APP_COLOR,
                  centerTitle: true,
                  bottom: TabBar(
                    tabs: tabs,
                    controller: tabController,
                    indicatorColor: WHITE_COLOR,
                    isScrollable: true,
                    labelStyle: tabBarHome,
                    unselectedLabelStyle:tabBarHome,
                    labelColor: WHITE_COLOR,
                    unselectedLabelColor:TAB_COLOR,
                    indicatorPadding: EdgeInsets.only(bottom: 0),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.only(bottom: 0,left: 16.0,right: 16.0),
                  ),
                ),
              ),
            ),
            body: TabBarView(
                  children: tabBody,
                  physics: BouncingScrollPhysics(),
                  controller: tabController,
            ) ,
        ),
      ),
    );
  }
  Widget _customTab(title) {
    return Tab(
      child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Text(title),
          )
      ),
    );
  }
}
