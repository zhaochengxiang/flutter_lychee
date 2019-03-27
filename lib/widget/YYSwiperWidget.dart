import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lychee/common/model/YYBanner.dart';

typedef void YYSwiperSelectItemChanged<int>(int value);

class YYSwiperWidget extends StatelessWidget {

  final double height;
  final List urls;
  final IconData iconPrevious;
  final IconData iconNext;
  final Color dotColor;
  final double dotSize;
  final Color dotActiveColor;
  final double dotActiveSize;
  final YYSwiperSelectItemChanged selectItemChanged;

  YYSwiperWidget({@required this.height,@required this.urls,this.iconPrevious, this.iconNext, this.dotColor, this.dotSize = 6.0, this.dotActiveColor, this.dotActiveSize = 6.0, this.selectItemChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Swiper(
          itemBuilder: _swiperBuilder,
          itemCount: urls.length,
          pagination:  (urls.length>1)?new SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              color:dotColor??Colors.white,
              size: dotSize,
              activeColor: dotActiveColor??Theme.of(context).primaryColor,
              activeSize: dotActiveSize,
            )
          ):null,
          control: new SwiperControl(
            iconPrevious: iconPrevious??null,
            iconNext: iconNext??null,
          ),
          scrollDirection: Axis.horizontal,
          autoplay: (urls.length>1)?true:false,
          loop: (urls.length>1)?true:false,
          onTap: (index) => selectItemChanged?.call(index),
        ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      urls[index],
      fit: BoxFit.fill,
    ));
  }
}
