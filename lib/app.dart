import 'package:flutter/material.dart';
import 'home.dart';
import 'package:sparkle_cherry/components/gallery_item.dart';

class SparkleCherryApp extends StatelessWidget {

  final String title = 'Sparkle Cherry';

  @override
  Widget build(BuildContext context) {

    final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{};
    for (GalleryItem item in galleryItems) {
      routes[item.routeName] = (BuildContext context) {
        return item.buildRoute(context);
      };
    }

    return new MaterialApp(
      title: title,
      theme: new ThemeData(
        primarySwatch: Colors.red,
        platform: TargetPlatform.iOS,
      ),
      home: new HomeScreen(title),
      routes: routes,
    );
  }

}
