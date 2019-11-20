import 'package:flutter/widgets.dart';

class OnTapData {
  OnTapData(
    this.url, {
    this.type = OnTapType.href,
    this.data,
    this.id,
    this.isOnLongPress = false,
    this.context,
  });

  String url;

  OnTapType type;

  dynamic data;

  String id;

  bool isOnLongPress = false;

  BuildContext context;
}

enum OnTapType {
  href,
  img,
  video,
}
