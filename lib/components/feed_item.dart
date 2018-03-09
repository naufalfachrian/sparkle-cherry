import 'package:flutter/material.dart';
import 'package:sparkle_cherry/style.dart';

class FeedItem extends StatelessWidget {

  final String uuid;

  final String name;

  final String photoProfile;

  final String content;

  final String contentImage;

  final String location;

  final int commentCount;

  final String createdAt;

  FeedItem({
    this.uuid,
    this.name,
    this.photoProfile,
    this.content,
    this.contentImage,
    this.location,
    this.commentCount,
    this.createdAt});

  @override
  Widget build(BuildContext context) {
    return new Padding(padding: new EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
      child: new Card(
        child: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(name, style: new TextStyle(fontFamily: 'Delius', fontWeight: FontWeight.bold)),
              subtitle: new Text(createdAt, style: new DeliusTextStyle(),),
              leading: new CircleAvatar(
                backgroundImage: new NetworkImage(photoProfile),
              ),
            ),
            new Padding(padding: new EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
              child: new Text(content, style: new DeliusTextStyle(),),),
            new Padding(padding: new EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 18.0),
              child: new FadeInImage(
                  placeholder: new AssetImage('assets/images/placeholder_image.png'),
                  image: new NetworkImage(contentImage))),
            new Container(
              height: 1.0,
              decoration: new BoxDecoration(
                  color: new Color.fromARGB(255, 224, 224, 224)
              ),
            ),
            new ButtonTheme.bar(
              child: new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    onPressed: () {},
                    child: new Text(commentCount.toString() + ' comments',
                      style: new DeliusTextStyle(),
                    )
                  ),
                  new FlatButton(
                      onPressed: () {},
                      child: new Text('Share',
                        style: new DeliusTextStyle(),
                      )
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

}