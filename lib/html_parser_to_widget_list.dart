import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

import 'constants.dart';
import 'flutter_html_text.dart';
import 'html_text_style.dart';
import 'network_image.dart';
import 'on_tap_data.dart';
import 'web_view_page.dart';

class HtmlParserToWidgetList {
  static const EdgeInsetsGeometry _defaultImagePadding =
      EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0, bottom: 8.0);

  EdgeInsetsGeometry imagePadding;

  static const EdgeInsetsGeometry _defaultVideoPadding =
      EdgeInsets.only(top: 4.0, left: 0.0, right: 0.0, bottom: 8.0);

  EdgeInsetsGeometry videoPadding;

  HtmlTextStyle htmlTextStyle;

  bool isInPackage = true;

  HtmlParserToWidgetList(
      {this.imagePadding = _defaultImagePadding,
      this.videoPadding = _defaultVideoPadding,
      this.htmlTextStyle,
      this.isInPackage = true});

  Future<List<Widget>> asyncParseHtmlToWidgetList(String html,
      {Function onTapCallback,
      List<String> imageList,
      String id,
      BuildContext context}) async {
    return await _getWidgetListFromHtml(html,
        onTapCallback: onTapCallback,
        imageList: imageList,
        id: id,
        context: context);
  }

  Future<List<Widget>> _getWidgetListFromHtml(String html,
      {Function onTapCallback,
      List<String> imageList,
      String id,
      BuildContext context}) async {
    return parseHtmlToWidgetList(
      html,
      onTapCallback: onTapCallback,
      imageList: imageList,
      id: id,
      context: context,
    );
  }

  List<Widget> parseHtmlToWidgetList(String html,
      {Function onTapCallback,
      List<String> imageList,
      String id,
      BuildContext context}) {
    List<Widget> widgetList = new List();
    if (html == null) {
      widgetList.add(Container());
      return widgetList;
    }
    List<dom.Element> docBodyChildren = parse(html).body.children;
    if (docBodyChildren.length == 0) {
      widgetList.add(Container(
        padding: htmlTextStyle.padding,
        child: Text(html,
            style: TextStyle(
                height: htmlTextStyle.height,
                letterSpacing: htmlTextStyle.letterSpacing,
                fontSize: htmlTextStyle.fontSize)),
      ));
    } else {
      docBodyChildren.forEach((e) {
        if (e.outerHtml.contains("<img")) {
          _analysisHtmlImage(e, widgetList, onTapCallback,
              imageList: imageList, id: id, context: context);
        } else if (e.outerHtml.contains("<iframe")) {
          widgetList.add(_createVideo(onTapCallback, e));
        } else if (e.hasContent()) {
          widgetList.add(_createHtmlText(e.outerHtml, onTapCallback));
        }
      });
    }

    return widgetList;
  }

  Widget _createVideo(Function onTapCallback, dom.Element e) {
    return WebViewVideo(
      e.getElementsByTagName("iframe")[0].attributes['src'],
      onTapCallback: onTapCallback,
    );
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
      {List<String> imageList, String id, BuildContext context}) {
    String outerHtml = e.outerHtml;

    var imgElements = e.getElementsByTagName("img");
    if (imgElements.length == 0) {
      imgElements.add(e);
    }
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
        imageList?.add('$imageUrl');
        _createImage(imageUrl, widgetList, onTapCallback,
            id: id, context: context);
      } else {
        String tempHtml = html.replaceAll('&nbsp;', '');
        if (!'<p></p>'.endsWith(tempHtml)) {
          widgetList.add(_createHtmlText(tempHtml, onTapCallback));
        }
      }
    });
  }

  void _createImage(
    String imageUrl,
    List<Widget> widgetList,
    Function onTapCallback, {
    String id,
    BuildContext context,
  }) {
    widgetList.add(new GestureDetector(
      onTap: () {
        if (onTapCallback != null) {
          onTapCallback(OnTapData(imageUrl,
              type: OnTapType.img, id: id, context: context));
        }
      },
      onLongPress: () {
        if (onTapCallback != null) {
          onTapCallback(OnTapData(imageUrl,
              type: OnTapType.img,
              id: id,
              isOnLongPress: true,
              context: context));
        }
      },
      child: Center(
        child: Container(
          padding: imagePadding,
          child: NetworkImageClipper(
            imageUrl,
            id: id,
            isInPackage: isInPackage,
          ),
        ),
      ),
    ));
  }
}
