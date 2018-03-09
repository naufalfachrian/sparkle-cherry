import 'package:flutter/material.dart';
import 'package:sparkle_cherry/components/gallery_item.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen(this.title);

  final String title;

  List<Widget> _galleryListItems() {
    final List<Widget> listItems = <Widget>[];
    for (GalleryItem item in galleryItems) {
      listItems.add(item);
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title, style: new TextStyle(fontFamily: 'Itim'),),
      ),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverList(delegate: new SliverChildListDelegate(_galleryListItems()))
        ],
      )
    );
  }

}