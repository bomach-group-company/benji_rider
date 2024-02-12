import 'package:benji_rider/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../repo/controller/api_url.dart';

class MyImage extends StatelessWidget {
  final String? url;
  const MyImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url == null ? '' : '${Api.baseUrl}$url',
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const Center(
              child: CupertinoActivityIndicator(
        color: kRedColor,
      )),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: kRedColor,
      ),
    );
  }
}
