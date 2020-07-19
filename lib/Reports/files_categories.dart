import 'package:flutter/material.dart';
import 'package:med_report/Reports/reports_list.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        ]
      )
    );
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FilesList(title)
            )
          );
        },
      )
    );
  }
}