import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

Widget movieScreen() => Container(
      height: 50,
      width: 250,
      margin: EdgeInsets.only(top: 24, bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [saffron.withOpacity(0.33), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
    );
