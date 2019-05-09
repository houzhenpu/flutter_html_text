class OnTapData {
  OnTapData(this.url, {this.type = OnTapType.href, this.data});

  String url;

  OnTapType type;

  dynamic data;
}

enum OnTapType {
  href,
  img,
  video,
}
