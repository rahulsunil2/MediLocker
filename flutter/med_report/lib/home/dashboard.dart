import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_report/bloc_login/bloc/authentication_bloc.dart';
import 'package:med_report/reports/imagecap.dart';


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
              sym: Icons.person_pin,
              colour: Colors.blueGrey, 
              action: 1,
            ),
            Menu(
              title: 'Info',
              sym: Icons.info_outline,
              colour: Colors.blue, 
              action: 2,
            ),
            Menu(
              title: 'Medical Reports',
              sym: Icons.library_books,
              colour: Colors.teal, 
              action: 3,
            ),
          ],
        ),
      ),
    );
  } 
}
class Menu extends StatelessWidget {
  Menu({this.title, this.sym, this.colour, this.action});
  final String title;
  final IconData sym;
  final MaterialColor colour;
  final int action;

  @override 
  Widget build(BuildContext context) {

    print(action);
    
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: <Widget>[
              IconButton(
                icon: Icon(sym),
                iconSize: 70.0,
                color: colour, 
                onPressed: () {
                  if(action==3){
                    print("Moved");
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageCapture()));
                  }
                },
              ),
              Text(title, style: new TextStyle(fontSize: 17.0))
            ],
          ),
        ),
      ),
    );
  }
}
