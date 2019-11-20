import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_text/html_parser_to_widget_list.dart';
import 'package:html_text/html_text_style.dart';
import 'package:html_text/on_tap_data.dart';

import 'image.dart';

class AsyncHtmlTextView {
  final String data;

  AsyncHtmlTextView(this.data, {EdgeInsetsGeometry padding});

  final Function onTapCallback = (data) {
    if (data is OnTapData) {
      if (data.type == OnTapType.href) {
        Fluttertoast.showToast(
          msg: data.url,
          gravity: ToastGravity.CENTER,
        );
      } else if (data.type == OnTapType.img) {
        Fluttertoast.showToast(
          msg:
              'currentImageUrl:  ${data.url}      imageList: ${getArticleImageList(data.id).toString()}',
          gravity: ToastGravity.CENTER,
        );
      } else if (data.type == OnTapType.video) {
        Fluttertoast.showToast(
          msg: data.url,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  };

  build(Function onParserCallback, {List<String> imageList, String id}) {
    HtmlParserToWidgetList(
      imagePadding:
          EdgeInsets.only(top: 2.0, left: 12.0, right: 12.0, bottom: 0.0),
      videoPadding:
          EdgeInsets.only(top: 4.0, left: 12.0, right: 12.0, bottom: 2.0),
      htmlTextStyle: HtmlTextStyle(
        height: 1.6,
        fontSize: 17,
        padding:
            EdgeInsets.only(top: 6.0, left: 12.0, right: 12.0, bottom: 8.0),
        digitalFontWeight: DigitalFontWeight.strong,
        digitalPrefix: '    ',
        pointPrefix: '    ',
        defaultTextColor: Color(0xff333333),
        letterSpacing: 1.0,
      ),
      isInPackage: false,
    )
        .asyncParseHtmlToWidgetList(this.data,
            onTapCallback: this.onTapCallback, imageList: imageList, id: id)
        .then((nodes) {
      if (onParserCallback != null) {
        onParserCallback(nodes);
      }
    });
  }
}
