import 'package:flutter/material.dart';
import 'package:med_report/Reports/AllRecords/detailsFetch.dart';

class FileDetails extends StatefulWidget {
  final String filename;
  FileDetails(this.filename);
  @override
  _FileDetailsState createState() => _FileDetailsState();
}

class _FileDetailsState extends State<FileDetails> {
  Future<List<dynamic>> data;

  @override
  void initState() {
    super.initState();
    //print(widget.filename);
    data = DetailsFetch.searchDjangoApi(widget.filename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Record Details'),
        ),
        body: SingleChildScrollView(child: info()));
  }

  Widget info() {
    print(widget.filename);
    return Container(
        child: FutureBuilder(
            future: data,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                var fetchedData = snapshot.data[0]["extracted_data"];
                print(fetchedData);
                return Card(
                  color: Colors.blueGrey,
                  child: Container(
                    height: 200,
                    width: 150,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Image.network(snapshot.data[0][widget.filename],
                        fit: BoxFit.cover),
                  ),
                );
              } else {
                return Container();
              }
            }));
  }
}
