import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_report/Profile/profileui.dart';
import 'package:med_report/Reports/AllRecords/reports_list.dart';
import 'package:med_report/Reports/report_main.dart';
import 'package:med_report/bloc_login/bloc/authentication_bloc.dart';
import 'package:med_report/global.dart';
import 'package:unicorndial/unicorndial.dart';

import '../upload.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends  State<Home> with SingleTickerProviderStateMixin  {
  double screenHeight;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        //hasLabel: true,
        labelText: "",
        currentButton: FloatingActionButton(
         heroTag: "Profile",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            heroTag: "Add",
            backgroundColor: Colors.greenAccent,
            mini: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddReport()),
              );
            },
            child: Icon(Icons.add))));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            heroTag: "List",
            backgroundColor: Colors.blueAccent,
            mini: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilesList()),
              );
            },
            child: Icon(Icons.list))));
    screenHeight = MediaQuery.of(context).size.height;
    print('Home..');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
     /* drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue[500], Colors.indigo[500]]),
              //color: Colors.blue,
            ),
            accountName: new Text(
              CurrentUser.currentUser,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/user.jpg'),
            ),
            accountEmail: null,
          ),
          ListTile(
            leading: IconButton(icon: Icon(Icons.person), onPressed: () {}),
            title: Text('Profile',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          SizedBox(height: 30),
          ListTile(
            leading:
                IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
            title: Text('Notification',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
          SizedBox(height: 30),
          ListTile(
            leading: Image.asset('images/family.png',
                color: Colors.grey, width: 40.0, height: 40.0),
            title: Text('  My Family',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 30),
          ListTile(
            leading: IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            title: Text('Settings',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 30),
          ListTile(
            leading: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                }),
            title: Text('Log Out',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 30),
        ],
      )),*/
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            upperHalf(context),
            general(context),
            milestone(context),
            milestone1(context),
            milestone2(context),

            Positioned(
              left: 10,
              top: 40,
              child: IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              ),
            ),




            //options(context),
          /*  Positioned(
              left: 10,
              top: 40,
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: () => scaffoldKey.currentState.openDrawer(),
              ),
            ), */
          ],
        ),
      ),
        floatingActionButton: UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
            parentButtonBackground: Colors.redAccent,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: childButtons),

    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 3 + 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0),bottomLeft: Radius.circular(20.0)),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueAccent, Colors.greenAccent]),
      ),
    );
  }



  Widget general(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: screenHeight / 4 - 60),
        padding: EdgeInsets.only(left: 20, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Text(
              'Hi',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 35,
                  color: Colors.black),
            ),
            Text(
              CurrentUser.currentUser,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
          ],
        ));
  }

  Widget milestone(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (screenHeight / 4) + 45),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          trailing: Image.network(
              "https://image.flaticon.com/icons/png/512/163/163813.png"),
          title: Text(
            'Congratulations !',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          subtitle: Text('You completed 10000 steps today'),
          isThreeLine: true,
        ),
        color: Colors.lightBlueAccent,
      ),
    );
  }
  Widget milestone1(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (screenHeight / 2) ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          trailing: Image.network(
              "https://image.flaticon.com/icons/png/512/163/163813.png"),
          title: Text(
            'Fun Fact',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          subtitle: Text('People With Increased Risk of Alzheimers Have Deficits in Navigating'),
          isThreeLine: true,
        ),
        color: Colors.lightBlueAccent,
      ),
    );
  }
  Widget milestone2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:500),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          trailing: Image.network(
              "https://image.flaticon.com/icons/png/512/163/163813.png"),
          title: Text(
            'Obesity',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          subtitle: Text('Transplanted Brown-Fat-Like Cells Hold Promise for Obesity and Diabetes'),
          isThreeLine: true,
        ),
        color: Colors.lightBlueAccent,
      ),
    );
  }

  Widget options(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: screenHeight / 2 + 30, left: 10),
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text("What are you looking for ?",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
          ),
          GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                Menu(
                    title: "    Drug \nReminder",
                    action: 1,
                    color: Colors.yellow[300],
                    path: 'images/New message-pana.png'),
                Menu(
                    title: "Prescriptions",
                    action: 2,
                    color: Colors.orange[300],
                    path: 'images/Accept terms-rafiki.png'),
                Menu(
                    title: "Records",
                    action: 3,
                    color: Colors.blue[300],
                    path: 'images/Upload-rafiki.png'),
                Menu(
                    title: "     Doctor\nConsultation",
                    action: 4,
                    color: Colors.green[300],
                    path: 'images/Online Doctor-pana.png'),
                Menu(
                    title: " Smart\nDevices",
                    action: 5,
                    color: Colors.white,
                    path: 'images/Jogging-rafiki.png'),
                Menu(
                    title: "  Online \nShopping",
                    action: 6,
                    color: Colors.cyan[300],
                    path: 'images/Credit Card Payment-pana.png'),
              ]),
        ]));
  }
}

// ignore: must_be_immutable
class Menu extends StatelessWidget {
  var color;

  Menu({this.title, this.action, this.color, this.path});
  final String title;
  final int action;
  final String path;
  //final Color color1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (action == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Options()
                  //AddReport()
                  ));
        }
      },
      child: Container(
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.all(5.0),
          color: color,
          shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.black,width: 3),

            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                 padding: const EdgeInsets.only(top: 5.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      path,
                     // fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Monsteratt',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                ),
              ]),
        ),
      ),
    );
  }
}
