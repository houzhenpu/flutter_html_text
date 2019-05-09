import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/htmlText/constants.dart';
import 'package:flutter_app/htmlText/flutter_html_text.dart';
import 'package:flutter_app/htmlText/on_tap_data.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

class HtmlParser {
  HtmlParser();

  List<Widget> HParse(String html, {Function onTapCallback}) {
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
      if (e.outerHtml.contains("<img")) {
        analysisHtmlImage(e, widgetList, onTapCallback);
      } else if (e.outerHtml.contains("<iframe")) {
        widgetList.add(GestureDetector(
            onTap: () {
              if (onTapCallback != null) {
                onTapCallback(OnTapData(
                    e.getElementsByTagName("iframe")[0].attributes['src'],
                    type: OnTapType.video));
              }
            },
            child: Image(
              image: AssetImage("assets/images/video_placeholder.png"),
            )));
      } else if (!e.outerHtml.contains("<img") || !e.hasContent()) {
        widgetList.add(new HtmlText(
          data: e.outerHtml,
          onTapCallback: onTapCallback,
        ));
      }
    });

    return widgetList;
  }

  void analysisHtmlImage(
      dom.Element e, List<Widget> widgetList, Function onTapCallback) {
    String outerHtml = e.outerHtml;

    var imgElements = e.getElementsByTagName("img");
    if (e.nodes.length > 1) {
      imgElements.forEach((f) {
        outerHtml = outerHtml.replaceAll(
            '${f.outerHtml}', '</p>$separator<p>${f.outerHtml}$separator<p>');
      });
    }
    int imageIndex = 0;
    outerHtml.split(separator).forEach((html) {
      if (html.contains("<img")) {
        createImage(imgElements[imageIndex++].attributes['src'], widgetList,
            onTapCallback);
      } else {
        widgetList.add(new HtmlText(
          data: html,
          onTapCallback: onTapCallback,
        ));
      }
    });
  }

  void createImage(
      String imageUrl, List<Widget> widgetList, Function onTapCallback) {
    widgetList.add(new GestureDetector(
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback(OnTapData(imageUrl, type: OnTapType.img));
        }
      },
      child: new CachedNetworkImage(
        fadeInDuration: const Duration(seconds: 2),
        fadeOutDuration: const Duration(seconds: 1),
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    ));
  }
}
