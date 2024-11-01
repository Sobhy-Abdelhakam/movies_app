import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieItemDesign extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;
  const MovieItemDesign(
      {super.key, required this.movieTitle, required this.moviePoster});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
      child: GridTile(
        footer: Container(
          color: Colors.black38,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 10.h,
          ),
          child: Text(
            movieTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: moviePoster,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
          memCacheWidth: 336,
          memCacheHeight: 616,
        ),
      ),
    );
  }
}
