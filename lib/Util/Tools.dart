
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tools{

  static double getSize(double size, BuildContext context){
    return MediaQuery.of(context).size.width * size;
  }

  static String getGreetings() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);
    int hour = int.parse(formattedTime.substring(0, 2));

    String greeting = "";

    if (hour >= 5 && hour < 12) {
      greeting = "Good morning!";
    } else if (hour >= 12 && hour < 18) {
      greeting = "Good afternoon!";
    } else {
      greeting = "Good evening!";
    }

    return greeting;
  }

}