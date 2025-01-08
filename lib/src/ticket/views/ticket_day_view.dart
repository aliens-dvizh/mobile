import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketDayView extends StatelessWidget {
  final ValueNotifier<Offset> clickPosition = ValueNotifier(Offset.zero);
  final VenueController _venueController = VenueController();
  final Venue _venue = Venue(
    seats: [
      Seat(offset: Offset(0, 0)),
      Seat(offset: Offset(30, 30)),
      Seat(offset: Offset(30, 0)),
      Seat(offset: Offset(0, 30)),
      Seat(offset: Offset(-30, 0)),
      Seat(offset: Offset(-30, 30)),
      Seat(offset: Offset(0, 0)),
    ],
  );

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
          child: SizedBox(
        width: double.infinity,
        height: 100,
        child: GestureDetector(
          onTapUp: (details) {
            print(details.localPosition);
            clickPosition.value = details.localPosition;
          },
          child: ValueListenableBuilder(
            valueListenable: clickPosition,
            builder: (context, value, child) => CustomPaint(
              painter: VenuePainter(
                clickPosition: value,
                venueController: _venueController,
                venue: _venue,
              ),
            ),
          ),
        ),
      ));
}

class VenuePainter extends CustomPainter {
  VenuePainter({
    required this.clickPosition,
    required this.venueController,
    required this.venue,
    super.repaint,
  });

  final Offset clickPosition;
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
            : Colors.black,
    );
  }

  bool _isClickedOnRect(Rect rect) => rect.contains(clickPosition);

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
        Paint()..strokeWidth = 2);
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
  Seat({required this.offset});

  final Offset offset;
}
