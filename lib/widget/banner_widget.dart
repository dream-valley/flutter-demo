

import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/screen-adapter-helper.dart';

class BannerWidget extends StatefulWidget {
  final List<CommonModel> bannerList;
  const BannerWidget( {super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _current = 0;
  final CarouselController _controller =  CarouselController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CarouselSlider(
          items: widget.bannerList.map((item) => _tabImage(item, width)).toList(),
          carouselController: _controller,
          options:  CarouselOptions(
            height: 160.px,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          )
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: _indicator()
        )
      ],
    ) ;
  }

  Widget _tabImage(CommonModel model, double width){
    return GestureDetector(
      onTap: (){
        // TODO navigator
      },
      child: Image.network(model.icon!, width: width, fit: BoxFit.cover),
    );
  }

  _indicator(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.bannerList.asMap().entries.map((entry){
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key), // key 是 index
          child: Container(
            width: 6,
            height: 6,
            margin:  EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Colors.white).withOpacity(_current == entry.key ? 0.9 : 0.4)
            ),
          ),
        );
      }).toList(),
    );
  }
}
