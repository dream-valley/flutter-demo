import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

class TravelItemWidget extends StatelessWidget {

  final TravelItem item;
  final int? index;

  const TravelItemWidget({super.key, required this.item, this.index});

  get _title => Container(
    padding: EdgeInsets.all(4),
    child: Text(item.article?.articleTitle ?? "", maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black54),),
  );

  get _infoText => Container(
    padding: EdgeInsets.fromLTRB(6,0,6,10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 注意这里的布局
        _avatarNickName,
        _likeIcon
      ],
    )
  );

  get _avatarNickName =>  Row(
    children: [
      PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: Image.network(item.article?.author?.coverImage?.dynamicUrl??"", width: 24, height: 24,),
      ),
      Container(
        padding: EdgeInsets.all(5),
        width: 90,
        child: Text(
            item.article?.author?.nickName ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12)
        )
        ,
      )
    ],
  );

  get _likeIcon => Row(
    children: [
      const Icon(Icons.thumb_up, size: 14, color: Colors.grey,),
      Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Text(item.article?.likeCount.toString() ?? "", style: TextStyle(fontSize: 10),),
      )
    ],
  );


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        String? url = _findJumpUrl();
        NavigatorUtil.jumpH5(
          url: url!,
          title: "详情"
        );
      },
      child: Card(
        child: PhysicalModel(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(6),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemImage(context),
              _title,
              _infoText
            ],
          ),
        ),
      )

    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints( // 设置固定高度，防止加载过程中高度塌陷
            minHeight: size.width / 2 - 10,
          ),
          child: FadeInImage.memoryNetwork(
            placeholder:kTransparentImage,
            image: item?.article?.images?[0].dynamicUrl ?? "",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(Icons.location_on, color: Colors.white, size: 12,)
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    style: TextStyle(color: Colors.white, fontSize: 12 ),
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        )
      ],
    );
  }

  String _poiName () {
    return item.article?.pois == null || item.article!.pois!.isEmpty ? '未知' : item.article?.pois?[0].poiName??'未知';
  }


  String? _findJumpUrl(){
    if (item.article?.urls?.isEmpty ?? false) {
      return null;
    }

    for (var url in item.article!.urls!) {
      if (url.h5Url != null) {
        return url.h5Url;
      }
    }

    return null;
  }
}
