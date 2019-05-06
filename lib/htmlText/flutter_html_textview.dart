import 'package:flutter/material.dart';
import 'package:flutter_app/htmlText/html_parser.dart';
import 'package:flutter_app/htmlText/on_tap_data.dart';
import 'package:oktoast/src/toast.dart';

class HtmlTextView extends StatelessWidget {
  final String data;

  HtmlTextView({this.data});

  Function onTapCallback = (data) {
    if (data is OnTapData) {
      print('data.type--->${data.type}');
      if (data.type == OnTapType.href) {
        showToast(data.url, position: ToastPosition.bottom);
      } else if (data.type == OnTapType.img) {
        showToast(data.url, position: ToastPosition.center);
      }
    }
  };

  @override
  Widget build(BuildContext context) {
    HtmlParser htmlParser = new HtmlParser();

    List<Widget> nodes = htmlParser.HParse(this.data, this.onTapCallback);

    return new Container(
        padding: const EdgeInsets.all(0.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: nodes,
        ));
  }
}
