import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/controller/travel_controller.dart';
import 'package:trip_flutter/dao/travel_dao.dart';
import 'package:trip_flutter/model/travel_category_model.dart';
import 'package:trip_flutter/pages/travel_tab_page.dart';
import 'package:underline_indicator/underline_indicator.dart';


// 用 GetBuilder 后变成无状态组件
class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

//   @override
//   State<TravelPage> createState() => _TravelPageState();
// }
//
// class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
//   List<TravelTab> tabs = [];
//   TravelCategoryModel? travelTabModel;
//   late TabController _controller;

  // get _tabBar => TabBar(
  //   controller: _controller,
  //     isScrollable: true,
  //     labelColor: Colors.black,
  //     indicator: UnderlineIndicator(strokeCap: StrokeCap.round, borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3), insets: EdgeInsets.only(bottom: 0)),
  //     indicatorSize: TabBarIndicatorSize.tab,
  //     // indicatorColor: Colors.red,
  //     tabAlignment: TabAlignment.start,
  //     tabs: tabs.map<Tab>((TravelTab tab){
  //       return Tab(text: tab.labelName);
  //     }).toList()
  // );

  get _tabBar {
    return GetBuilder<TravelController>(builder: (TravelController controller){
      return TabBar(
        controller: controller.controller,
          isScrollable: true,
          labelColor: Colors.black,
          indicator: UnderlineIndicator(strokeCap: StrokeCap.round, borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3), insets: EdgeInsets.only(bottom: 0)),
          indicatorSize: TabBarIndicatorSize.tab,
          // indicatorColor: Colors.red,
          tabAlignment: TabAlignment.start,
          tabs: controller.tabs.map<Tab>((TravelTab tab){
            return Tab(text: tab.labelName);
          }).toList()
      );
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   _controller = TabController(length: 0, vsync: this);
  //
  //   TravelDao.getCategory().then((TravelCategoryModel? model){
  //     _controller = TabController(length: model?.tabs?.length ?? 0 , vsync: this);
  //     setState(() {
  //
  //       tabs = model?.tabs ?? [];
  //       travelTabModel = model;
  //
  //     });
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(TravelController());

    double top = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
            child: _tabBar
          ),
          Flexible(
            child: _tabBarView()
          )
        ],
      ),
    );
  }

  _tabBarView(){
    // return TabBarView(
    //     controller: _controller,
    //     children: tabs.map((TravelTab tab){
    //       debugPrint('__tab: $tab');
    //       return TravelTabPage(groupChannelCode: tab.groupChannelCode);
    //     }).toList()
    // );

    return GetBuilder<TravelController>(builder: (TravelController controller){
      return TabBarView(
        controller: controller.controller,
        children: controller.tabs.map((TravelTab tab){
          debugPrint('__tab: $tab');
          return TravelTabPage(groupChannelCode: tab.groupChannelCode);
        }).toList()
      );
    });
  }

}
