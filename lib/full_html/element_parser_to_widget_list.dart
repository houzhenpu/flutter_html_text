import 'package:flutter/material.dart';

import 'constants.dart';
import 'flutter_html_text.dart';
import 'html_text_style.dart';
import 'network_image.dart';
import 'package:html/dom.dart' as dom;

import 'on_tap_data.dart';

class ElementParserToWidgetList {
  static const EdgeInsetsGeometry _defaultImagePadding =
      EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0, bottom: 8.0);

  EdgeInsetsGeometry imagePadding;

  static const EdgeInsetsGeometry _defaultVideoPadding =
      EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0, bottom: 8.0);

  EdgeInsetsGeometry videoPadding;

  HtmlTextStyle htmlTextStyle;

  ElementParserToWidgetList(
      {this.imagePadding = _defaultImagePadding,
      this.videoPadding = _defaultVideoPadding,
      this.htmlTextStyle});

  List<Widget> parseElementToWidgetList(dom.Element element,
      {Function onTapCallback, List<String> imageList, String id}) {
    List<Widget> widgetList = new List();
    if (element.outerHtml.contains("<img")) {
      _analysisHtmlImage(element, widgetList, onTapCallback,
          imageList: imageList, id: id);
    } else if (element.outerHtml.contains("<iframe")) {
      widgetList.add(_createVideo(onTapCallback, element));
    } else if (element.hasContent()) {
      widgetList.add(_createHtmlText(element.outerHtml, onTapCallback));
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
      htmlTextStyle: htmlTextStyle,
      onTapCallback: onTapCallback,
    );
  }

  void _analysisHtmlImage(
      dom.Element e, List<Widget> widgetList, Function onTapCallback,
      {List<String> imageList, String id}) {
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
        String imageUrl = imgElements[imageIndex++].attributes['src'];
        imageList?.add('"$imageUrl"');
        _createImage(imageUrl, widgetList, onTapCallback, id: id);
      } else {
        widgetList.add(_createHtmlText(html, onTapCallback));
      }
    });
  }

  void _createImage(
      String imageUrl, List<Widget> widgetList, Function onTapCallback,
      {String id}) {
    widgetList.add(new GestureDetector(
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback(OnTapData(imageUrl, type: OnTapType.img, id: id));
        }
      },
      child: Center(
        child: Container(
          padding: imagePadding,
          child: NetworkImageClipper(
            imageUrl,
            id: id,
          ),
        ),
      ),
    ));
  }
}
