import 'package:beautiful_list/model/lesson.dart';
import 'package:flutter/material.dart';
import 'package:beautiful_list/detail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Colors.white, fontFamily: 'Raleway'),
      home: new ListPage(title: 'Videos'),
      // home: DetailPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Video> videos = [];

  @override
  void initState() {
    getVideos();
    super.initState();
  }


  Widget makeBody (videos) {
    // print('length');
    // print(videos.length);
    if (videos!= null && videos.length > 0) {
      // print('length');
      // print(videos.length);
      return Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: videos.length,
          itemBuilder: (BuildContext context, int index) {
            print(index);
            return makeCard(videos[index]);
          },
        ),
      );
    }
    else {
      return Container();
    }
  }

  Card makeCard(Video video) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: makeListTile(video),
    ),
  );


  ListTile makeListTile(Video video) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.amber)
          )
      ),
      child: Icon(Icons.play_circle_filled, color: Colors.amber),
    ),
    title: Text(
      video.name,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    subtitle: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("", style: TextStyle(color: Colors.black))),
        )
      ],
    ),
    trailing: Icon(Icons.keyboard_arrow_right, color:  Color.fromRGBO(64, 75, 96, .9), size: 30.0),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(video: video)));
    },
  );

  @override
  Widget build(BuildContext context) {

    print('rebulit');

      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.white,
      title: Text("Videos"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar,
      body: Container(
        child: makeBody(videos),
      ),
//      ),
    );
  }


  getVideos() {
    List <Video> _videos =[];
    http.get('https://doubtout-videos-api.herokuapp.com/api/').then((http.Response response)
    {
      final List <Video> fetchedVideos = [];
      print(json.decode(response.body).runtimeType);
      final List videosListdata = json.decode(response.body);
      for(int i = 0; i < videosListdata.length; i++) {
        final Video video = Video(
          id: videosListdata[i]['id'],
          name: videosListdata[i]['name'],
          link: videosListdata[i]['link'],
          subject: videosListdata[i]['subject'],
        );
        print(video);
        fetchedVideos.add(video);
      }
      _videos = fetchedVideos;
      setState(() {
        videos = _videos;
      });
      print('set case');
    });
  }
}
