import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gri_client/size/MySize.dart';

class ImageViewer extends StatefulWidget {
  final String url;
  const ImageViewer({Key? key, required this.url}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MySize.sizeh100(context),
          width: MySize.size100(context),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: MySize.size5(context)),
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: widget.url,
            // errorWidget: (context, url, error) {
            //   return Icon(
            //       Icons.sad,
            //       size: 120,,
            //   );
            // },
          ),
        ),
      ),
    );
  }
}
