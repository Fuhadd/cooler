import 'package:cooler/Helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Helpers/constants.dart';

class NoContentScreen extends StatelessWidget {
  const NoContentScreen({
    Key? key,
    required this.mainText,
    required this.subTitle,
  }) : super(key: key);

  final String mainText;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mainText,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: kMainColor),
        ),
        verticalSpacer(10),
        Text(
          subTitle,
          style: const TextStyle(color: Colors.grey),
        ),
        verticalSpacer(10),
        Lottie.asset(
          'assets/images/no_content.json',
          height: 100,
          width: double.infinity,
        )
      ],
    ));
  }
}
