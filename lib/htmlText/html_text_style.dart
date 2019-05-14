import 'dart:ui';

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

  HtmlTextStyle(
      {this.fontSize = 14.0,
      this.hrefTextDecoration = TextDecoration.none,
      this.height = 1.2,
      this.defaultTextColor,
      this.digitalFontSize = 14.0,
      this.pointFontSize = 14.0,
      this.digitalFontWeight});
}

class DigitalFontWeight {

  static const String strong = 'strong';

}


