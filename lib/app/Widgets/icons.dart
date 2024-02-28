import 'package:flutter/material.dart';
import 'package:getx_example_app/app/core/values.dart/colors.dart';
import 'package:getx_example_app/app/core/values.dart/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(
      IconData(
        personIcon,
        fontFamily: 'MaterialIcons',
      ),
      color: purpel,
    ),
    Icon(
      IconData(
        workIcon,
        fontFamily: 'MaterialIcons',
      ),
      color: pink,
    ),
    Icon(
      IconData(
        movieIcon,
        fontFamily: 'MaterialIcons',
      ),
      color: green,
    ),
    Icon(
      IconData(
        sportIcon,
        fontFamily: 'MaterialIcons',
      ),
      color: yellow,
    ),
    Icon(
      IconData(
        travelIcon,
        fontFamily: 'MaterialIcons',
      ),
      color: deeppink,
    ),
    Icon(
      IconData(
        shopIcon,
        fontFamily: 'MaterialIcons',
      ),
      color: lightblue,
    ),
  ];
}
