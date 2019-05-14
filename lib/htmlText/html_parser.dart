import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/htmlText/constants.dart';
import 'package:flutter_app/htmlText/flutter_html_text.dart';
import 'package:flutter_app/htmlText/html_text_style.dart';
import 'package:flutter_app/htmlText/on_tap_data.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

class HtmlParser {
  static const EdgeInsetsGeometry _defaultImagePadding =
      EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0, bottom: 8.0);

  EdgeInsetsGeometry imagePadding;

  static const EdgeInsetsGeometry _defaultVideoPadding =
      EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0, bottom: 8.0);

  EdgeInsetsGeometry videoPadding;

  EdgeInsetsGeometry textPadding;

  HtmlTextStyle htmlTextStyle;

  HtmlParser(
      {this.textPadding,
      this.imagePadding = _defaultImagePadding,
      this.videoPadding = _defaultVideoPadding,
      this.htmlTextStyle});

  List<Widget> parseHtml(String html, {Function onTapCallback}) {
    List<Widget> widgetList = new List();
    dom.Document document = parse(html);
    dom.Element docBody = document.body;
    List<dom.Element> docBodyChildren = docBody.children;
    if (docBodyChildren.length == 0) {
      widgetList.add(Text(html));
    } else {
      docBodyChildren.forEach((e) {
        if (e.outerHtml.contains("<img")) {
          _analysisHtmlImage(e, widgetList, onTapCallback);
        } else if (e.outerHtml.contains("<iframe")) {
          widgetList.add(_createVideo(onTapCallback, e));
        } else if (!e.outerHtml.contains("<img") || !e.hasContent()) {
          print('e.outerHtml-->${e.outerHtml}');
          widgetList.add(_createHtmlText(e.outerHtml, onTapCallback));
        }
      });
    }

    return widgetList;
  }

  GestureDetector _createVideo(Function onTapCallback, dom.Element e) {
    return GestureDetector(
        onTap: () {
          if (onTapCallback != null) {
            onTapCallback(OnTapData(
                e.getElementsByTagName("iframe")[0].attributes['src'],
                type: OnTapType.video));
          }
        },
        child: Container(
          padding: videoPadding,
          child: Image(
            image: AssetImage("assets/images/video_placeholder.png"),
          ),
        ));
  }

  HtmlText _createHtmlText(String html, Function onTapCallback) {
    return new HtmlText(
      html,
      padding: textPadding,
      htmlTextStyle: htmlTextStyle,
      onTapCallback: onTapCallback,
    );
  }

  void _analysisHtmlImage(
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
        _createImage(imgElements[imageIndex++].attributes['src'], widgetList,
            onTapCallback);
      } else {
        widgetList.add(_createHtmlText(html, onTapCallback));
      }
    });
  }

  void _createImage(
      String imageUrl, List<Widget> widgetList, Function onTapCallback) {
    widgetList.add(new GestureDetector(
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback(OnTapData(imageUrl, type: OnTapType.img));
        }
      },
      child: Container(
        padding: imagePadding,
        child: new CachedNetworkImage(
          fadeInDuration: const Duration(seconds: 2),
          fadeOutDuration: const Duration(seconds: 1),
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
