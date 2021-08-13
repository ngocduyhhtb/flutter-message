import 'package:flutter/material.dart';

logoCircle(BuildContext context) {
  return CircleAvatar(
    radius: 50,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset("assets/images/logo.png"),
    ),
  );
}
