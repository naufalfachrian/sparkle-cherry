import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class StopwatchPage extends StatefulWidget {

  static const String routeName = '/stopwatch';

  @override
  State<StatefulWidget> createState() => new StopwatchPageState();

}

class StopwatchPageState extends State<StopwatchPage> {

  double timeCount = 0.0;

  bool _stopwatchHasStarted = false;

  Timer timer;
  
  List<double> items = new List<double>();

  void startStopwatch() {
    setState(() {
      _stopwatchHasStarted = true;
    });
    timer = new Timer.periodic(new Duration(milliseconds: 10), (Timer timer) {
      setState(() {
        timeCount += 0.01;
      });
    });
  }

  void trackStopwatch() {
    setState(() {
      items.add(timeCount);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Stopwatch', style: new TextStyle(fontFamily: 'Itim',)),
      ),
      body:
        new Row(
          children: <Widget>[
            new Expanded(child: new Container(
              decoration: new BoxDecoration(color: new Color.fromARGB(255, 255, 235, 238)),
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return new ListTile(
                    title: new Text(_parseSecond(items[items.length - index - 1]),
                      style: new TextStyle(fontFamily: 'Itim', fontSize: 20.0),),
                    subtitle: new Text('#' + (items.length - index).toString(),
                      style: new TextStyle(fontFamily: 'Itim'),),
                  );
                },
                itemCount: items.length,),
            )),
            new Expanded(child: new Column(
              children: <Widget>[
                new Expanded(child: new Center(
                  child: new Text(_parseSecond(timeCount),
                    style: new TextStyle(fontFamily: 'Itim', fontSize: 32.0),),
                )),
              ],
            )),
          ],
        ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _stopwatchHasStarted ? trackStopwatch: startStopwatch,
        child: new Icon(_stopwatchHasStarted ? Icons.playlist_add : Icons.play_arrow),
      ),
    );
  }

  String _parseSecond(double seconds) {
    var formatter = new NumberFormat('00', 'en_US');
    var mins = formatter.format(seconds / 60);
    var secs = formatter.format(seconds % 60);
    var mils = formatter.format((seconds - seconds.toInt()) * 100);
    return mins + '\' ' + secs + '\" ' + mils;
  }

}