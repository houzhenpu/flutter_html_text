import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/htmlText/on_tap_data.dart';
import 'constants.dart';
import 'html_tags.dart';
import 'package:flutter_app/htmlText/html_text_style.dart';

// ignore: must_be_immutable
class HtmlText extends StatelessWidget {
  String data;

  final Function onTapCallback;

  static const EdgeInsetsGeometry _defaultPadding =
      EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 4.0);

  EdgeInsetsGeometry padding;

  HtmlTextStyle htmlTextStyle;

  HtmlText(this.data,
      {this.onTapCallback, this.padding = _defaultPadding, this.htmlTextStyle});

  @override
  Widget build(BuildContext context) {
    HtmlParser parser = new HtmlParser(htmlTextStyle: this.htmlTextStyle);

    return Container(
      padding: padding ?? _defaultPadding,
      child: this.data.startsWith(blockQuote)
          ? createBlockQuote(parser, context)
          : _createRichText(parser, context),
    );
  }

  Stack createBlockQuote(HtmlParser parser, BuildContext context) {
    this.data = this.data.replaceAll(endStartPTag, lineBreakTag);
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15),
          child: _createRichText(parser, context),
        ),
        Positioned(
          top: 1,
          bottom: 1,
          child: Container(
            color: Colors.tealAccent,
            width: 3,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 3, right: 12),
          ),
        ),
      ],
    );
  }

  RichText _createRichText(HtmlParser parser, BuildContext context) {
    return RichText(
      text: this._stackToTextSpan(parser.parse(this.data), context),
      softWrap: true,
      textAlign: parser.textAlign,
    );
  }

  TextSpan _stackToTextSpan(List nodes, BuildContext context) {
    List<TextSpan> children = <TextSpan>[];
    for (int i = 0; i < nodes.length; i++) {
      children.add(_textSpan(nodes[i]));
    }
    return new TextSpan(
        text: '',
        style: DefaultTextStyle.of(context).style,
        children: children);
  }

  TextSpan _textSpan(Map node) {
    TextSpan span = new TextSpan(
        text: node['text'],
        style: node['style'],
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (onTapCallback != null && node['href'] != '') {
              onTapCallback(OnTapData(node['href']));
            }
          });
    return span;
  }
}

class HtmlParser {
  HtmlTextStyle htmlTextStyle;

  HtmlParser({this.htmlTextStyle});

  List<String> _stack = [];
  List<String> _spanStyle = [];
  List _result = [];
  Map<String, dynamic> _tag;
  TextAlign textAlign = TextAlign.left;

  List parse(String html) {
    String last = html;
    Match match;
    int index;
    bool chars;
    int tagIndex = 1;
    bool isAppendStartTag = false;
    if (htmlTextStyle == null) {
      htmlTextStyle = HtmlTextStyle();
    }
    while (html.length > 0) {
      chars = true;
      if (this._getStackLastItem() == null ||
          !specialTags.contains(this._getStackLastItem())) {
        if (html.indexOf('<!--') == 0) {
          index = html.indexOf('-->');
          if (index >= 0) {
            html = html.substring(index + 3);
            chars = false;
          }
        } else if (html.indexOf('</') == 0) {
          isAppendStartTag = false;
          match = endTag.firstMatch(html);
          if (match != null) {
            String tag = match[0];
            html = html.substring(tag.length);
            chars = false;
            this._parseEndTag(tag);
          }
        } else if (html.indexOf('<') == 0) {
          match = startTag.firstMatch(html);
          if (match != null) {
            String tag = match[0];
            html = html.substring(tag.length);
            chars = false;
            this._parseStartTag(
                tag, match[1], match[2], match.start, isAppendStartTag);
            isAppendStartTag = true;
          }
        }

        if (chars) {
          index = html.indexOf('<');
          String text = (index < 0) ? html : html.substring(0, index);
          html = (index < 0) ? '' : html.substring(index);
          if (html.contains(ulTag)) {
            text = '• ' + text + lineBreakTag;
          } else if (html.contains(olTag)) {
            text = tagIndex.toString() + '. ' + text + lineBreakTag;
          }
          tagIndex++;
          this._appendNode(text);
        }
      } else {
        RegExp re =
            new RegExp(r'(.*)<\/' + this._getStackLastItem() + r'[^>]*>');
        html = html.replaceAllMapped(re, (Match match) {
          String text = match[0]
            ..replaceAll(new RegExp('<!--(.*?)-->'), '\$1')
            ..replaceAll(new RegExp('<!\[CDATA\[(.*?)]]>'), '\$1');
          this._appendNode(text);
          return '';
        });
        this._parseEndTag(this._getStackLastItem());
      }
      if (html == last) {
        throw 'Parse Error: ' + html;
      }
      last = html;
    }
    this._parseEndTag();
    List result = this._result;
    this._stack = [];
    this._result = [];
    this._spanStyle = [];
    return result;
  }

  void _parseStartTag(String tag, String tagName, String rest, int unary,
      bool isAppendStartTag) {
    tagName = tagName.toLowerCase();
    if (blockTags.contains(tagName)) {
      while (this._getStackLastItem() != null &&
          inlineTags.contains(this._getStackLastItem())) {
        this._parseEndTag(this._getStackLastItem());
      }
    }
    if (closeSelfTags.contains(tagName) &&
        this._getStackLastItem() == tagName) {
      this._parseEndTag(tagName);
    }
    if (emptyTags.contains(tagName)) {
      unary = 1;
    }
    if (unary == 0) {
      this._stack.add(tagName);
    }
    Map attrs = {};
    Iterable<Match> matches = attrTag.allMatches(rest);

    if (matches != null) {
      for (Match match in matches) {
        String attribute = match[1];
        String value;

        if (match[2] != null) {
          value = match[2];
        } else if (match[3] != null) {
          value = match[3];
        } else if (match[4] != null) {
          value = match[4];
        } else if (fillAttrs.contains(attribute) != null) {
          value = attribute;
        }
        attrs[attribute] = value;
        if (attribute.endsWith('style') && tagName.endsWith('span')) {
          this._spanStyle.add(value);
        }
      }
    }
    this._appendTag(tagName, attrs, isAppendStartTag);
  }

  void _parseEndTag([String tagName]) {
    int pos;
    if (tagName == null) {
      pos = 0;
    } else {
      if (tagName.contains('span')) {
        this._spanStyle.removeLast();
      }
      for (pos = this._stack.length - 1; pos >= 0; pos--) {
        if (this._stack[pos] == tagName || tagName.contains(this._stack[pos])) {
          this._stack.remove(tagName);
          break;
        }
      }
    }
    if (pos >= 0) {
      this._stack.removeRange(pos, this._stack.length);
    }
  }

  TextStyle _parseStyle(List<String> tags, Map attrs) {
    Iterable<Match> matches;
    String spanStyle = '';
    if (this._spanStyle.isNotEmpty) {
      spanStyle = this._spanStyle.last.toString();
    }
    String style = '$spanStyle${attrs['style']}';
    String param;
    String value;

    FontWeight fontWeight = FontWeight.normal;
    FontStyle fontStyle = FontStyle.normal;
    TextDecoration textDecoration = TextDecoration.none;
    htmlTextStyle.color = htmlTextStyle.defaultTextColor;
    tags.forEach((tag) {
      switch (tag) {
        case 'h1':
          htmlTextStyle.fontSize = 32.0;
          break;
        case 'h2':
          htmlTextStyle.fontSize = 24.0;
          break;
        case 'h3':
          htmlTextStyle.fontSize = 20.8;
          break;
        case 'h4':
          htmlTextStyle.fontSize = 16.0;
          break;
        case 'h5':
          htmlTextStyle.fontSize = 12.8;
          break;
        case 'h6':
          htmlTextStyle.fontSize = 11.2;
          break;
        case 'a':
          textDecoration = htmlTextStyle.hrefTextDecoration;
          htmlTextStyle.color = new Color(int.parse('0xFF5193ad'));
          break;
        case 'b':
        case 'strong':
          fontWeight = FontWeight.bold;
          break;
        case 'i':
        case 'em':
          fontStyle = FontStyle.italic;
          break;
        case 'u':
          textDecoration = TextDecoration.underline;
          break;
      }
    });

    if (style != null) {
      matches = styleTag.allMatches(style);

      for (Match match in matches) {
        param = match[1].trim();
        value = match[2].trim();
        switch (param) {
          case 'color':
            if (colorTag.hasMatch(value)) {
              value = value.replaceAll('#', '').trim();
              htmlTextStyle.color = new Color(int.parse('0xFF' + value));
            }
            break;
          case 'font-weight':
            fontWeight =
                (value == 'bold') ? FontWeight.bold : FontWeight.normal;
            break;
          case 'font-style':
            fontStyle =
                (value == 'italic') ? FontStyle.italic : FontStyle.normal;
            break;
          case 'text-decoration':
            textDecoration = (value == 'underline')
                ? TextDecoration.underline
                : TextDecoration.none;
            break;
          case 'text-align':
            if (value.endsWith('center')) {
              textAlign = TextAlign.center;
            } else if (value.endsWith('right')) {
              textAlign = TextAlign.right;
            } else {
              textAlign = TextAlign.left;
            }
            break;
        }
      }
    }
    return TextStyle(
      color: htmlTextStyle.color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: textDecoration,
      fontSize: htmlTextStyle.fontSize,
      height: htmlTextStyle.height,
    );
  }

  void _appendTag(String tag, Map attrs, bool isAppendStartTag) {
    if (this._tag == null) {
      List<String> tags = [tag];
      this._tag = {'label': tags, 'attrs': attrs};
    }
    if (isAppendStartTag) {
      (this._tag['label'] as List<String>).add(tag);
    }
    if (attrs.length > 0) {
      this._tag['attrs'] = attrs;
    }
  }

  void _appendNode(String text) {
    if (this._tag == null) {
      List<String> tags = ['p'];
      this._tag = {'label': tags, 'attrs': {}};
    }
    if (this._stack != null) {
      (this._tag['label'] as List<String>).addAll(this._stack);
    }
    this._tag['text'] = text;
    this._tag['style'] =
        this._parseStyle(this._tag['label'], this._tag['attrs']);
    this._tag['href'] =
        (this._tag['attrs']['href'] != null) ? this._tag['attrs']['href'] : '';

    this._result.add(this._tag);
    this._tag.remove('attrs');
    this._tag = null;
  }

  String _getStackLastItem() {
    if (this._stack.length <= 0) {
      return null;
    }

    return this._stack[this._stack.length - 1];
  }
}
