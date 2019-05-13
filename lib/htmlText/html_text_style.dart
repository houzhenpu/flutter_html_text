import 'dart:ui';

class HtmlTextStyle {
  double fontSize;

  TextDecoration hrefTextDecoration;

  double height;

  Color color;

  Color defaultTextColor = Color(0xFF000000);

  HtmlTextStyle(
      {this.fontSize = 14.0,
      this.hrefTextDecoration = TextDecoration.none,
      this.height = 1.2,
      this.defaultTextColor});
}
