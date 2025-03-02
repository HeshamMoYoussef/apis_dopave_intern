import 'package:flutter/material.dart';
import 'package:omar_apis/utils/animation_extension.dart';

class DismissibleBackgroundWidget extends StatelessWidget {
  const DismissibleBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.darken,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.redAccent,
            Colors.lightGreenAccent,
            Colors.blueGrey,
            Colors.lightGreenAccent,
            Colors.redAccent,
            Colors.lightGreenAccent,
            Colors.blueGrey,
            Colors.lightGreenAccent,
          ],
        ),
        borderRadius: BorderRadius.circular(35),
        color: Colors.redAccent,
        // border: Border.all(color: Colors.red, width: 3.0),
      ),
      child: const Center(
        child: Text(
          'Remove User',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).animateShimmer();
  }
}
