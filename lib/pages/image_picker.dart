import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {

  static const routeName = '/image-picker';

  @override
  State<StatefulWidget> createState() => new ImagePickerPageState();


}

class ImagePickerPageState extends State<ImagePickerPage> {

  File imagefile;

  getImage() async {
    var filename = await ImagePicker.pickImage();
    setState(() {
      imagefile = filename;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Image Picker',
          style: new TextStyle(
            fontFamily: 'Itim'
          )
        ),
      ),
      body: new Center(
        child: imagefile == null
          ? new Text('Please select image first', style: new TextStyle(fontFamily: 'Delius'),)
          : new Image.file(imagefile),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

}