import 'package:flutter/material.dart';

const int kHttpSuccessful = 200;

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 55.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 35.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 55.0,
);
final kTextFieldInputDecoration = InputDecoration(
  hintText: 'Enter the city',
  hintStyle: const TextStyle(
    color: Colors.grey,
  ),
  fillColor: Colors.white,
  filled: true,
  icon: const Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
);
