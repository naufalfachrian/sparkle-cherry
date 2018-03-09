import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart' as dom;
import 'package:sparkle_cherry/style.dart';

class HtmlParserPage extends StatefulWidget {

  static const String routeName = '/html-parser';

  @override
  State<StatefulWidget> createState() => new HtmlParserPageState();

}

class HtmlParserPageState extends State<HtmlParserPage> {

  final String url = 'https://news.detik.com/';

  http.Client client;

  List<dom.Element> elements = new List();

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    client = new http.Client();
    new Timer(new Duration(milliseconds: 1500), ()
    async {
      await client.get(url).then((http.Response response) {
        return htmlParser.parse(response.body);
      }).then((htmlDocument) {
        return htmlDocument
            .getElementsByClassName('menu')
            .first
            .getElementsByTagName('a');
      }).then((elements) {
        elements.forEach((item) {
          if (item.text.isNotEmpty) {
            setState(() {
              this.elements.add(item);
            });
          }
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Html Parser', style: new TextStyle(fontFamily: 'Itim'),),),
      body: body()
    );
  }

  Widget body() {
    if (elements.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new ListView.builder(itemBuilder: (buildContext, index) {
        return new ListTile(
          title: new Text(elements[index].text, style: new DeliusTextStyle(),),
          subtitle: new Text('#' + (index + 1).toString(), style: new DeliusTextStyle(),),
          onTap: () {},
        );
      }, itemCount: elements.length,);
    }
  }

}
