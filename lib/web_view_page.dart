import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'on_tap_data.dart';

class WebViewVideo extends StatelessWidget {
  final String url;
  final Function onTapCallback;

  WebViewVideo(this.url, {this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
        height: MediaQuery.of(context).size.width * 9 / 16,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            GestureDetector(
              onTap: () {
                onTapCallback(OnTapData(url, type: OnTapType.video));
              },
              child: Container(
                color: Color(0x00FFFFFF),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: GestureDetector(
                onTap: () {
                  if (onTapCallback != null) {
                    onTapCallback(OnTapData(url, type: OnTapType.video));
                  }
                },
                child: Image.asset("assets/images/fullscreen_enter.png"),
              ),
            ),
          ],
        ));
  }
}
