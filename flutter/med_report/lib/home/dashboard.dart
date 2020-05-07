import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_report/bloc_login/bloc/authentication_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Medilocker"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.green[50],
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text("user", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/user.jpg'),
              ),
              accountEmail: null,
            ),
            ListTile(
              title: Text('Welcome'),
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text('Change Password'),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                    .add(LoggedOut());
                }
              ),
              title: Text('Log Out'),
                                 
            ),
          ],)
      ),
      body: Container(
        padding:  EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Menu(
              title: 'Profile',
              icon: Icons.person_pin,
              colour: Colors.blueGrey, 
            ),
            Menu(
              title: 'Info',
              icon: Icons.info_outline,
              colour: Colors.blue, 
            ),
            Menu(
              title: 'Medical Reports',
              icon: Icons.library_books,
              colour: Colors.teal, 
            ),
          ],
        ),
      ),
    );
  } 
}
class Menu extends StatelessWidget {
  Menu({this.title, this.icon, this.colour});
  final String title;
  final IconData icon;
  final MaterialColor colour;

  @override 
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: <Widget>[
              Icon(
                icon, 
                size: 70.0,
                color: colour,
              ),
              Text(title, style: new TextStyle(fontSize: 17.0))
            ],
          ),
        ),
      ),
    );
  }
}
