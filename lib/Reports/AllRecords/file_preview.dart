import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
// import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:med_report/Reports/AllRecords/zoomFile.dart';
import 'package:med_report/global.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileDetails extends StatefulWidget {
  final String filename;
  final String data;
  FileDetails(this.filename, this.data);
  @override
  _FileDetailsState createState() => _FileDetailsState(file: this.filename);
}

class _FileDetailsState extends State<FileDetails> {
  String file;
  _FileDetailsState({this.file});
  var filePath;

  // String BASE64_IMAGE;

  // void _onImagDownloadButtonPressed() async {
  //   var response = await http.get(Common.baseURL + 'media/' + file);
  //   filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
  // }

  Future<void> _onImageShareButtonPressed() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/download_demo.png';
    final File f = File(path);
    Dio dio = Dio();
    await dio.download(
      Common.baseURL + 'media/' + file,
      '$dir/download_demo.png',
    );
    await FlutterShare.share(
        title: 'MedicalRecord',
        text: file,
        linkUrl: path,
        chooserTitle: 'Share via');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Record Details'),
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            option(),
            img(),
            Padding(
              padding: EdgeInsets.only(top: 250, left: 80, right: 80),
              child: info(),
            )
          ]),
        ));
  }

  Widget img() {
    print(widget.filename);
    String url = Common.baseURL + 'media/' + widget.filename;
    print(url);
    return Stack(
      children: <Widget>[
        Container(
          height: 450,
          width: 600,
          alignment: Alignment.center,
          //margin: EdgeInsets.symmetric(horizontal: 20),
          child: Image.network(url,),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                icon: Icon(Icons.zoom_in,size: 30,),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Zoom(url)))))
      ],
    );
  }

  Widget option() {
    return Padding(
      padding: EdgeInsets.only(left:115,right:115,top: 540),
      child: Row(
        children: [
          MaterialButton(
            onPressed: () {
              _onImageShareButtonPressed();
            },
            //     async =>
            //     await _onImageShareButtonPressed(),
            color: Colors.blue,
            textColor: Colors.white,
            child: Icon(
              Icons.share,
              size: 17,
            ),
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          ),
          MaterialButton(
            onPressed: () {
              //_onImagDownloadButtonPressed();
            },
            color: Colors.blue,
            textColor: Colors.white,
            child: Icon(
              Icons.file_download,
              size: 17,
            ),
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          ),
        ],
      ),
    );
  }

  Widget info() {
   // final doubleRegex = RegExp(r'\s+(\d+\.\d+)\s+', multiLine: true);
    //final dat=doubleRegex.allMatches(widget.data).map((m) => m.group(0));

    return Padding(
      padding: const EdgeInsets.only(top:180.0),
      child: Column(
        children: [
          Text(
            'Your Health data',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),

          Container(
            //color: Colors.redAccent,
           // padding: EdgeInsets.only(top: 20),
            height: 70,
            width: 400,
            decoration: BoxDecoration(
               // border: double.parse(widget.data) > 99.0? Border.all(color: Colors.red,width: 4,):Border.all(color: Colors.red,width: 4,),
              border:Border.all(color: Colors.red,width: 4,),
               borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  widget.data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(width: 3,),
                Text(
                  ' : High',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
