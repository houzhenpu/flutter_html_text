import 'dart:ui';

import 'package:flutter/cupertino.dart';

class HtmlTextStyle {
  double fontSize;

  TextDecoration hrefTextDecoration;

  double height;

  Color color;

  Color defaultTextColor = Color(0xFF000000);

  double defaultFontSize = 14.0;

  double digitalFontSize = 14.0;

  double pointFontSize = 14.0;

  String digitalFontWeight;

  String digitalPrefix;

  String pointPrefix;

  Color blockQuoteColor;

  static const Color defaultBlockQuoteColor = Color(0xFF2576a5);

  double blockQuoteWidth;

  EdgeInsetsGeometry blockQuotMargin;

  static const EdgeInsetsGeometry defaultBlockQuotMargin =
      EdgeInsets.only(left: 3, right: 12);

  EdgeInsetsGeometry blockQuotTextMargin;

  static const EdgeInsetsGeometry defaultBlockQuotTextMargin =
      EdgeInsets.only(left: 15);

  HtmlTextStyle({
    this.fontSize = 14.0,
    this.hrefTextDecoration = TextDecoration.none,
    this.height = 1.2,
    this.defaultTextColor,
    this.digitalFontSize = 14.0,
    this.pointFontSize = 14.0,
    this.digitalFontWeight,
    this.digitalPrefix,
    this.pointPrefix,
    this.blockQuoteColor = defaultBlockQuoteColor,
    this.blockQuoteWidth = 3,
    this.blockQuotMargin = defaultBlockQuotMargin,
    this.blockQuotTextMargin = defaultBlockQuotTextMargin,
  });
}

class DigitalFontWeight {
  static const String strong = 'strong';
}
