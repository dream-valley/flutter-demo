import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dao/travel_dao.dart';
import '../model/travel_category_model.dart';

class TravelController extends GetxController with GetTickerProviderStateMixin {
  List<TravelTab> tabs = [];
  // TravelCategoryModel? travelTabModel;
  late TabController controller;


  @override
  void onInit(){
    super.onInit();
    controller = TabController(length: 0, vsync: this);

    TravelDao.getCategory().then((TravelCategoryModel? model){
      controller = TabController(length: model?.tabs?.length ?? 0 , vsync: this);


      tabs = model?.tabs ?? [];
      // travelTabModel = model;

      update(); // update 代替 setState
    });
  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }
}
