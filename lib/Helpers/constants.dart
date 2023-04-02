import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

Widget horizontalSpacer(double width) {
  return SizedBox(
    width: width,
  );
}

Widget verticalSpacer(double height) {
  return SizedBox(
    height: height,
  );
}

PreferredSizeWidget CustomAppar(
  BuildContext context,
  String appBarTitle,
) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black, size: 35),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
      appBarTitle,
      style:
          Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
    ),
  );
}

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

Divider SideDivider() {
  return const Divider(
    endIndent: 15,
    indent: 15,
    color: Colors.white70,
  );
}

Divider mainDivider() {
  return const Divider(
    // endIndent: 0,
    // indent: 0,
    color: Colors.black87,
  );
}

var options = const [
  FormBuilderFieldOption(
    value: 'Monday',
    child: Text(
      'M',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderFieldOption(
    value: 'Tuesday',
    child: Text(
      'T',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderFieldOption(
    value: 'Wednesday',
    child: Text(
      'W',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderFieldOption(
    value: 'Thursday',
    child: Text(
      'Th',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
  FormBuilderFieldOption(
    value: 'Friday',
    child: Text(
      'F',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  ),
];
