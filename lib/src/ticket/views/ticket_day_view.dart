import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketDayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: CustomPaint(
          // child: ColoredBox(color: Colors.blue),
          painter: Stadion(),
        ),
      )
    );
  }

}

class Stadion extends CustomPainter {

  void _createstul(Canvas canvas, Size size, Offset offset) {
    canvas.drawRect(Rect.fromCenter(center: Offset(size.width /2 + offset.dx, size.height /2 + offset.dy), width: 20, height: 20), Paint()..strokeWidth = 2);
  }

  void _createsqn(Canvas canvas, Size size, Offset offset, double width, double height) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    canvas.drawRect(Rect.fromCenter(center: Offset(centerX + offset.dx, centerY + offset.dy), width: width, height: height), Paint()..strokeWidth = 2);
  }



  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(new Offset(size.width/ 2, size.height/ 2), 100, Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill,
    );

    ;

    _createstul(canvas, size, Offset(0, 0));
    _createstul(canvas, size, Offset(30, 30));
    _createstul(canvas, size, Offset(30, 0));
    _createstul(canvas, size, Offset(0, 30));
    _createstul(canvas, size, Offset(-30, 0));
    _createstul(canvas, size, Offset(-30, 30));
    _createsqn(canvas, size, Offset(0, 100), 200, 100);

    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height),  Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke);




  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;


  @override
  bool? hitTest(Offset position) {
    print('AAdasdasd');
    return true;
  }
  
}