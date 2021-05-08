import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amber, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amber, width: 2.0),
  ),
);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.grey[850],
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle mapButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.amber,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle tabButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.amber,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: CircleBorder(),
);
