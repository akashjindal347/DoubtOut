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
  List<Video> videos;

  @override
  void initState() {
    setState(() {
       videos = getVideos();
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Video video) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.amber))),
            child: Icon(Icons.play_circle_filled, color: Colors.amber),
          ),
          title: Text(
            video.name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("",
                        style: TextStyle(color: Colors.black))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color:  Color.fromRGBO(64, 75, 96, .9), size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(video: video)));
          },
        );

    Card makeCard(Video video) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: makeListTile(video),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: videos.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(videos[index]);
        },
      ),
    );

    // final makeBottom = Container(
    //   height: 55.0,
    //   child: BottomAppBar(
    //     color: Color.fromRGBO(58, 66, 86, 1.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: <Widget>[
    //         IconButton(
    //           icon: Icon(Icons.home, color:  Colors.white),
    //           onPressed: () {},
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.blur_on, color: Colors.white),
    //           onPressed: () {},
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.hotel, color: Colors.white),
    //           onPressed: () {},
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.account_box, color: Colors.white),
    //           onPressed: () {},
    //         )
    //       ],
    //     ),
    //   ),
    // );
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
      body: makeBody,
      
    );
  }
}

  getVideos() {
  List <Video> _videos =[];
   List <Video> fetchedVideos = [];
  http.get('https://doubtout-videos-api.herokuapp.com/api/').then((http.Response response)
  {
    
    final List <dynamic> videosListdata = json.decode(response.body);
    int length = videosListdata.length;
    // print(videosListdata[0]["id"]);
    for(var i =0;i<length;i++)
    {
      Video __video = Video(
        id: videosListdata[i]["id"],
        name:videosListdata[i]["name"],
        link:videosListdata[i]["link"],
      );
      fetchedVideos.add(__video);
     
    }
    // videosListdata.forEach((String ,Map<String,dynamic> videosdata )
    // {
    //   final Video video = Video(
    //     id: videosdata['id'],
    //     name: videosdata['name'],
    //     link: videosdata['link'],
    //     subject: videosdata['subject'],
    //   );
    //   fetchedVideos.add(video);
    //  print(video);
    // });
    //  print(fetchedVideos);
    _videos = fetchedVideos;
  
  });

  
  return _videos;


  
}
