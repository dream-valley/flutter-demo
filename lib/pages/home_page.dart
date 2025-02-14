import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/home_dao.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/widget/banner_widget.dart';
import 'package:trip_flutter/widget/grid_nav_widget.dart';
import 'package:trip_flutter/widget/local_nav_widget.dart';

class HomePage extends StatefulWidget {
  static Config? configModel;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin{

  static const appbarScrollOffset = 100;

  double appBarAlpha = 0;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;

  get _logoutBtn => TextButton(onPressed: (){
    LoginDao.logout();
  }, child: const Text('登出'));

  get _appBar => Opacity(
    opacity: appBarAlpha,
    child: Container(
      height: 80,
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text('首页'),
        )
      ),
    )
  );

  get _listView => ListView(
    children: [
      BannerWidget(bannerList: bannerList),
      LocalNavWidget(localNavList: localNavList),
      if (gridNavModel != null) GridNavWidget(gridNavModel: gridNavModel!),



      _logoutBtn,
      Text(gridNavModel?.flight?.item1?.title ?? ""),
      const SizedBox(height: 800, child: ListTile(title: Text('hi'),),)
    ],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return  Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title:  const Text('首页'),
      //   actions: [ _logoutBtn ]
      // ),
      body: Stack(
        children: [
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              // child: _listView
              child: NotificationListener(
                child: _listView,
                onNotification: (scrollNotifaction) {
                  // banner 也可以滚动，banner 滚动也会走到这里，因此 用 depth == 0 只处理 list 滚动的逻辑
                  if (scrollNotifaction is ScrollUpdateNotification && scrollNotifaction.depth == 0) {
                    _onScroll(scrollNotifaction.metrics.pixels);
                  }
                  return false;
                },
              ),
          ), // 移除刘海的padding
          _appBar,
          // BannerWidget(bannerList: bannerList)
        ],
      )
    );
  }

  @override
  bool get wantKeepAlive => true; // 常驻内存

  void _onScroll(double offset){
    double alpha = offset / appbarScrollOffset;

    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
    });
  }

  var bodyString = '';
  Future<String?> _handleRefresh()  async{
    try{
      HomeModel model = await HomeDao.fetch();

      setState(() {
        HomePage.configModel = model.config;
        localNavList = model.localNavList ?? [];
        subNavList = model.subNavList ?? [];
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList ?? [];

      });
    } catch (e){
      debugPrint(e.toString());
    }
  }
}
