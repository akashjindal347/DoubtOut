import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

//Routed
import '../components/doubtScreen.dart';

class Camera extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {

  File _image;

  Future getImage(context) async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    List<int> imageBytes = image.readAsBytesSync();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    Navigator.push(context, DoubtPage());
//    return Dialog(
//      backgroundColor: Color(0xFF444444),
//    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height*0.85 ,
          child: _image == null ? Text("No Image Selected") : Image.file(_image),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => getImage(context),
          tooltip: "Select Image",
          child: Icon(Icons.camera),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
class DoubtPage extends MaterialPageRoute<Null>{
  DoubtPage() : super(builder: (BuildContext context) {
    return DoubtScreen();
  });
}