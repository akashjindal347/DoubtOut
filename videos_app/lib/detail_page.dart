import 'package:beautiful_list/model/lesson.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

    final topContent = Container(
      child: YoutubePlayer(
    context: context,
    videoId:YoutubePlayer.convertUrlToId(video.link),
    flags: YoutubePlayerFlags(
      autoPlay: true,
      showVideoProgressIndicator: true,
    ),
    videoProgressIndicatorColor: Colors.amber,
    progressColors: ProgressColors(
      playedColor: Colors.amber,
      handleColor: Colors.amberAccent,
    ),
    onPlayerInitialized: (controller) {
      // _controller = controller;
      // _controller.addListener(listener);
    },
),
    );

    final bottomContentText =Column(
      children: <Widget>[
        Text(
      video.name,
      style: TextStyle(fontSize: 18.0),
    ),
    SizedBox(
      height: 40.0,
    ),
    Text(
      "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. ... The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout.",
      style: TextStyle(fontSize: 18.0),
    ),
      ],
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
