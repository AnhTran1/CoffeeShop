import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/widget/home_widget/coffee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController tabController;
  final tabBody = <Widget>[];
  final tabs = <Tab>[];
  var categoryList = ["Coffee","Tea","Chocolate","Food"];
  @override
  void initState() {
    initTabBar();
    super.initState();
  }
  initTabBar(){
    tabController = TabController(vsync: this, length: categoryList.length);
    categoryList.forEach((element) {
      tabs.add(_customTab(element));
    });
    tabBody.add(Coffee(category: CATEGORY.COFFEE));
    tabBody.add(Coffee(category: CATEGORY.TEA));
    tabBody.add(Coffee(category: CATEGORY.CHOCOLATE));
    tabBody.add(Coffee(category: CATEGORY.FOOD));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Theme(
          data: new ThemeData(
              highlightColor: Colors.transparent,
              splashColor:Colors.grey.withOpacity(0.05),
          ),
          child: AppBar(
            backgroundColor: BASE_APP_COLOR,
            centerTitle: false,
            title: Text("Coffee",style: appbarHome),
            actions: <Widget>[
              InkWell(
                  onTap: () {
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Stack(
                      alignment: AlignmentDirectional(0.8, -0.8),
                      children: <Widget>[
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.shopping_cart,
                              color: WHITE_COLOR,
                            )),
                        CircleAvatar(
                          radius: 10.0,
                          backgroundColor: Colors.red,
                          child: Text(
                            "1",
                            style: TextStyle(color: Colors.white, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
            bottom: TabBar(
              tabs: tabs,
              controller: tabController,
              indicatorColor: WHITE_COLOR,
              labelStyle: tabBarHome,
              unselectedLabelStyle:tabBarHome,
              labelColor: WHITE_COLOR,
              unselectedLabelColor:TAB_COLOR,
              indicatorPadding: EdgeInsets.only(left: 16.0,right: 16,bottom: 0),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.only(left: 8.0,right: 8,bottom: 0),
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: categoryList.length,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: TabBarView(
            children: tabBody,
            physics: BouncingScrollPhysics(),
            controller: tabController,
          )
        ) ,
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
