import 'package:flutter/material.dart';

import 'html_parser_to_widget_list.dart';
import 'html_text_style.dart';
import 'on_tap_data.dart';

class HtmlTextView extends StatelessWidget {
  final String data;

  HtmlTextView(this.data, {EdgeInsetsGeometry padding});

  final Function onTapCallback = (data) {
    if (data is OnTapData) {
      debugPrint('data.type--->${data.type}');
      if (data.type == OnTapType.href) {
      } else if (data.type == OnTapType.img) {
      } else if (data.type == OnTapType.video) {
      }
    }
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> nodes = HtmlParserToWidgetList(
      imagePadding:
      EdgeInsets.only(top: 12.0, left: 0.0, right: 0.0, bottom: 12.0),
      videoPadding:
      EdgeInsets.only(top: 12.0, left: 0.0, right: 0.0, bottom: 12.0),
      htmlTextStyle: HtmlTextStyle(
        hrefTextDecoration: TextDecoration.underline,
        hrefTextColor: Colors.amber,
        height: 1.4,
        fontSize: 15,
        padding: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 4.0),
        digitalFontWeight: DigitalFontWeight.strong,
        digitalPrefix: '    ',
        pointPrefix: '    ',
        blockQuoteColor: Colors.teal,
        blockQuoteWidth: 5,
        blockQuotMargin: EdgeInsets.only(left: 10, right: 10),
        blockQuotTextMargin: EdgeInsets.only(left: 25),
      ),
    ).parseHtmlToWidgetList(this.data, onTapCallback: this.onTapCallback);

    return new Container(
        padding: const EdgeInsets.all(0.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: nodes,
        ));
  }
}
