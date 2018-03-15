import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeQrScannerPage extends StatefulWidget {

  static const String routeName = '/qr-scanner';

  @override
  State<StatefulWidget> createState() => new NativeQrScannerState();

}

class NativeQrScannerState extends State<NativeQrScannerPage> {

  String _data = 'Tap floating action button to start QR Scanner.';

  static const nativeCall = const MethodChannel('sparkle-cherry.io/native-calls-example');

  Future<Null> _qrScanner() async {
    var resultFromNativeCall = '';
    try {
      resultFromNativeCall = await nativeCall.invokeMethod('scanQrViaNative');
    } on PlatformException catch (exception) {
      resultFromNativeCall = '${exception.message}';
    }
    setState(() {
      _data = resultFromNativeCall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Qr Scanner',
          style: new TextStyle(fontFamily: 'Itim'),
        ),
      ),
      body: new Center(
        child: new Text(_data,
          style: new TextStyle(fontFamily: 'Delius'),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _qrScanner();
        },
        child: new Icon(Icons.camera_alt),
      ),
    );
  }

}