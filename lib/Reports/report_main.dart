import 'package:flutter/material.dart';
import 'package:med_report/Reports/files_categories.dart';
import 'package:med_report/Reports/upload.dart';
import 'package:med_report/Reports/graph.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Category(),
            DateTimeChart.withSampleData(),
            AddReport()
            //selectLoc(context),
            //form(context),
          ],
        ),
      ),
    );
  }
}
