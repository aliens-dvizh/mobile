import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptom_widgetbook/kit/components/buttons/button.dart';

class TicketDayView extends StatelessWidget {
  void view(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => this,
    );
  }

  final ValueNotifier<Offset> clickPosition = ValueNotifier(Offset.zero);
  final VenueController _venueController = VenueController();
  final TransformationController _transformationController =
      TransformationController();

  final Venue _venue = Venue(
    seats: [
      Seat(offset: Offset(0, 0), place: 1),
      Seat(offset: Offset(30, 30), place: 2),
      Seat(offset: Offset(30, 0), place: 3),
      Seat(offset: Offset(0, 30), place: 4),
      Seat(offset: Offset(-30, 0), place: 5),
      Seat(offset: Offset(-30, 30), place: 6),
      Seat(offset: Offset(-60, 0), place: 7),
    ],
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  boundaryMargin: const EdgeInsets.all(20.0),
                  minScale: 0.5,
                  // Минимальный масштаб
                  maxScale: 3.0,
                  // Максимальный масштаб
                  child: GestureDetector(
                    onTapUp: (details) {
                      clickPosition.value = details.localPosition;
                    },
                    child: ValueListenableBuilder(
                      valueListenable: clickPosition,
                      builder: (context, value, child) => SizedBox.expand(
                        child: CustomPaint(
                          painter: VenuePainter(
                            clickPosition: clickPosition,
                            venueController: _venueController,
                            venue: _venue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ButtonWidget(onPressed: () {}, child: Text('asdasd'))
            ],
          ),
        ),
      );
}

class VenuePainter extends CustomPainter {
  VenuePainter({
    required this.clickPosition,
    required this.venueController,
    required this.venue,
    super.repaint,
  });

  final ValueNotifier<Offset> clickPosition;
  final VenueController venueController;
  final Venue venue;

  static const double sizeSeat = 20;

  void _seatPaint(Canvas canvas, Size size, Seat seat) {
    final rectX = size.width / 2 + seat.offset.dx;
    final rectY = size.height / 2 + seat.offset.dy;

    final rect = Rect.fromCenter(
      center: Offset(rectX, rectY),
      width: sizeSeat,
      height: sizeSeat,
    );

    if (_isClickedOnRect(rect)) _switchSeat(seat);

    canvas.drawRect(
      rect,
      Paint()
        ..strokeWidth = 2
        ..color = venueController.selectedSeats.contains(seat)
            ? Colors.red
            : Colors.grey,
    );
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          children: [
            if (seat.row != null)
              TextSpan(
                text: '${seat.row} ряд\n',
              ),
            TextSpan(
              text: '${seat.place} место\n',
            )
          ],
          style: TextStyle(
            color: Colors.black,
            fontSize: 5,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width - 12.0 - 12.0);
    textPainter.paint(canvas, Offset(rectX - 10, rectY + 10));
  }

  bool _isClickedOnRect(Rect rect) => rect.contains(clickPosition.value);

  void _switchSeat(Seat seat) {
    venueController.toggle(seat);
  }

  void _createsqn(
      Canvas canvas, Size size, Offset offset, double width, double height) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(centerX + offset.dx, centerY + offset.dy),
          width: width,
          height: height),
      Paint()..strokeWidth = 2,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final seat in venue.seats) {
      _seatPaint(canvas, size, seat);
    }

    canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        Paint()
          ..color = Colors.orange
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class VenueController extends ChangeNotifier {
  VenueController({List<Seat>? selectedSeats})
      : selectedSeats = selectedSeats ?? [];

  final List<Seat> selectedSeats;

  void addSeat(Seat seat) {
    selectedSeats.add(seat);
    notifyListeners();
  }

  void removeSeat(Seat seat) {
    selectedSeats.remove(seat);
    notifyListeners();
  }

  void toggle(Seat seat) {
    if (selectedSeats.contains(seat)) return removeSeat(seat);
    return addSeat(seat);
  }
}

class Venue {
  Venue({required this.seats});

  final List<Seat> seats;
}

class Seat {
  Seat({
    required this.offset,
    required this.place,
    this.row,
  });

  final Offset offset;
  final int? row;
  final int place;
}
