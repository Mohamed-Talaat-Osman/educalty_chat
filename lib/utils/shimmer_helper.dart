import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';


class ShimmerHelper {
  static final Color _shimmerBase = Colors.grey.withOpacity(0.3);
  static final Color _shimmerHighlighted = Colors.grey.withOpacity(0.1);



  buildUsersShimmer({
    itemCount = 4,
    double? height
  }) {
    return ListView.separated(
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Shimmer.fromColors(
            baseColor: _shimmerBase,
            highlightColor: _shimmerHighlighted,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x102c3e50),
                    offset: Offset(0, 0),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 5,
        );
      },
    );
  }

  buildImagesLoadingShimmer({height,width,paddingHorizontal}) {
    return  SizedBox(
        height: 20,
        width: 20 ,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: paddingHorizontal??0),
          child: Shimmer.fromColors(
            baseColor: _shimmerBase,
            highlightColor: _shimmerHighlighted,
            child: Container(
              height: 55, width: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x102c3e50),
                    offset: Offset(0, 0),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
