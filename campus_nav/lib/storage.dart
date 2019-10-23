//Dart input/ouput operations
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

//this.storageName must be defined as: {profile ; settings ; favourites}
class Storage {

  Future <String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future <File> get _localFile async {
    final path = await _localPath;
    return File('$path/db.dat');
  }

  Future writeData(String data) async {
    final file = await _localFile;
    return file.writeAsString("$data");
  }

  Future readData() async {
    try {
      final file = await _localFile;
      // Read the file
      String body = await file.readAsString();
      return body;
    } 
    catch (e) {
      return e.toString();
    }
  }



}