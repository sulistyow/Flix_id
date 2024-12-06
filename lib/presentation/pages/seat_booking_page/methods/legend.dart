import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';

Widget legend() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Seat(size: 20),
        horizontalSpace(5),
        Text('Available', style: TextStyle(fontSize: 12)),
        horizontalSpace(10),
        Seat(size: 20,status: SeatStatus.selected,),
        horizontalSpace(5),
        Text('Selected', style: TextStyle(fontSize: 12)),
        horizontalSpace(10),
        Seat(size: 20,status: SeatStatus.reserved,),
        horizontalSpace(5),
        Text('Reserved', style: TextStyle(fontSize: 12)),
        horizontalSpace(10),
      ],
    );
