import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_report/Reports/medicalfetch.dart';

class FilesList extends StatefulWidget {
  final String type;
  FilesList(this.type);

  @override
  _FilesListState createState() => _FilesListState();
}

class _FilesListState extends State<FilesList> {
  Future<List<dynamic>> data;

  @override
  void initState()  {
    super.initState();
    data = MedicalFetch.searchDjangoApi(widget.type);
    print('Data: $data');
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
                print(snapshot.data);

                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    //DateTime date = DateTime.parse(snapshot.data[index]["record_date"]);
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      elevation: 5.0,
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text(
                                 DateFormat.yMMMd().format(DateTime.parse(snapshot.data[index]["record_date"]))
                                ),
                                ),
                              ),
                            ),
                        title: Text(snapshot.data[index]["description"],
                           // style: Theme.of(context).textTheme.headline1
                          ),
                        subtitle: Text(
                          snapshot.data[index]["extracted_data"],
                          style: TextStyle(color: Colors.grey),
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
