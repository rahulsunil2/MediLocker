import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Zoom extends StatefulWidget {
  final String url;
  Zoom(this.url);
  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Preview'),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(
          widget.url,
        ),
      ),
    );
  }
}
