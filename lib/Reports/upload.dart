import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_report/Reports/selected.dart';
import 'package:med_report/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddReport extends StatefulWidget {
  @override
  _AddReportState createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  double screenHeight;
  final recNameController = TextEditingController();
  Future<File> file;
  //File file;
  String status = '';
  String errMessage = 'Error Uploading Image';

  _chooseImage(ImageSource source) {
    setState(() {
      file = ImagePicker.pickImage(source: source);
    });
    setStatus('');
  }
  // Future _chooseImage(ImageSource source) async{
    
  //     var f = await ImagePicker.pickImage(source: source);
  //   setState(() {
  //       file = f;
  //     });
    
  //   setStatus('');
  // }

  setStatus(String message) {
    setState(() {
      status = message;
      print(status);
    });
  }

  // Remove image
  void _clear() {
    setState(() => file = null);
  }

  // startUpload() {
  //   setStatus('Uploading Image...');
  //   if (null == file) {
  //     setStatus('null tmpFile');
  //     return;
  //   }
    
  //   upload();
  // }

  upload() async {
    final uploader = FlutterUploader();

    File newFile = await file;
    Directory pathDir = await getApplicationDocumentsDirectory();
    final String path = pathDir.path;
    String picName = '${Common.currentUser}_${DateTime.now()}.png';

    if (newFile != null) {
      final File newImage = await newFile.copy('$path/$picName');

      final taskId = await uploader.enqueue(
          url:
              "http://134.209.158.239:8000/users/medicalrecord/", //required: url to upload to
          files: [
            FileItem(filename: picName, savedDir: '$path', fieldname: "file")
          ], // required: list of files that you want to upload
          method: UploadMethod.POST, // HTTP method  (POST or PUT or PATCH)
          headers: {"Content-Type": "multipart/form-data"},
          data: {
            "description": Report.type + ":" + recNameController.text,
            "user": Common.currentUser
          }, // any data you want to send in upload request
          showNotification:
              true, // send local notification (android only) for upload status
          tag: recNameController.text); // unique tag for upload task
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 10,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    ' ALL',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    ' GRAPH',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    ' ADD',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
          //title: Text('Persistent Tab Demo'),
        ),
        body: TabBarView(
          children: [
            filter(context),

            Center(child: Text("Page 2")),
            //selectLoc(context),
            form(context),
          ],
        ),
      ),
    );
  }

  Widget filter(BuildContext context) {
    return Container(
        //margin: EdgeInsets.only(top: screenHeight / 1 ),
        padding: EdgeInsets.only(top: 100.0),
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text("Categories ",
                style: TextStyle(
                  fontFamily: 'Poppins' ,
                  fontSize: 30,
                  color: Colors.indigoAccent,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: <Widget>[
                  Menu(title: " Diabetes ", action: 1),
                  Menu(title: "Thyroid", action: 2),
                  Menu(title: "X-Ray/ \nMRI", action: 3),
                  Menu(title: "   Heart  \n Disease", action: 4),
                  Menu(title: " Urinary  \ndisorders", action: 5),
                  Menu(title: "Others ", action: 6),
                ]),
          ),
        ]));
  }


  String dropdownValue = 'Click Me';
  Widget form(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.lightBlue[50],
      child: new SingleChildScrollView(
        child: new ConstrainedBox(
          constraints: new BoxConstraints(),
          child: new Container(
            child: new Center(
              child: new Column(
                children: [
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  new Text(
                    'FORM',
                    style: new TextStyle(
                        color: Colors.blue,
                        fontSize: 50.0,
                        fontFamily: 'Poppins'),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 50.0)),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropDownButtonBlg(),
                      ],
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Record Name",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    controller: recNameController,
                    validator: (val) {
                      if (val.length == 0) {
                        return "Name can not be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  selectLoc(context),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  showImage(),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  uploadOp(context),
                  Row( mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.refresh),
                      onPressed: _clear,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.info,
      //type: AlertType.warning,
      title: "CHOOSE",
      desc: "Select the method",
      buttons: [
        DialogButton(
          child: Text(
            "Take Photo",
            style: TextStyle(
                color: Colors.white, fontSize: 16.0, fontFamily: 'Monsteratt'),
          ),
          onPressed: () => _chooseImage(ImageSource.camera),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(52, 138, 199, 1.0),
            Color.fromRGBO(116, 116, 191, 1.0),
          ]),
        ),
        DialogButton(
          child: Text(
            ''' Choose from   
       Gallery ''',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: 'Monsteratt',
            ),
          ),
          onPressed: () => _chooseImage(ImageSource.gallery),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  Widget selectLoc(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: screenHeight / 1 + 10),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Align(
          alignment: Alignment.center,
          child: RaisedButton(
            child: Text(
              ' Select Report',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Monsteratt'),
            ),
            color: Colors.indigo,
            onPressed: () => _onAlertButtonsPressed(context),
          )),
    );
  }

  Widget uploadOp(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: RaisedButton(
          onPressed: (){
            setStatus('Uploading Image...');
    if (null == file) {
      setStatus('null tmpFile');
      return;
    }
    
    upload();
          },
          //startUpload(),
          child: Text(
            ' Upload ',
            style: TextStyle(fontSize: 16.0, fontFamily: 'Monsteratt'),
          ),
        ));
  }
}

class Menu extends StatelessWidget {
  Menu({this.title, this.action});
  final String title;
  final int action;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6.0,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.blueAccent, width: 4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: RaisedButton(
          color: Colors.blueAccent,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.0),
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Monsteratt',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ]),
          onPressed: () {
            /*if(action == 3){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => AddReport()));
            }*/
          },
        ));
  }
}

class DropDownButtonBlg extends StatefulWidget {
  DropDownButtonBlg({Key key}) : super(key: key);

  @override
  _DropDownButtonBlgState createState() => _DropDownButtonBlgState();
}

class _DropDownButtonBlgState extends State<DropDownButtonBlg> {
  String dropdownValue = 'Report';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      //hint: Text("CLICK ME"),
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 30,
      elevation: 20,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          Report.type = dropdownValue;
        });
      },

      items: <String>['Report', 'Prescription', 'X-Ray/MRI']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 30, color: Colors.blue)),
        );
      }).toList(),
    );
  }
}