import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimpleHttpClientPage extends StatefulWidget {

  static const String routeName = '/simple-http-client-1';

  @override
  State<StatefulWidget> createState() => new SimpleHttpClientPageState();

}

class SimpleHttpClientPageState extends State<SimpleHttpClientPage> {

  String _origin;

  http.Client _client;

  @override
  void initState() {
    super.initState();
    _origin = 'Please wait ...';
    _client = new http.Client();
    _client.get('https://httpbin.org/get')
      .then((http.Response response) {
        var jsonResponse = JSON.decode(response.body);
        setState(() {
          _origin = jsonResponse['origin'];
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _client.close();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('IP Address', style: new TextStyle(fontFamily: 'Itim'),),
      ),
      body: new Center(
        child: new Text(_origin, style: new TextStyle(fontSize: 24.0, fontFamily: 'Delius'),),
      ),
    );
  }

}