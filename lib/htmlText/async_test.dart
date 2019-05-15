import 'package:flutter/material.dart';

import 'flutter_html_async_textview.dart';

class AsyncTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AsyncTestState();
  }
}

class AsyncTestState extends State {
  String html =
      '<p><strong>维生素A报价继续向上 月涨幅超20%</strong></p><p>今日，市场消息称DSM瑞士工厂因废水处理的菌种被污染而停产2-3月，国内维生素A产品停报停签。目前，国内维生素A报价继续向上，报价提至370-400元/千克，月涨幅22.58%。</p><p>机构分析，近期VA厂家以停报为主，供应没有完全恢复，交货延缓；贸易商货源有限，惜售或停报观望；实际成交量有待观察。短期来看，5月维生素A价格大概率维持强势。维生素A行业格局良好，前几年无新增产能，目前各家企业维持合理毛利润为主，量紧价高。</p><p>A股上市公司中，<strong><a href="https://www.moer.cn/stockInfo/sz002001.htm" target="_blank">新和成</a>（<a href="https://www.moer.cn/stockInfo/sz002001.htm" target="_blank">002001</a>）</strong>目前公司维生素A粉产能10000吨。<strong><a href="https://www.moer.cn/stockInfo/sh600216.htm" target="_blank">浙江医药</a>（<a href="https://www.moer.cn/stockInfo/sh600216.htm" target="_blank">600216</a>）</strong>目前公司维生素A粉产能5000吨。</p>';

  List<Widget> _nodes = [];

  @override
  void initState() {
    super.initState();
    AsyncHtmlTextView(
      html,
    ).build((nodes) {
      setState(() {
        _nodes = nodes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Text(
                '测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试'),
            Expanded(
              child: ListView(
                children: _nodes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
