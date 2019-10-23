import 'package:flutter/material.dart';

//Dart input/ouput operations
import 'dart:io';
//Stores fav's after each change in isFavourited boolean value - without repeating info
import 'storage.dart';

class MyCustomWidget extends StatefulWidget {
  final String name, theme, starts, ends, room, image;
  final bool isFavourited;
  final Storage storage;
  
  MyCustomWidget({
    @required Key key,
    @required this.storage,
    @required this.name, 
    @required this.theme, 
    @required this.starts, 
    @required this.ends, 
    @required this.room, 
    @required this.image,
    this.isFavourited}) : super(key: key);

  @override
  _MyCustomWidgetState createState() => 
  _MyCustomWidgetState(
    name: name,
    theme: theme,
    starts: starts,
    ends: ends,
    room: room,
    image: image,
    isFavourited: isFavourited,
  );
}

class _MyCustomWidgetState extends State<MyCustomWidget> {

  final String name, theme, starts, ends, room, image;
  bool isFavourited;
  Storage storage;
  String state;

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

  Future <File> writeData(String favs) async {
    setState(() {
      state = favs;
      favs = "";
    });
    return widget.storage.writeData(state);
  }

  _MyCustomWidgetState({
    @required this.name, 
    @required this.theme, 
    @required this.starts, 
    @required this.ends, 
    @required this.room, 
    @required this.image,
    this.isFavourited});
  
  updateFav() {
    setState(() {
      if(isFavourited) {
        isFavourited = false;
        //if()//se ja nao esta no ficheiro
      }
      else {
        isFavourited = true;       
      }
    });
  }

  updateGo() {
    setState(() {
      print('GO GO GO\n');   
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: 
        ClipOval(
          child: Image.asset(image,
            fit: BoxFit.fitWidth,
            width: 50.0,
            height: 50.0,
        )
      ),
      //key: ,
      title: Text(name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
      initiallyExpanded: false,
      children: <Widget>[
        ListTile(
          leading: IconButton(
            color: Colors.yellow,
            tooltip: "Add to  Myfavourites",
            icon: (isFavourited ? Icon(Icons.star) : Icon(Icons.star_border)),
            onPressed: updateFav,
          ),
          trailing: IconButton(
            tooltip: "Go to conference room",
            icon: Icon(Icons.directions_run),
            onPressed: updateGo,
          ),
          title: Text('Theme: ' + theme + '\nStarts: ' + starts + '\nEnds: ' + ends + '\nRoom: ' + room,
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20, color: Colors.white)),
        )
      ],
      trailing: Icon(Icons.arrow_drop_down_circle),
    );
  }
}

//Update everyday to display conferences on present day
List conferenceVector() {

  final String webSummitImg = 'assets/images/Web_Summit.png';
  final String icmlImg = 'assets/images/ICML.png';
  final String cesImg = 'assets/images/CES.png';
  final String dreamForceImg = 'assets/images/Dreamforce.png';
  final String inc5000Img = 'assets/images/inc-5000.png';

  List conferencesList = [
    ["Web Summit", "Tech", "10:30", "11:30", "B201", webSummitImg],
    ["ICML", "Science", "15:00", "17:30", "B314", icmlImg],
    ["CES", "Tech",  "10:30", "12:30", "B112", cesImg],
    ["Dreamforce", "Business", "16:30", "18:00", "B207", dreamForceImg],
    ["Inc. 5000", "Business", "15:30", "17:00", "B003", inc5000Img],
  ];

  return conferencesList;
}
  