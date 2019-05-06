import 'package:flutter/material.dart';
import 'package:flutter_app/htmlText/on_tap_data.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:flutter_app/htmlText/flutter_html_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HtmlParser {
  HtmlParser();

  List<Widget> HParse(String html, Function onTapCallback) {
    List<Widget> widgetList = new List();

    dom.Document document = parse(html);

    dom.Element docBody = document.body;

    List<dom.Element> styleElements = docBody.getElementsByTagName("style");
    List<dom.Element> scriptElements = docBody.getElementsByTagName("script");
    if (styleElements.length > 0) {
      for (int i = 0; i < styleElements.length; i++) {
        docBody.getElementsByTagName("style").first.remove();
      }
    }
    if (scriptElements.length > 0) {
      for (int i = 0; i < scriptElements.length; i++) {
        docBody.getElementsByTagName("script").first.remove();
      }
    }

    List<dom.Element> docBodyChildren = docBody.children;
    docBodyChildren.forEach((e) {
      print('e.outerHtml--->${e.outerHtml}');
      if (e.outerHtml.contains("<img")) {
        var imgElements = e.getElementsByTagName("img");
        if (imgElements.length > 0) {
          widgetList.add(new GestureDetector(
            onTap: () {
              if (onTapCallback != null) {
                onTapCallback(OnTapData(
                    url: imgElements[0].attributes['src'],
                    type: OnTapType.img));
              }
            },
            child: new CachedNetworkImage(
              fadeInDuration: const Duration(seconds: 2),
              fadeOutDuration: const Duration(seconds: 1),
              imageUrl: imgElements[0].attributes['src'],
              fit: BoxFit.cover,
            ),
          ));
        }
      } else if (!e.outerHtml.contains("<img") || !e.hasContent()) {
        widgetList.add(new HtmlText(
          data: e.outerHtml,
          onTapCallback: onTapCallback,
        ));
      }
    });

    return widgetList;
  }
}
