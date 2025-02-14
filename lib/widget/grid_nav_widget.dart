

import 'package:flutter/material.dart';
import 'package:trip_flutter/model/home_model.dart';

class GridNavWidget extends StatelessWidget {
  final GridNav gridNavModel;
  const GridNavWidget({super.key, required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0), child:
      PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridEnvItems(context),
        ),)
      );
  }

  _gridEnvItems(BuildContext context){
    List<Widget> items = [];

    items.add(_gridNavItem(context, gridNavModel.hotel!, true));
    items.add(_gridNavItem(context, gridNavModel.flight!, false));
    items.add(_gridNavItem(context, gridNavModel.travel!, false));

    return items;
  }

  Widget _gridNavItem(BuildContext context, Hotel gridNavItem, bool first){
    List<Widget> items = [];

    items.add(_mainItem(context, gridNavItem.mainItem!));
    items.add(_doubleItem(context, gridNavItem.item1!, gridNavItem.item2!));
    items.add(_doubleItem(context, gridNavItem.item3!, gridNavItem.item4!));

    // 左右排列的 item
    List<Widget> expandItems = [];
    for(var item in items){
      // 设置每个 item 平分间距
      expandItems.add(Expanded(flex:1, child: item));
    }
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor!}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor!}'));

    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        // 线性渐变
        gradient: LinearGradient(colors: [startColor, endColor])
      ),
      child: Row(children: expandItems),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel model){
    return _wrapGesture(context, Stack(
      alignment:  AlignmentDirectional.topCenter,
      children: [
        Image.network(
          model.icon!,
          fit: BoxFit.contain,
          height: 88,
          width: 121,
          alignment: AlignmentDirectional.bottomEnd
        ),
        Container(
          margin: const EdgeInsets.only(top: 11),
          child: Text(
            model.title!,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          )
        )
      ],
    ), model);
  }

  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model){
    return GestureDetector(
      onTap: (){},
      child: widget,
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem){

    return Column(
      children: [
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false)),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel item, bool first){
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return Container(
      decoration: BoxDecoration(
          border: Border( left: borderSide, bottom: first ? borderSide : BorderSide.none )
      ),
      child: _wrapGesture(
        context,
        Center(
          child: Text(item.title!, style: const TextStyle(fontSize: 14, color: Colors.white)),
        ),
        item
      ),
    );
  }
}
