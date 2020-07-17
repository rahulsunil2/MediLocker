import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_report/Profile/setProfile.dart';
import 'package:med_report/Reports/upload.dart';
import 'package:med_report/bloc_login/bloc/authentication_bloc.dart';
import 'package:med_report/global.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenHeight;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    print('Home..');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.lightBlue[50],
      drawer: Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            accountName: new Text(
              Common.currentUser,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/user.jpg'),
            ),
            accountEmail: null,
          ),
          ListTile(
            leading:IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
           }), 
            title: Text('Profile', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold) ),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ProfilePage()
                ),
                );
            },
          ),
          SizedBox(height: 30),
          ListTile(
            leading:IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
           }), 
            title: Text('Notification', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold) ),
          ),
          SizedBox(height: 30),
          ListTile(
            leading: Image.asset('images/family.png', color: Colors.grey, width: 40.0, height: 40.0),
            title: Text('  My Family', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold) ),
          ),
          SizedBox(height: 30),
          ListTile(
            leading:IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
           }), 
            title: Text('Settings', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold) ),
          ),
          SizedBox(height: 30),
          ListTile(
            leading: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: ()  {
                  
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            }),
            title: Text('Log Out', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 30),
        ],
      )),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            upperHalf(context),
            general(context),
            milestone(context),
            options(context),
            Positioned(
              left: 10,
              top: 40,
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.white, size: 30.0,),
                onPressed: () => scaffoldKey.currentState.openDrawer(),
              ),
            ),
      ],),),
      
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
        borderRadius: BorderRadius.circular(30)
      ),
      
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
              color: Colors.white
            ),
          ),
          Text(
            Common.currentUser,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.white
            ),
          ),
          SizedBox(height: 20),
        ],
      )
    );
  }

  Widget milestone(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (screenHeight / 5) + 110),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        child: ListTile(
          trailing: Image.network(
          "https://image.flaticon.com/icons/png/512/163/163813.png"),
          title: Text('Congratulations!'),
          contentPadding:
            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            subtitle: Text('You completed 10000 steps today'),
            isThreeLine: true,       
        ),
        color: Colors.blue[200],        
      ),
    );
  } 

  Widget options(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: screenHeight / 2 + 80 ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
            child: Text(
              "What do you need?", 
              style: TextStyle(
                fontSize: 24, 
                color: Colors.blue, 
                fontWeight: FontWeight.bold, )),),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: <Widget>[
              Menu(title:"    Drug \nReminder", action: 1),
              Menu(title:"Prescriptions", action: 2),
              Menu(title:"Records", action: 3),
              Menu(title:"     Doctor\nConsultation", action: 4),
              Menu(title:" Smart\nDevices", action: 5),
              Menu(title:"  Online \nShopping", action: 6),
          ]  
      ),
     ]
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
        side: BorderSide(color: Colors.blueAccent, style: BorderStyle.solid, width:1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RaisedButton(
        color: Colors.blue[900],
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height:10.0),
          Align(
            alignment: Alignment.topCenter,
            child:Text(
              title, style: TextStyle(fontSize: 10, fontFamily: 'Monsteratt', fontWeight: FontWeight.bold, color: Colors.white),
            )
          ),
        ]
        ),
        onPressed: (){
          if(action == 3){
            Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => AddReport()));
          }
        },
      )
      
    );
  }
}
