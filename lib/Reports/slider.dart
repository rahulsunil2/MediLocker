import 'package:flutter/material.dart';

class Sliding extends StatefulWidget {
  @override
  _SlidingState createState() => _SlidingState();
}

class _SlidingState extends State<Sliding> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
          children: <Widget>[
            Menu(height1: 400,action: 1,),
            Menu(height1: 390,action: 2,),
            Menu(height1: 380,action: 3,),
            Menu(height1: 370,action: 4,),

          ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Menu extends StatefulWidget {

  Menu({this.height1, this.action});
  double height1;
  int action;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  _onDragStart(BuildContext context, DragStartDetails start,int action) {
    print(start.globalPosition.toString());
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(start.globalPosition);
    if(local.dx.toString()!=start.globalPosition.toString()){

      Navigator.push(context,MaterialPageRoute(builder: (_) {
        return Menu(action:action+1);
      }));
    }
    print(local.dx.toString() + "|" + local.dy.toString());
  }

  _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    //print(update.globalPosition.toString());
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(update.globalPosition);
    //print(local.dx.toString() + "|" + local.dy.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height1,
      width: 300,
      child: GestureDetector(
        onHorizontalDragStart: (DragStartDetails start) =>
            _onDragStart(context, start, widget.action),
        onHorizontalDragUpdate: (DragUpdateDetails update) =>
            _onDragUpdate(context, update),
        child: Card(
          elevation: 10,
          child: Text(widget.action.toString()),

        ),
      ),
    );

  }
}
class Test extends StatefulWidget {
  @override
  _TestState createState() => new _TestState();
}

class _TestState extends State<Test> {
  _onDragStart(BuildContext context, DragStartDetails start) {
    print(start.globalPosition.toString());
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(start.globalPosition);
    print(local.dx.toString() + "|" + local.dy.toString());
  }

  _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    //print(update.globalPosition.toString());
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(update.globalPosition);
    //print(local.dx.toString() + "|" + local.dy.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new GestureDetector(
          child: new Text("Drag"),
          onHorizontalDragStart: (DragStartDetails start) =>
              _onDragStart(context, start),
          onHorizontalDragUpdate: (DragUpdateDetails update) =>
              _onDragUpdate(context, update),
        ),
      ),
    );
  }
}