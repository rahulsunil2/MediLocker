import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:med_report/bloc_login/login/bloc/global.dart';

class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key: key);
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://medilocker-thingqbator.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload() {
    /// Unique file name for the file
    String filePath = 'images/${Name.currentUsername}/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete) 
                  Text('Uploaded Successfully'),
                  IconButton(icon: Icon(Icons.arrow_right), onPressed: () {  },),
                
                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
