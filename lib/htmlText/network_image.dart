import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CachedNetworkImage createCachedNetworkImage(String imageUrl) {
  return new CachedNetworkImage(
    placeholder: (context, url) => new CircularProgressIndicator(),
    errorWidget: (context, url, error) => Image(
          image: AssetImage("assets/images/image_error.png"),
        ),
    fadeInDuration: const Duration(seconds: 2),
    fadeOutDuration: const Duration(seconds: 1),
    imageUrl: imageUrl,
    fit: BoxFit.cover,
  );
}
