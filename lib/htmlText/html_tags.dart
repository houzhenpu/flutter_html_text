final List emptyTags = const [
  'area',
  'base',
  'basefont',
  'br',
  'col',
  'frame',
  'hr',
  'img',
  'input',
  'isindex',
  'link',
  'meta',
  'param',
  'embed'
];

final List blockTags = const [
  'address',
  'applet',
  'blockquote',
  'button',
  'center',
  'dd',
  'del',
  'dir',
  'div',
  'dl',
  'dt',
  'fieldset',
  'form',
  'frameset',
  'hr',
  'iframe',
  'ins',
  'isindex',
  'li',
  'map',
  'menu',
  'noframes',
  'noscript',
  'object',
  'ol',
  'p',
  'pre',
  'script',
  'table',
  'tbody',
  'td',
  'tfoot',
  'th',
  'thead',
  'tr',
  'ul'
];
final List inlineTags = const [
  'a',
  'abbr',
  'acronym',
  'applet',
  'b',
  'basefont',
  'bdo',
  'big',
  'br',
  'button',
  'cite',
  'code',
  'del',
  'dfn',
  'em',
  'font',
  'i',
  'iframe',
  'img',
  'input',
  'ins',
  'kbd',
  'label',
  'map',
  'object',
  'q',
  's',
  'samp',
  'script',
  'select',
  'small',
  'span',
  'strike',
  'strong',
  'sub',
  'sup',
  'textarea',
  'tt',
  'u',
  'var'
];
final List closeSelfTags = const [
  'colgroup',
  'dd',
  'dt',
  'li',
  'options',
  'p',
  'td',
  'tfoot',
  'th',
  'thead',
  'tr'
];
final List fillAttrs = const [
  'checked',
  'compact',
  'declare',
  'defer',
  'disabled',
  'ismap',
  'multiple',
  'nohref',
  'noresize',
  'noshade',
  'nowrap',
  'readonly',
  'selected'
];
final List specialTags = const ['script', 'style'];

final String ulTag = '</p></li></ul>';
final String olTag = '</p></li></ol>';

final RegExp startTag = new RegExp(
    r'^<([-A-Za-z0-9_]+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")' +
        "|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>");
final RegExp endTag = new RegExp("^<\/([-A-Za-z0-9_]+)[^>]*>");
final RegExp attrTag = new RegExp(
    r'([-A-Za-z0-9_]+)(?:\s*=\s*(?:(?:"((?:\\.|[^"])*)")' +
        r"|(?:'((?:\\.|[^'])*)')|([^>\s]+)))?");
final RegExp styleTag = new RegExp(r'([a-zA-Z\-]+)\s*:\s*([^;]*)');
final RegExp colorTag = new RegExp(r'^#([a-fA-F0-9]{6})$');
