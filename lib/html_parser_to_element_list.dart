import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

class HtmlParserToElementList {
  HtmlParserToElementList();

  Future<List<dom.Element>> asyncParseHtmlToElementList(String html) async {
    return await _getElementListFromHtml(html);
  }

  Future<List<dom.Element>> _getElementListFromHtml(String html) async {
    return _parseHtmlToElementList(html);
  }

  List<dom.Element> _parseHtmlToElementList(String html) {
    return parse(html).body.children;
  }
}
