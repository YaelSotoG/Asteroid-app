import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final decoration = BoxDecoration(
    //     gradient: LinearGradient(
    //   begin: Alignment.topRight,
    //   end: Alignment.bottomCenter,
    //   stops: [0.02, 0.55],
    //   colors: [Color.fromRGBO(224, 225, 221, 1), Color.fromRGBO(2, 62, 125, 1)],
    // ));

    return Stack(
      children: [
        Container(
            // decoration: decoration,
            color: Color.fromRGBO(20, 19, 21, 1)),
        Positioned(
            right: -300,
            top: 80,
            child: luna(Color.fromRGBO(249, 199, 132, 1),
                Color.fromRGBO(252, 158, 79, 1))),
        Positioned(
            left: -300,
            bottom: -200,
            child: luna(Color.fromRGBO(124, 254, 240, 1),
                Color.fromRGBO(44, 234, 163, 1)))
      ],
    );
  }

  Widget luna(Color color, colorb) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(400),
          gradient: gradiente(color, colorb)),
    );
  }
}

gradiente(Color color, colorb) {
  return RadialGradient(
    center: Alignment(-.3, -.5),
    radius: .25,
    tileMode: TileMode.mirror,
    // begin: Alignment.topCenter,
    // end: Alignment.bottomCenter,
    // stops: [0.5, 0.55],
    colors: [color, colorb],
  );
}
