import 'package:flutter/material.dart';

class HowManyWidgets extends StatelessWidget {

  static const routeName = '/how-many-widgets';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('How Many Widgets?', style: new TextStyle(fontFamily: 'Itim'),),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {},
          child: new Text('Am I really a button?',
            style: new TextStyle(fontFamily: 'Delius', color: Colors.white),
          ),
          color: Colors.purpleAccent,
        ),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: () {},
        child: new Icon(Icons.local_florist,),
      ),
    );
  }

}