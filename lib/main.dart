import 'package:flutter/material.dart';
import 'package:flutter_app/htmlText/flutter_html_textview.dart';
import 'package:oktoast/src/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Colors.grey..withAlpha(200),
      radius: 8.0,
      child: MaterialApp(
        home: SingleChildScrollViewTestRoute(),
      ),
    );
  }
}

// ignore: must_be_immutable
class SingleChildScrollViewTestRoute extends StatelessWidget {
  String html =
      '<p><strong>维生素A报价继续向上 月涨幅超20%</strong></p><p>今日，市场消息称DSM瑞士工厂因废水处理的菌种被污染而停产2-3月，国内维生素A产品停报停签。目前，国内维生素A报价继续向上，报价提至370-400元/千克，月涨幅22.58%。</p><p>机构分析，近期VA厂家以停报为主，供应没有完全恢复，交货延缓；贸易商货源有限，惜售或停报观望；实际成交量有待观察。短期来看，5月维生素A价格大概率维持强势。维生素A行业格局良好，前几年无新增产能，目前各家企业维持合理毛利润为主，量紧价高。</p><p>A股上市公司中，<strong><a href="https://www.moer.cn/stockInfo/sz002001.htm" target="_blank">新和成</a>（<a href="https://www.moer.cn/stockInfo/sz002001.htm" target="_blank">002001</a>）</strong>目前公司维生素A粉产能10000吨。<strong><a href="https://www.moer.cn/stockInfo/sh600216.htm" target="_blank">浙江医药</a>（<a href="https://www.moer.cn/stockInfo/sh600216.htm" target="_blank">600216</a>）</strong>目前公司维生素A粉产能5000吨。</p>';
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String htmlUl =
      '<ul class=" list-paddingleft-2" style="list-style-type: disc;"><li><p>box constraints有人也翻译</p></li><li><p>为盒约束、箱约束</p></li><li><p>，我个人还是觉得边界约束可能更直观一些。</p></li></ul>';
  String centerUrl =
      '<p style="text-align: center;">这样做的好处，了统一的渲染。加入样式，会让布局复杂不少，在渲染层面会降低很多性能。因此，Flutter在大的方向上，加入不同类型的布局widget。在小的方向上，只给出很少的定制化的东西，将布局限定在有限的范围内，在完成布局的同时，让整个渲染能够统一，加快了更新和渲染居中结束</p><p style="text-align: right;">但是，缺点也是同样明显，少了很多灵活性，不同的布局方式都被抽离出了widget，大家需要了解的widget非常多，增加了学习成本。</p><p>1.2 约束种类</p>';
  String colorUrl =
      '<em><strong>布局空间。Flutter借鉴了很多React</strong></em></span>相关的东西，<span style="color: #92cf4f;">包括一些布局思想</span>';
  String htmlOl =
      '<p>Flutter中的边界约束，是指</p><ol class=" list-paddingleft-2" style="list-style-type: decimal;"><li><p>widget可以按照指定限定</p></li><li><p>条件，来决定自身如何</p></li></ol><p>占用<span style="text-decoration: underline; color: #e8451a;"><em><strong>布局空间。Flutter借鉴了很多React</strong></em></span>相关的东西，<span style="color: #92cf4f;">包括一些布局思想</span>';
  String moreHtml =
      '<span style="text-decoration: underline; color: #e8451a;"><em><strong>布局空间。Flutter借鉴了很多React</strong></em></span>';
  String emStrong =
      '<p>这样<span style="text-decoration: underline;">做<span style="text-decoration: underline; color: #e8451a;">的</span><strong>好处，</strong></span><span style="text-decoration: none;"><strong><span style="text-decoration: none; color: #92cf4f;">我<em>觉</em></span></strong></span><span style="text-decoration: underline;"><strong><em>得</em><em><a href="https://www.imooc.com/article/details/id/31493" title="可能是为了" target="_blank">可能是为了</a>了统一的渲染</em></strong><strong>。加入</strong>样</span>式，会</p>';
  String emStrong1 = '<p>这样做的<strong>好处，我<em>觉得了统一的渲染</em>加粗</strong>正常</p>';
  String imageHtml =
      '<p>只给出很少的定制化的东西，将布局限</p><p>定在有限的<em><strong>让布局复杂不少</strong></em>范围内<img src="https://static.moer.cn/O/2019050777599ec7c9a0f1ac7ebabb4df81377d0.jpeg?mark=1" title="2019050777599ec7c9a0f1ac7ebabb4df81377d0.jpeg" alt=""/>中间的文字<img src="https://static.moer.cn/O/20190507cf596fa2ce5d10d685e9ee5d0e81fd87.jpeg?mark=1" title="20190507cf596fa2ce5d10d685e9ee5d0e81fd87.jpeg" alt=""/>，在完成布局的同时，</p><p><img src="https://static.moer.cn/O/201905077b35e691b0332bba01bf1d1af85ee107.jpeg?mark=1" title="201905077b35e691b0332bba01bf1d1af85ee107.jpeg" alt=""/></p><p>让整个渲染能够统一，</p>';
  String videoHtml =
      '<p>加入视频开始</p><p><iframe frameborder="0" class="edui-faked-video" width="100%" height="498" src="https://player.youku.com/embed/XNDAyMjgxMDI2NA==" allowfullscreen=""></iframe></p><p>视频结束</p>';
  String blockQuote =
      '<p>引用开始</p><blockquote><p>比特币（Bitcoin）的概念最初由中本聪在2008年11月1日提出，并于2009年1月3日正式诞生&nbsp;[1]&nbsp;&nbsp;。根据中本聪的思路设计发布的开源软件以及建构其上的P2P网络。比特币是一种P2P形式的虚拟的加密数字货币。点对点的传输意味着一个去中心化的支付系统。</p><p>与所有的货币不同，比特币不依靠特定货币机构发行，它依据特定算法，通过大量的计算产生，比特币经济使用整个P2P网络中众多节点构成的分布以确保无法通过大量制造比特币来人为操控币值。基于密码学的设计可以使比特币只能被真实的拥有者转移或支付。这同样确保了货币所有权与流通交易的匿名性。比特币与其他虚拟货币最大的不同，是其总数量非常</p><p>2017年12月17日，比特币达到历史最高价19850美元。</p></blockquote><p>引用结束</p><p><br/></p>';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('sdfsdf'),
              Text('sdfsdf'),
              Text('sdfsdf'),
              Text('sdfsdf'),
              Container(
                child: new HtmlTextView(
                  html,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  htmlUl,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  centerUrl,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  colorUrl,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  htmlOl,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  moreHtml,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  emStrong,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  emStrong1,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  imageHtml,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  videoHtml,
                ),
              ),
              Container(
                child: HtmlTextView(blockQuote),
              ),
              VerticalDivider(
                color: Colors.tealAccent[600],
              ),
              Divider(
                color: Colors.tealAccent,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
