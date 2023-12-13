
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
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

  static void flushBarErrorMessage(String message, BuildContext context){

    showFlushbar(
        context: context,
        flushbar: Flushbar(

          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(10),
          message: message,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeOut,
          borderRadius: BorderRadius.circular(10),
          positionOffset: 20,
          icon: const Icon(Icons.error, size: 28, color: Colors.white),

        )..show(context)
    );

  }

}