import 'package:flutter/material.dart';
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

  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _dobController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _addressController = TextEditingController();
  final _allergyController = TextEditingController();

  _save(Map data) async {
    data['user'] = CurrentUser.user;
    CurrentUser.phone = data['phone'];
    CurrentUser.dob = data['dob'];
    CurrentUser.address = data['address'];
    CurrentUser.allergy = data['allergy'];
    CurrentUser.gender = data['gender'];
    CurrentUser.blood_grp = data['blood_grp'];
    CurrentUser.height = data['height'];
    CurrentUser.weight = data['weight'];
    String url = Common.baseURL + 'users/api_userprofile';
    await uploadToDb(url, body: data);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
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
                    TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Full Name",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      controller: _nameController,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Date of Birth ",
                              hintText: "yyyy-mm-dd",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            controller: _dobController,
                            validator: (val) {
                              if (val.length == 0) {
                                return "DOB cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.datetime,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10.0)),
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Age",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              ),
                            ),
                            controller: _ageController,
                            validator: (val) {
                              if (val.length == 0) {
                                return "Age cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ],
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        Map data = {
                          'user': CurrentUser.currentUser,
                          //'name'    :  _nameController.text,
                          'phone': _contactController.text,
                          'dob': _dobController.text,
                          'address': _addressController.text,
                          'allergy': _allergyController.text,
                          'gender': _gender,
                          'blood_grp': _bloodGrp,
                          'height': _heightController.text,
                          'weight': _weightController.text
                        };
                        print(data);
                        _save(data);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    RaisedButton(
                      child: Text('Submit'),
                      color: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(color: Colors.black)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ])),
                ),
              ),
            )));
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
