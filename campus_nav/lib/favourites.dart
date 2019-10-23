import 'package:flutter/material.dart';

// Reads fav's data
import 'storage.dart';
// Access to conference custom tile widget
import 'conferenceTile.dart';
//App drawer used in all modules
import 'drawer.dart';

class MyFavourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('My Favourites'),),
      drawer: AppDrawer(),
      body: FavoritedConferences(storage: Storage()),
    );
  }
}

class FavoritedConferences extends StatefulWidget {
  final Storage storage;
  FavoritedConferences({Key key, @required this.storage}) : super(key: key);

  @override
  FavoritedConferencesState createState() => FavoritedConferencesState();
}

class FavoritedConferencesState extends State<FavoritedConferences> {
  String state;
  Storage storage;

  readData(String value) {
    setState(() {
      state = value;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then(readData);
  }

  //Checks if index is stored in file
  bool isInFile(num index) {
    String keyVal = "$index*";
    if(state.contains(keyVal))
      return true;
    else
      return false;
  }

  //Get conferences list
  final conferencesList = conferenceVector();
  //Children widget list
  final customWidgetList = <Widget>[];

  @override
  Widget build(BuildContext context) {
    
    for(var i=0; i<conferencesList.length; i++) {
      if(isInFile(i) == true) {
        customWidgetList.add(
          MyCustomWidget(
            key: Key("$i"), 
            storage: Storage(),
            name: conferencesList[i][0],
            theme: conferencesList[i][1],
            starts: conferencesList[i][2],
            ends: conferencesList[i][3],
            room: conferencesList[i][4],
            image: conferencesList[i][5],
          )
        );
      }
      else {
        continue;
      }
    }

    return ListView(  
        children: customWidgetList,
    );
  }
}