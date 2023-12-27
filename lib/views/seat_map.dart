import 'package:flutter/material.dart';

enum SeatStatus { available, booked, selected }

class Seat {
  final String seatNumber;
  SeatStatus status;

  Seat(this.seatNumber, this.status);
}

class SeatMap extends StatefulWidget {
  String flightNumber;
  SeatMap(this.flightNumber, {super.key});

  @override
  State<SeatMap> createState() => _SeatMapState();
}

class PlanePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Implement the painting of the plane structure
    // e.g., cockpit, wings, emergency exits, etc.
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _SeatMapState extends State<SeatMap> {
  List<Seat> seats = [
    Seat('A1', SeatStatus.available),
    Seat('A2', SeatStatus.available),
    // Add more seats here
  ];

  void _onSeatSelected(int index) {
    setState(() {
      if (seats[index].status == SeatStatus.available) {
        seats[index].status = SeatStatus.selected;
      } else if (seats[index].status == SeatStatus.selected) {
        seats[index].status = SeatStatus.available;
      }
      // Handle other cases if needed
    });
  }

  Widget _buildSeat(int index) {
    Color seatColor;
    IconData seatIcon;
    switch (seats[index].status) {
      case SeatStatus.available:
        seatColor = Colors.green;
        seatIcon = Icons.airline_seat_recline_normal;
        break;
      case SeatStatus.booked:
        seatColor = Colors.grey;
        seatIcon = Icons.airline_seat_individual_suite;
        break;
      case SeatStatus.selected:
        seatColor = Colors.blue;
        seatIcon = Icons.airline_seat_legroom_extra;
        break;
    }

    return GestureDetector(
      onTap: () {
        _onSeatSelected(index);
      },
      child: Container(
        margin: EdgeInsets.all(4),
        color: seatColor,
        child: Center(
          child: Icon(
            seatIcon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seating Map for Flight ${widget.flightNumber}'),
      ),
      body: Center(
        child: CustomPaint(
          painter: PlanePainter(), // CustomPainter for plane structure
          child: Container(
            // Container for seating arrangement
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // Adjust as needed
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 56, // Number of seats, adjust as needed
              itemBuilder: (BuildContext context, int index) {
                int rowNumber = (index ~/ 7) + 1;
                String rowIdentifier = String.fromCharCode(64 + rowNumber);
                if ((index + 1) % 7 == 4) {
                  return Container();
                } else {
                  int adjustedIndex = index - (index ~/ 4);
                  return GestureDetector(
                    onTap: () {
                      // Handle seat selection or other actions
                    },
                    child: Container(
                      // Customize container based on seat status
                      decoration: BoxDecoration(
                        color: Colors.green, // Example color for available seat
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          '$rowIdentifier$adjustedIndex',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}