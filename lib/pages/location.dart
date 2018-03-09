import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {

  static const String routeName = '/location';

  @override
  State<StatefulWidget> createState() => new LocationPageState();

}

class LocationPageState extends State<LocationPage> {

  var currentLocation = <String, double>{};

  var location = new Location();

  var error;

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  fetchLocation() async {
    Map<String,double> gettingLocation;
    try {
      gettingLocation = await location.getLocation;
    } catch (e) {
      gettingLocation = null;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      currentLocation = gettingLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Location', style: new TextStyle(
          fontFamily: 'Itim'
        ),),
      ),
      body: new Center(
        child: new Text(currentLocation == null
            ? 'Please waite ...'
            : 'lat: ' + currentLocation['latitude'].toString() + '\n'
            + 'lon: ' + currentLocation['longitude'].toString(),
          style: new TextStyle(
            fontFamily: 'Delius'
          ),
        ),
      ),
    );
  }

}