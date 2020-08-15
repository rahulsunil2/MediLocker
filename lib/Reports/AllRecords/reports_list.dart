import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_report/Reports/AllRecords/medicalfetch.dart';

class FilesList extends StatefulWidget {
  final String type;
  FilesList(this.type);

  @override
  _FilesListState createState() => _FilesListState();
}

class _FilesListState extends State<FilesList> {
  Future<List<dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = MedicalFetch.searchDjangoApi(widget.type);
//    print('Data: $data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(widget.type),
        ),
        body: SingleChildScrollView(child: items()));
  }

  Widget items() {
    return Container(
        child: FutureBuilder(
            future: data,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                // Data fetched successfully, display your data here
                var fetchedData = snapshot.data[0]["extracted_data"];
                print(fetchedData);

                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    //DateTime date = DateTime.parse(snapshot.data[index]["record_date"]);
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      elevation: 5.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Column(children: <Widget>[
                                  Text(
                                    DateFormat.MMMd().format(DateTime.parse(
                                        snapshot.data[index]["record_date"])),
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  Text(
                                    DateFormat.y().format(DateTime.parse(
                                        snapshot.data[index]["record_date"])),
                                    style: TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          title: Text(
                            snapshot.data[index]["description"],
                            // style: Theme.of(context).textTheme.headline1
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  jsonDecode(
                                      snapshot.data[index]["extracted_data"]),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              } else {
                return Container();
              }
            }));
  }
}
