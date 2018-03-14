import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sparkle_cherry/components/feed_item.dart';
import 'dart:convert' as convert;

class FeedPage extends StatefulWidget {

  static const routeName = '/sample-feeds';
  
  @override
  State<StatefulWidget> createState() => new FeedPageState();
  
}

class FeedPageState extends State<FeedPage> {

  List<FeedItem> items = new List();

  int _page = 1;

  bool _isFetching = false;
  
  http.Client client;
  
  @override
  void initState() {
    super.initState();
    client = new http.Client();
    fetch();
  }

  Future<Null> refresh() {
    _page = 1;
    _isFetching = false;
    client.close();
    client = new http.Client();
    setState(() {
      items.clear();
    });
    return fetch();
  }

  Future<Null> fetch() {
    final Completer<Null> completer = new Completer<Null>();
    if (_isFetching) {
      completer.complete(null);
    }
    _isFetching = true;
    new Timer(new Duration(milliseconds: 1500), () async {
      await client.get('http://sparklecherry.esy.es/feeds?page=' + _page.toString(), headers: {
        'x-limerence-key' : 'sugar-knife-59ef758f-993f-481a-b7ff-abb5ae04af91',
      }).then((response) {
        return convert.JSON.decode(response.body);
      }).then((jsonObject) {
        return jsonObject['object']['data'];
      }).then((items) {
        for(var item in items) {
          setState(() {
            this.items.add(new FeedItem(
              uuid: item['uuid'],
              name: item['created_by_name'],
              photoProfile: item['created_by_photo_profile'],
              content: item['feed_content'],
              contentImage: item['feed_image'],
              createdAt: item['created_at_description'],
              location: item['feed_location'],
              commentCount: item['feed_comment_count'],
            ));
          });
        }
      }).then((_) {
        _isFetching = false;
        completer.complete(null);
      });
    });
    return completer.future;
  }

  @override
  void dispose() {
    super.dispose();
    if (client != null) {
      client.close();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Feed', style: new TextStyle(fontFamily: 'Itim'),),),
      body: new Container(
        decoration: new BoxDecoration(color: new Color.fromARGB(255, 224, 224, 224)),
        child: new RefreshIndicator(
          child: new ListView.builder(itemBuilder: (buildContext, index) {
            if (index == items.length) {
              return new Padding(padding: new EdgeInsets.all(24.0),
                child: new Center(
                  child: new CircularProgressIndicator(),
                ));
            }
            if (index == items.length - 1) {
              _page = _page + 1;
              fetch();
            }
            return items[index];
          }, itemCount: items.length + 1,),
          onRefresh: refresh
        ),
      ),
    );
  }
  
}