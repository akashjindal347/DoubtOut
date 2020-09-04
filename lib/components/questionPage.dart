import 'package:flutter/material.dart';
import '../util/camera.dart';

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(100.0),
                child: Center(
                  child: TextField(

                  )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Camera(),
            ),
          )
        ],
      )
    );
  }
}