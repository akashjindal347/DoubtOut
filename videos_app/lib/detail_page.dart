import 'package:beautiful_list/model/lesson.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Video video;
  DetailPage({Key key, this.video}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    

   

    final topContentText = ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(
          Icons.play_circle_filled,
          color: Colors.white,
          size: 70.0,
        ),
        
    
      
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.amberAccent),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      video.name,
      style: TextStyle(fontSize: 18.0),
    );
    
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );

    return Scaffold(
      body:ListView(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
