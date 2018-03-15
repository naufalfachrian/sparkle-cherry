import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sparkle_cherry/pages/official_example.dart';
import 'package:sparkle_cherry/pages/ip_address.dart';
import 'package:sparkle_cherry/pages/stopwatch.dart';
import 'package:sparkle_cherry/style.dart';
import 'package:sparkle_cherry/pages/html_parser.dart';
import 'package:sparkle_cherry/pages/feed.dart';
import 'package:sparkle_cherry/pages/how_many_widgets.dart';
import 'package:sparkle_cherry/pages/image_picker.dart';
import 'package:sparkle_cherry/pages/location.dart';
import 'package:sparkle_cherry/pages/native_call.dart';
import 'package:sparkle_cherry/pages/native_qr_scanner.dart';

class GalleryItem extends StatelessWidget {

  final String title;

  final String description;

  final String routeName;

  final WidgetBuilder buildRoute;

  final IconData iconData;

  const GalleryItem({
    this.title,
    this.description,
    this.routeName,
    this.buildRoute,
    this.iconData});

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(title, style: new TextStyle(fontFamily: 'Delius', fontWeight: FontWeight.bold),),
      subtitle: new Text(description, style: new DeliusTextStyle()),
      onTap: () {
        if (routeName != null) {
          new Timer(new Duration(milliseconds: 250), () {
            Navigator.pushNamed(context, routeName);
          });
        }
      },
      leading: new Icon(iconData),
    );
  }

}

List<GalleryItem> _createGalleryItem() {
  return [
    new GalleryItem(
      title: 'Official Example',
      description: 'Increment number by clicking floating action button.',
      routeName: MyHomePage.routeName,
      buildRoute: (context) => new MyHomePage(title: 'Counter',),
      iconData: Icons.exposure_plus_1,
    ),
    new GalleryItem(
      title: 'Stopwatch',
      description: 'A simple stopwatch.',
      routeName: StopwatchPage.routeName,
      buildRoute: (context) => new StopwatchPage(),
      iconData: Icons.timer,
    ),
    new GalleryItem(
      title: 'IP Address',
      description: 'Display your public IP address. Provided by http://httpbin.org/.',
      routeName: SimpleHttpClientPage.routeName,
      buildRoute: (context) => new SimpleHttpClientPage(),
      iconData: Icons.network_check,
    ),
    new GalleryItem(
      title: 'Html Parser',
      description: 'We will parse detik.com\'s menu.',
      routeName: HtmlParserPage.routeName,
      buildRoute: (BuildContext context) => new HtmlParserPage(),
      iconData: Icons.code,
    ),
    new GalleryItem(
      title: 'Sample Feed',
      description: 'List view and load more example.',
      routeName: FeedPage.routeName,
      buildRoute: (context) => new FeedPage(),
      iconData: Icons.language,
    ),
    new GalleryItem(
      title: 'How Many Widgets?',
      description: 'A simple test about widget hierarchy.',
      routeName: HowManyWidgets.routeName,
      buildRoute: (context) => new HowManyWidgets(),
      iconData: Icons.dashboard,
    ),
    new GalleryItem(
      title: 'Image Picker',
      description: 'A simple image picker.',
      routeName: ImagePickerPage.routeName,
      buildRoute: (context) => new ImagePickerPage(),
      iconData: Icons.add_a_photo,
    ),
    new GalleryItem(
      title: 'Location',
      description: 'We are trying to use GPS to detect your location.',
      routeName: LocationPage.routeName,
      buildRoute: (context) => new LocationPage(),
      iconData: Icons.location_on,
    ),
    new GalleryItem(
      title: 'Native Call',
      description: 'We are trying to call a native function from Flutter app.',
      routeName: NativeCallPage.routeName,
      buildRoute: (context) => new NativeCallPage(),
      iconData: Icons.nature,
    ),
    new GalleryItem(
      title: 'Qr Scanner',
      description: 'A simple QR scanner.',
      routeName: NativeQrScannerPage.routeName,
      buildRoute: (context) => new NativeQrScannerPage(),
      iconData: Icons.crop_free,
    )
  ];
}

final List<GalleryItem> galleryItems = _createGalleryItem();