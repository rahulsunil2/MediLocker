import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
//import 'package:firebase_image/firebase_image.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;

  String _textValue = "sample";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.lime,
        buttonColor: Colors.lime,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Select Category and Value'),
        ),
        body: Center(
            child: new ListView(
          children: <Widget>[
            new Text(_textValue),
            new RaisedButton(
              onPressed: _read,
              child: new Text('Start Scanning'),
            ),
          ],
        )),
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        _textValue = texts[0].value;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
}