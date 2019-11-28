//Flutter widgets
import 'package:campus_nav/controller/Controller.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class MyMap extends StatelessWidget {
  final String title = 'Campus NAV';
  final String selectedUrl;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

 MyMap({ @required this.selectedUrl, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( title: Text(title), ),
        body: WebView(
          initialUrl: 'https://www.google.pt/maps/@41.178191,-8.5957875,18.43z',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
        drawer: Controller.instance().getSideMenu()

    );
  }
}
