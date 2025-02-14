import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';

import '../dao/travel_dao.dart';

class TravelTabController extends GetxController{
  final String groupChannelCode;

  TravelTabController(this.groupChannelCode);

  final travelItems = <TravelItem>[].obs;
  final loading = true.obs;
  int pageIndex = 1;
  final ScrollController scrollController = ScrollController();

  @override void onInit() {
    super.onInit();
    loadData();

    scrollController.addListener((){
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        loadData(loadMore: true);
      }
    });
  }

  /// onClose 和 onInit 是成对出现的
  @override
  onClose(){
    super.onClose();
    scrollController.removeListener(() {}); // 先移除监听
    scrollController.dispose();
  }

  Future<void> loadData({loadMore = false}) async{

    if (loadMore) {
      pageIndex ++;
    } else {
      loading.value = true;
      pageIndex = 1;
    }

    try{
      TravelTabModel? model = await TravelDao.getTravels(groupChannelCode, pageIndex, 10);
      List<TravelItem> items = _filterItems(model?.list);
      if (loadMore && items.isEmpty) {
        pageIndex --;
      }

      loading.value = false;
      debugPrint('loadmore $loadMore');
      if (!loadMore) {
        travelItems.clear();
      }

      travelItems.addAll(items);
    }catch(e) {
      debugPrint(e.toString());
      loading.value = false;

      if (loadMore) {
        pageIndex - 1;
      }
    }
  }

  List<TravelItem> _filterItems(List<TravelItem>? list){
    if (list == null) {
      return [];
    }

    List<TravelItem> filterItems = [];

    for (var item in list) {
      if (item.article != null) {
        filterItems.add(item);
      }
    }

    return filterItems;
  }

}