import 'dart:ui';

import 'package:flutter/widgets.dart';

class HtmlTextStyle {
  ///字体大小
  double fontSize;

  /// a 链接 A linear decoration to draw near the text.
  TextDecoration hrefTextDecoration;

  ///a 链接字体颜色
  Color hrefTextColor;

  ///a 链接字体默认颜色
  static const Color defaultHrefTextColor = Color(0xFF5193ad);

  ///行高
  double height;

  ///字体颜色
  Color color;

  ///默认字体颜色
  Color defaultTextColor = Color(0xFF000000);

  ///默认字体大小
  double defaultFontSize = 14.0;

  ///段落padding
  EdgeInsetsGeometry padding;

  ///默认段落padding
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 4.0);

  ///数字标签大小
  double digitalFontSize = 14.0;

  ///点标签大小
  double pointFontSize = 14.0;

  ///点标签字体样式，默认普通样式 可以设置为  DigitalFontWeight.strong
  String digitalFontWeight;

  ///数字标签前缀
  String digitalPrefix;

  ///点标签前缀
  String pointPrefix;

  ///引用线条颜色
  Color blockQuoteColor;

  ///引用线条默认颜色
  static const Color defaultBlockQuoteColor = Color(0xFF2576a5);

  ///引用线条宽度
  double blockQuoteWidth;

  ///引用线条Margin
  EdgeInsetsGeometry blockQuotMargin;

  ///引用线条默认Margin
  static const EdgeInsetsGeometry defaultBlockQuotMargin =
      EdgeInsets.only(left: 3, right: 12);

  ///引用线条文字Margin  和 blockQuotMargin，blockQuoteWidth结合绘制线条和文字的相对位置
  EdgeInsetsGeometry blockQuotTextMargin;

  ///引用线条文字默认Margin
  static const EdgeInsetsGeometry defaultBlockQuotTextMargin =
      EdgeInsets.only(left: 15);

  /// 字符间距  就是单个字母或者汉字之间的间隔，可以是负数
  double letterSpacing;

  /// 字间距 句字之间的间距
  double wordSpacing;

  HtmlTextStyle({
    this.fontSize = 14.0,
    this.hrefTextDecoration = TextDecoration.none,
    this.hrefTextColor = defaultHrefTextColor,
    this.height = 1.4,
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
    this.padding = defaultPadding,
    this.letterSpacing,
    this.wordSpacing,
  });
}

class DigitalFontWeight {
  static const String strong = 'strong';
}
