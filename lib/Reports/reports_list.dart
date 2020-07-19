import 'package:flutter/material.dart';

class FilesList extends StatefulWidget {
  final String type;
  FilesList(this.type);

  @override
  _FilesListState createState() => _FilesListState();
}

class _FilesListState extends State<FilesList> {

  Future<List<dynamic>> data;

  @override
  // void initState() {
  //   super.initState();
  //   data = MaterialFetch.searchDjangoApi(widget.item);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(widget.type), 
      ),
      body: SingleChildScrollView(
       // child: items()
      )     
    );
  }

  // Widget items(){
  //   return Container(
  //     child: FutureBuilder(
  //       future: data,
  //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       if (snapshot.hasData) {
  //         // Data fetched successfully, display your data here
  //         return ListView.builder(
  //       itemBuilder: (ctx, index) {
  //         return Card(
  //           margin: EdgeInsets.symmetric(
  //             vertical: 8.0,
  //             horizontal: 8.0
  //           ),
  //           elevation: 5.0,
  //                     child: ListTile(
  //             leading: CircleAvatar(
  //               radius: 30, 
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: FittedBox(
  //                   child: Text('date')
  //                 ),
  //               )
  //             ),
  //             title: Text(
  //               transactions[index].title,
  //               style: Theme.of(context).textTheme.headline1),
  //             subtitle: Text(
  //               DateFormat.yMMMd().format(transactions[index].date),
  //               style: TextStyle(color: Colors.grey),
  //             ),
  //             trailing: IconButton(
  //               icon: Icon(Icons.delete), 
  //               color: Theme.of(context).errorColor,
  //               onPressed: () => deleteTx(transactions[index].id)
  //             ),
  //           ),
  //         );
                
  //        },
  //        itemCount: transactions.length,
  //       )
  //       }
  //     )
  //   );
  // }
}