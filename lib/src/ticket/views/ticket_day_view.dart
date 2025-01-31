

import 'package:flutter/material.dart';
import 'package:toptom_widgetbook/kit/export.dart';

class TicketDayView extends StatelessWidget {
  void view(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.8,
        child: this,
      ),
      isScrollControlled: true,
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
    maxScale: 4,
  );

  void _onSeatDetected(Seat seat) {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      clickPosition.value = Offset.zero;
      _venueController.toggle(seat);
    });

  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  boundaryMargin: const EdgeInsets.all(20.0),
                  minScale: 0.1,
                  maxScale: 3,
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
                            transformationController: _transformationController,
                            venue: _venue,
                            onSeatDetected: _onSeatDetected,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ListenableBuilder(
                listenable: _venueController,
                builder: (context, child) => Padding(
                    padding: const EdgeInsets.all(16).copyWith(top: 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        onPressed: _venueController.selectedSeats.isNotEmpty ? () {} : null,
                        size: ButtonSize.xl,
                        child: Text('Взять'),
                      ),
                    ),
                  ),
              )
            ],
          ),
        ),
      );
}

class VenuePainter extends CustomPainter {
  VenuePainter({
    required this.clickPosition,
    required this.venueController,
    required this.transformationController,
    required this.onSeatDetected,
    required this.venue,
    super.repaint,
  });

  final ValueNotifier<Offset> clickPosition;
  final VenueController venueController;
  final Venue venue;
  final TransformationController transformationController;
  final void Function(Seat) onSeatDetected;

  static const double sizeSeat = 20;

  void _seatPaint(Canvas canvas, Size size, Seat seat) {
    final rectX = size.width / 2 + seat.offset.dx;
    final rectY = size.height / 2 + seat.offset.dy;

    final rect = Rect.fromCenter(
      center: Offset(rectX, rectY),
      width: sizeSeat,
      height: sizeSeat,
    );

    if (_isClickedOnRect(rect)) {
      onSeatDetected.call(seat);
    }

    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(3)),
        Paint()
          ..strokeWidth = 2
          ..color = venueController.selectedSeats.contains(seat)
              ? Colors.red
              : Colors.grey);

    final scale = transformationController.value.getMaxScaleOnAxis();
    final alpha = ((scale - 1) * 205).clamp(0, 255).toInt();

    TextPainter(
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
            color: Colors.black.withAlpha(alpha),
            fontSize: 5,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width - 12.0 - 12.0)
      ..paint(canvas, Offset(rectX - 10, rectY + 10));
  }

  bool _isClickedOnRect(Rect rect) => rect.contains(clickPosition.value);

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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class VenueController extends ChangeNotifier {
  VenueController({List<Seat>? selectedSeats})
      : _selectedSeats = selectedSeats ?? [];

  final List<Seat> _selectedSeats;

  List<Seat> get selectedSeats => List.unmodifiable(_selectedSeats);

  void addSeat(Seat seat) {
    _selectedSeats.add(seat);
    notifyListeners();
  }

  void removeSeat(Seat seat) {
    _selectedSeats.remove(seat);
    notifyListeners();
  }

  void toggle(Seat seat) {
    if (_selectedSeats.contains(seat)) return removeSeat(seat);
    return addSeat(seat);
  }
}

class Venue {
  Venue({required this.seats, required this.maxScale});

  final List<Seat> seats;
  final double maxScale;
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
