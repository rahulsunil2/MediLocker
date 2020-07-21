import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  int _radioValue = 0;
  DateTime _selectedDate;

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

  // Remove image
  void _clear() {
    setState(() => file = null);
  }

  upload() async {
    final uploader = FlutterUploader();

    File newFile = await file;
    Directory pathDir = await getApplicationDocumentsDirectory();
    final String path = pathDir.path;
    String picName = '${CurrentUser.currentUser}_${DateTime.now()}.png';

    if (newFile != null) {
      final File newImage = await newFile.copy('$path/$picName');
      print('yes not null');
      Map<String, String> data = {
        "description": "${Report.description}",
        "type": "${Report.type}",
        "category": "${Report.category}",
        "date": DateFormat('yyyy-M-dd').format(_selectedDate),
        "user": CurrentUser.currentUser
      };
      print(data);
      final taskId = await uploader.enqueue(
          url: Common.baseURL +
              "users/medicalrecord/", //required: url to upload to
          files: [
            FileItem(filename: picName, savedDir: '$path', fieldname: "file")
          ], // required: list of files that you want to upload
          method: UploadMethod.POST, // HTTP method  (POST or PUT or PATCH)
          headers: {"Content-Type": "multipart/form-data"},
          data: data, // any data you want to send in upload request
          showNotification:
              true, // send local notification (android only) for upload status
          tag: Report.category); // unique tag for upload task
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          return Container(
            child: Column(
              children: <Widget>[
                uploadOp(context),
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: _clear,
                  ),
                ),
                Container(
                  height: 350,
                  width: 250,
                  child: Image.file(
                    snapshot.data,
                    //fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  'No Record Selected',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 30),
                Container(
                    height: 350,
                    child: Image.asset(
                      'images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            ),
          );
        }
      },
    );
  }

  Map<int, String> data = {0: 'Report', 1: 'Prescription', 2: "X-Ray/MRI"};

  void _presentDatePicker(StateSetter setState) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
          print(DateFormat.yMMMd().format(_selectedDate));
        });
      }
    });
  }

  int _selectedCat = 0;
  Map<int, String> category = {
    0: 'Diabetes',
    1: 'Thyroid',
    2: 'X-Ray/ \nMRI',
    3: 'Heart \nDisease',
    4: 'Urinary\n Disease',
    5: 'Others'
  };

  List<Widget> selectCategory(StateSetter setState) {
    List<Widget> list = List<Widget>();

    for (int i = 0; i < 6; i++) {
      list.add(Padding(
          padding: EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              Radio(
                  value: i,
                  groupValue: _selectedCat,
                  onChanged: (value) {
                    setState(() {
                      _selectedCat = value;
                      Report.category = category[i];
                      print(Report.category);
                    });
                  }),
              Text(category[i]),
            ],
          )));
    }

    return list;
  }

  void addReport(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
          return GestureDetector(
            onTap: () {},
            child: Card(
                elevation: 10,
                child: Container(
                    child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      'Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              state(() {
                                _radioValue = value;
                                Report.type = data[value];
                                print(Report.type);
                              });
                            }),
                        Text('Report'),
                        Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              state(() {
                                _radioValue = value;
                                Report.type = data[value];
                                print(Report.type);
                              });
                            }),
                        Text('Prescription'),
                      ],
                    ),
                    Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                        child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 0.0),
                            children: selectCategory(state))),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Record Description",
                      ),
                      controller: recNameController,
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(_selectedDate == null
                                  ? 'No Date Chosen'
                                  : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}')),
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () => _presentDatePicker(state),
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                        child: Text('Add '),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).textTheme.button.color,
                        onPressed: () => _onAlertButtonsPressed(context))
                  ],
                ))),
            behavior: HitTestBehavior.opaque,
          );
        });
      },
    );
  }

  String dropdownValue = 'Click Me';
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[showImage()],
        ),

        // padding: const EdgeInsets.all(20.0),
        // color: Colors.lightBlue[50],
        // child: new SingleChildScrollView(
        //   child: new ConstrainedBox(
        //     constraints: new BoxConstraints(),
        //     child: new Container(
        //       child: new Center(
        //         child: new Column(
        //           children: [
        //             new Padding(padding: EdgeInsets.only(top: 20.0)),
        //             new Text(
        //               'FORM',
        //               style: new TextStyle(
        //                   color: Colors.blue,
        //                   fontSize: 50.0,
        //                   fontFamily: 'Poppins'),
        //             ),
        //             new Padding(padding: EdgeInsets.only(top: 50.0)),
        //             Container(
        //               height: 55,
        //               width: MediaQuery.of(context).size.width / 1.5,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.blue, width: 2),
        //                 borderRadius: BorderRadius.circular(30.0),
        //               ),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                 children: [
        //                   DropDownButtonBlg(),
        //                 ],
        //               ),
        //             ),
        //             new Padding(padding: EdgeInsets.only(top: 20.0)),
        //             new TextFormField(
        //               decoration: new InputDecoration(
        //                 labelText: "Record Name",
        //                 fillColor: Colors.white,
        //                 border: new OutlineInputBorder(
        //                   borderRadius: new BorderRadius.circular(25.0),
        //                   borderSide: new BorderSide(),
        //                 ),
        //               ),
        //               controller: recNameController,
        //               validator: (val) {
        //                 if (val.length == 0) {
        //                   return "Name can not be empty";
        //                 } else {
        //                   return null;
        //                 }
        //               },
        //               keyboardType: TextInputType.text,
        //               style: new TextStyle(
        //                 fontFamily: "Poppins",
        //               ),
        //             ),
        //             new Padding(padding: EdgeInsets.only(top: 20.0)),
        //             selectLoc(context),
        //             new Padding(padding: EdgeInsets.only(top: 20.0)),
        //             showImage(),
        //             new Padding(padding: EdgeInsets.only(top: 20.0)),
        //             uploadOp(context),
        //             Row( mainAxisAlignment: MainAxisAlignment.end,
        //               children: <Widget>[
        //               FlatButton(
        //                 child: Icon(Icons.refresh),
        //                 onPressed: _clear,
        //               ),
        //             ]),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt), onPressed: () => addReport(context)),
    );
  }

  _onAlertButtonsPressed(context) {
    Report.description = recNameController.text;
    print("description ${Report.description}");
    if (Report.category == null ||
        Report.type == null ||
        Report.description == null ||
        _selectedDate == null) {
      SnackBar(
          content: Text(
            'Fill all details',
          ),
          backgroundColor: Colors.red);
      return;
    }
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

  // Widget selectLoc(BuildContext context) {
  //   return Container(
  //     //margin: EdgeInsets.only(top: screenHeight / 1 + 10),
  //     padding: EdgeInsets.only(left: 15, right: 15),
  //     child: Align(
  //         alignment: Alignment.center,
  //         child: RaisedButton(
  //           child: Text(
  //             ' Select Report',
  //             style: TextStyle(fontSize: 16.0, fontFamily: 'Monsteratt'),
  //           ),
  //           color: Colors.indigo,
  //           onPressed: () => _onAlertButtonsPressed(context),
  //         )),
  //   );
  // }

  Widget uploadOp(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: RaisedButton(
          color: Colors.blue,
          elevation: 10,
          onPressed: () {
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

// class DropDownButtonBlg extends StatefulWidget {
//   DropDownButtonBlg({Key key}) : super(key: key);

//   @override
//   _DropDownButtonBlgState createState() => _DropDownButtonBlgState();
// }

// class _DropDownButtonBlgState extends State<DropDownButtonBlg> {
//   String dropdownValue = 'Report';

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       //hint: Text("CLICK ME"),
//       value: dropdownValue,
//       icon: Icon(Icons.arrow_drop_down),
//       iconSize: 30,
//       elevation: 20,
//       onChanged: (String newValue) {
//         setState(() {
//           dropdownValue = newValue;
//           Report.type = dropdownValue;
//         });
//       },

//       items: <String>['Report', 'Prescription', 'X-Ray/MRI']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value, style: TextStyle(fontSize: 30, color: Colors.blue)),
//         );
//       }).toList(),
//     );
//   }
// }
