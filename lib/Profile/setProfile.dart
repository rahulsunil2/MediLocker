import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_report/Home/dashboard.dart';
import 'package:med_report/Profile/save.dart';

import '../global.dart';

class SetProfile extends StatefulWidget {
  @override
  MySetProfile createState() => new MySetProfile();
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String _gender, _bloodGrp;

class MySetProfile extends State<SetProfile> {
  double screenHeight;
  DateTime _selectedDate = DateTime.now();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _addressController = TextEditingController();
  final _allergyController = TextEditingController();

  void _presentDatePicker(StateSetter setState) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
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

  _save(Map<String, String> data) async {
    CurrentUser.firstName =
        data['firstName'].isEmpty ? CurrentUser.firstName : data['firstName'];
    CurrentUser.lastName =
        data['lastName'].isEmpty ? CurrentUser.lastName : data['lastName'];
    CurrentUser.phone =
        data['phone'].isEmpty ? CurrentUser.phone : data['phone'];
    CurrentUser.dob = data['dob'].isEmpty ? CurrentUser.dob : data['dob'];
    CurrentUser.address =
        data['address'].isEmpty ? CurrentUser.address : data['address'];
    CurrentUser.allergy =
        data['allergy'].isEmpty ? CurrentUser.allergy : data['allergy'];
    CurrentUser.gender =
        data['gender'] == null ? CurrentUser.gender : data['gender'];
    CurrentUser.blood_grp =
        data['blood_grp'] == null ? CurrentUser.blood_grp : data['blood_grp'];
    CurrentUser.height =
        data['height'].isEmpty ? CurrentUser.height : data['height'];
    CurrentUser.weight =
        data['weight'].isEmpty ? CurrentUser.weight : data['weight'];

    String url = Common.baseURL + 'users/api_userprofile';

    Map<String, String> profileData = CurrentUser.getProfile();
    await uploadToDb(url, body: profileData);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return Scaffold(
          backgroundColor: Colors.lightBlue[50],
          body: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.lightBlue[50],
              child: new SingleChildScrollView(
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(),
                  child: new Container(
                    child: new Center(
                        child: new Column(children: [
                      new Padding(padding: EdgeInsets.only(top: 50.0)),
                      new Text(
                        'Profile',
                        style: new TextStyle(
                            color: hexToColor("#1A348A"),
                            fontSize: 25.0,
                            fontFamily: 'Poppins'),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 20.0)),
                      new CircleAvatar(
                        backgroundImage: AssetImage('images/user.jpg'),
                        radius: 50,
                      ),
                      new Padding(padding: EdgeInsets.only(top: 20.0)),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: TextFormField(
                              decoration: new InputDecoration(
                                labelText: "First Name",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              controller: _firstNameController,
                              validator: (val) {
                                if (val.length == 0) {
                                  return "First Name can not be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Flexible(
                            child: TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Last Name",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              controller: _lastNameController,
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Last Name can not be empty";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Contact Number",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        controller: _contactController,
                        validator: (val) {
                          if (val.length == 0) {
                            return "Contact number cannot be empty";
                          } else if (val.length != 10) {
                            return "Invalid Contact number";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
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
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black45, width: 1),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  DropDownButtonGender(),
                                ],
                              ),
                            ),
                            new Padding(padding: EdgeInsets.only(left: 10.0)),
                            Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black45, width: 1),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  DropDownButtonBlg(),
                                ],
                              ),
                            ),
                          ]),
                      new Padding(padding: EdgeInsets.only(top: 20.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          new Flexible(
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Height(cm)",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Height cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          new Padding(padding: EdgeInsets.only(left: 10.0)),
                          new Flexible(
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Weight(kg)",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Weight cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ],
                      ),
                      new Padding(padding: EdgeInsets.only(top: 20.0)),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Address",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Weight cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        controller: _addressController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 20.0)),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Allergies(if any, specify)",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        controller: _allergyController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 20.0)),
                      RaisedButton(
                        child: Text('Save'),
                        color: Colors.blue[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () async {
                          Map<String, String> data = {
                            'firstName': _firstNameController.text,
                            'lastName': _lastNameController.text,
                            'phone': _contactController.text,
                            'dob':
                                DateFormat('yyyy-M-dd').format(_selectedDate),
                            'address': _addressController.text,
                            'allergy': _allergyController.text,
                            'gender': _gender,
                            'blood_grp': _bloodGrp,
                            'height': _heightController.text,
                            'weight': _weightController.text
                          };
                          _save(data);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                      ),
                    ])),
                  ),
                ),
              )));
    });
  }
}

class DropDownButtonGender extends StatefulWidget {
  DropDownButtonGender({Key key}) : super(key: key);

  @override
  _DropDownButtonGenderState createState() => _DropDownButtonGenderState();
}

class _DropDownButtonGenderState extends State<DropDownButtonGender> {
  String dropdownValue = 'Male';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 16,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          _gender = dropdownValue;
        });
      },
      items: <String>['Male', 'Female', 'Others']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black54)),
        );
      }).toList(),
    );
  }
}

class DropDownButtonBlg extends StatefulWidget {
  DropDownButtonBlg({Key key}) : super(key: key);

  @override
  _DropDownButtonBlgState createState() => _DropDownButtonBlgState();
}

class _DropDownButtonBlgState extends State<DropDownButtonBlg> {
  String dropdownValue = 'A+';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 18,
      elevation: 16,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          _bloodGrp = dropdownValue;
        });
      },
      items: <String>['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black54)),
        );
      }).toList(),
    );
  }
}
