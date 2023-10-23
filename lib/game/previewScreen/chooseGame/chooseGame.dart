// ignore: file_names
import 'package:flutter/material.dart';

Widget gameItemchoose(
  BuildContext context,
  VoidCallback onTap,
  String text,
  String imageGame,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 16,
        child: Image.asset(text),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(imageGame),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      InkWell(
        onTap: onTap,
        child: SizedBox(
            height: 67,
            width: 99,
            child: Image.asset('assets/images/icons/play.png')),
      ),
    ],
  );
}

Widget gameItemchoosex(
  BuildContext context,
  VoidCallback onTap,
  String text,
  String imageGame,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 16,
        child: Image.asset(text),
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(imageGame),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      InkWell(
        onTap: onTap,
        child: SizedBox(
            height: 67,
            width: 99,
            child: Image.asset('assets/images/icons/read.png')),
      ),
    ],
  );
}
