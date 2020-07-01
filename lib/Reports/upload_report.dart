import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_report/login/name.dart';
import 'package:path_provider/path_provider.dart';

class AddReport extends StatefulWidget {
  @override
  _AddReportState createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  double screenHeight;

  static final String uploadEndPoint =
      'http://127.0.0.1:8000/users/medicalrecord/';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  _chooseImage(ImageSource source) {
    setState(() {
      file = ImagePicker.pickImage(source: source);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
      print(status);
    });
  }

  // Future<String> uploadImage(filename, url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(await http.MultipartFile.fromPath('picture', filename));
  //   var res = await request.send();
  //   return res.reasonPhrase;
  // }
  String state = "";

  startUpload() {
    setStatus('Uploading Image...');
    if (null == file) {
      setStatus('null tmpFile');
      return;
    }
    //String fileName = tmpFile.path.split('/').last;
    String fileName = '${Name.currentUser}/${DateTime.now()}.png';
    upload();
  }

  upload() async {
    final uploader = FlutterUploader();

    File newFile = await file;
    Directory pathDir = await getApplicationDocumentsDirectory();
    final String path = pathDir.path;

    if (newFile != null) {
      final File newImage = await newFile.copy('$path/pic.png');

      final taskId = await uploader.enqueue(
          url:
              "http://134.209.158.239:8000/users/medicalrecord/", //required: url to upload to
          files: [
            FileItem(filename: "pic.png", savedDir: '$path', fieldname: "file")
          ], // required: list of files that you want to upload
          method: UploadMethod.POST, // HTTP method  (POST or PUT or PATCH)
          headers: {"Content-Type": "multipart/form-data"},
          data: {
            "description": "file"
          }, // any data you want to send in upload request
          showNotification:
              false, // send local notification (android only) for upload status
          tag: "upload 1"); // unique tag for upload task
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            upperHalf(context),
            general(context),
            options(context),
            selectLoc(context),
            uploadOp(context),
            Padding(
              child: showImage(),
              padding:
                  EdgeInsets.only(top: screenHeight / 2, left: 15, right: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 3,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue[900], Colors.indigo]),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  Widget general(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: screenHeight / 4 - 50),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text(
              ' Hi',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 30,
                  color: Colors.white),
            ),
            Text(
              Name.currentUser,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
          ],
        ));
  }

  Widget options(BuildContext context) {
    return Container(
        height: 40,
        color: Colors.indigo,
        margin: EdgeInsets.only(top: screenHeight / 3),
        //padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  //upload(context);
                },
                child: Text(
                  'ALL       |',
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                )),
            FlatButton(
                onPressed: null,
                child: Text(
                  'GRAPH         |',
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                )),
            FlatButton(
                onPressed: null,
                child: Text(
                  '   ADD',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )),
          ],
        ));
  }

  Widget selectLoc(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 2 + 100),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Align(
          alignment: Alignment.center,
          child: RaisedButton(
            child: Text(
              'Upload Report',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Monsteratt'),
            ),
            color: Colors.indigo,
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Select Record"),
                      content: Column(
                        children: <Widget>[
                          FlatButton(
                              onPressed: () => _chooseImage(ImageSource.camera),
                              child: Text(' Take Photo')),
                          FlatButton(
                              onPressed: () =>
                                  _chooseImage(ImageSource.gallery),
                              child: Text('Choose from Gallery')),
                        ],
                      ),
                      contentPadding: EdgeInsets.all(80.0),
                    );
                  });
            },
          )),
    );
  }

  Widget uploadOp(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(top: screenHeight / 2 - 75, left: 50, right: 50),
        child: OutlineButton(
          onPressed: startUpload(),
          // onPressed: async {
          //   //var file = await ImagePicker.pickImage(source: ImageSource.gallery);
          //   var res = await uploadImage(file.path, widget.url);
          //   setState(() {
          //     state = res;
          //     print(res);
          //   });
          // },
          child: Text(
            'Upload Image',
          ),
        ));
  }
}
