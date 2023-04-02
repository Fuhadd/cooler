import 'package:flutter/material.dart';

import '../Helpers/colors.dart';

Widget FormHeader(String name) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Text(
      name,
      style: const TextStyle(
          fontSize: 18, color: kMainColor, fontWeight: FontWeight.bold),
    ),
  );
}
