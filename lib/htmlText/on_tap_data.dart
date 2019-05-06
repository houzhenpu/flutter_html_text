class OnTapData {
  OnTapData({this.url, this.type, this.data});

  String url;

  OnTapType type = OnTapType.href;

  dynamic data;
}

enum OnTapType {
  href,
  img,
}
