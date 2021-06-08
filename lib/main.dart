import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const title = "Hybrid Composition Example";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _channel = 'ejemplo.hybrid.composition.webview';
  static const _method = 'nativeWebView';
  static const _methodChannel = const MethodChannel(_channel);

  String finalUrl = 'Hello!';

  Future<void> _launchPlatformWebView() async {
    final String? platformFinalUrl = await _methodChannel.invokeMethod(
      _method,
      'https://www.google.com',
    );
    setState(() {
      finalUrl = platformFinalUrl ?? 'No URL';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _launchPlatformWebView,
              child: Text('Abrir el WebView'),
            ),
            Text(finalUrl),
          ],
        ),
      ),
    );
  }
}
