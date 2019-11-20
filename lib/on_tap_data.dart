import 'package:flutter/widgets.dart';

class OnTapData {
  OnTapData(
    this.url, {
    this.type = OnTapType.href,
    this.data,
    this.id,
    this.isOnLongPress = false,
    BuildContext context,
  });

  String url;

  OnTapType type;

  dynamic data;

  String id;

  bool isOnLongPress = false;
}

enum OnTapType {
  href,
  img,
  video,
}
