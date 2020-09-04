import 'package:flutter/material.dart';

class DoubtScreen extends StatefulWidget {
  @override
  DoubtScreenState createState() => DoubtScreenState();
}

class DoubtScreenState extends State<DoubtScreen> {
  List<Offset> points = <Offset>[];


  @override
  Widget build(BuildContext context) {

    final Container sketchArea = Container(
      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      color: Colors.blueGrey[50],
      child: CustomPaint(
        painter: Sketcher(points),
      ),
    );

    // TODO: implement build
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox box = context.findRenderObject();
          Offset point = box.globalToLocal(details.globalPosition);
          point = point.translate(0.0, -(AppBar().preferredSize.height));
          points = List.from(points)..add(point);
        });
        print(points);
//          print(point);
      },
      onPanEnd: (DragEndDetails details) {
        points.add(null);
      },
      child: sketchArea,
    );
  }
}

class Sketcher extends CustomPainter {
  final List<Offset> points;

  Sketcher(this.points);

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.points != points;
  }

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }
}