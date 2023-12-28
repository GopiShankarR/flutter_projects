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
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: CustomPaint(
          painter: PlanePainter(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 560,
              itemBuilder: (BuildContext context, int index) {
                if (index % 9 == 0) {
                  return Center(
                    child: Text(
                      '${index ~/ 9 + 1}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  if (index ~/ 9 == 35 && index % 9 == 8) {
                    return Container(
                      color: Colors.red,
                      child: const Center(
                        child: Text(
                          'Emergency Exit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (index % 9 == 8) {
                    return Container();
                  } else {
                      List<String> seatLabels = ['A', 'B', 'C', '', 'E', 'F', 'G', ''];
                      int adjustedIndex = (index - 1) % 9;
                      
                      if (adjustedIndex == 3) {
                        return Container();
                      } else {
                        String seatLabel = seatLabels[adjustedIndex];
                        return GestureDetector(
                          onTap: () {
                            
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                '$seatLabel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}