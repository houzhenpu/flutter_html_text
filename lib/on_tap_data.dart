class OnTapData {
  OnTapData(this.url, {this.type = OnTapType.href, this.data,this.id});

  String url;

  OnTapType type;

  dynamic data;

  String id;
}

enum OnTapType {
  href,
  img,
  video,
}
