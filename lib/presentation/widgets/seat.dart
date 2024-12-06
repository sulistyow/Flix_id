import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

enum SeatStatus { avaiable, reserved, selected }

class Seat extends StatelessWidget {
  final int? number;
  final SeatStatus status;
  final double size;
  final VoidCallback? onTap;

  const Seat(
      {super.key,
      this.number,
      this.status = SeatStatus.avaiable,
      this.size = 30,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: status == SeatStatus.avaiable
              ? Colors.white
              : status == SeatStatus.reserved
                  ? Colors.grey
                  : saffron,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(
          child: Text(
            number?.toString() ?? '',
            style:
                TextStyle(color: backgroundColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
