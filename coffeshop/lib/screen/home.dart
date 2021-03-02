import 'package:coffeshop/common/styles.dart';
import 'package:coffeshop/notifier/product_notifier.dart';
import 'package:coffeshop/notifier/user_notifier.dart';
import 'package:coffeshop/widget/error_widget/error_screen.dart';
import 'package:coffeshop/widget/home_widget/product_by_cate.dart';
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
  @override
  void initState() {
    initTabBar();
    super.initState();
  }
  initTabBar(){
    var pVM = Provider.of<ProductModel>(context,listen: false);
    if(pVM.mCategory != null && pVM.mCategory.data.length > 0){
      tabController = TabController(vsync: this, length: pVM.mCategory.data.length);
      pVM.mCategory.data.forEach((element) {
        tabs.add(_customTab(element.name));
        tabBody.add(ProductByCate(categoryName: element.name,cateId:(element.id - 1).toString(),isAdmin: false));
      });
    } else {
      tabController = TabController(vsync: this, length:0);
    }
  }
  @override
  Widget build(BuildContext context) {
    final pVM = Provider.of<ProductModel>(context);
    return MediaQuery(
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
              backgroundColor: BASE_APP_COLOR,
              centerTitle: false,
              title: Text("Coffee",style: appbarHome),
              actions: <Widget>[
                InkWell(
                    onTap: () {
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child:IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.event,
                            color: WHITE_COLOR,
                          )),
                    )),
              ],
              bottom: TabBar(
                tabs:tabs.length > 0 ? tabs : [] ,
                controller: tabController,
                isScrollable: true,
                indicatorColor: WHITE_COLOR,
                labelStyle: tabBarHome,
                unselectedLabelStyle:tabBarHome,
                labelColor: WHITE_COLOR,
                unselectedLabelColor:TAB_COLOR,
                indicatorPadding: EdgeInsets.only(left: 16.0,right: 16,bottom: 0),
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.only(bottom: 0,left: 16.0,right: 16.0),
              )
            ),
          ),
        ),
        body: pVM.mCategory != null && tabs.length > 0 ? DefaultTabController(
          length: pVM.mCategory.data.length,
          child: TabBarView(
            children: tabBody,
            physics: BouncingScrollPhysics(),
            controller: tabController,
          ),
        ) : ErrorScreen(
          message: null,
          callbackRetry: () async{
          },
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
