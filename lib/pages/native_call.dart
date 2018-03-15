import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCallPage extends StatefulWidget {

  static const routeName = '/native-call';

  @override
  State<StatefulWidget> createState() => new NativeCallState();

}

class NativeCallState extends State<NativeCallPage> {

  String _osVersion = 'Detecting your phone\'s operating system ...';

  static const exampleNativeCall = const MethodChannel('sparkle-cherry.io/native-calls-example');

  @override
  void initState() {
    super.initState();
    _getOsVersion();
  }

  Future<Null> _getOsVersion() async {
    var resultFromNativeCall = '';
    try {
      resultFromNativeCall = await exampleNativeCall.invokeMethod('getOsVersion');
    } on PlatformException catch (exception) {
      resultFromNativeCall = '${exception.message}';
    }
    setState(() {
      _osVersion = resultFromNativeCall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Native Call', style: new TextStyle(fontFamily: 'Itim'),),
      ),
      body: new Center(
        child: new Text(_osVersion, style: new TextStyle(fontFamily: 'Delius'),),
      ),
    );
  }

}