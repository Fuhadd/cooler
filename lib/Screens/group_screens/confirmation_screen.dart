import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../welcome_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  static const routeName = '/confirm';
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'CONFIRMATION',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: kMainColor,
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 60,
                            width: 60,
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/target_logo.png',
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            )

                            // Icon(
                            //   FontAwesomeIcons.userGroup,
                            //   size: 45,
                            //   color: kMainColor,
                            // ),
                            ),
                        verticalSpacer(10),
                        const Text(
                          'TARGET IT',
                          style: TextStyle(
                              fontSize: 18,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        verticalSpacer(30),
                        Column(
                          children: [
                            const Text(
                              'CONTRIBUTION',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: kMainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            verticalSpacer(10),
                            const Text(
                              '\$100',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: kMainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        verticalSpacer(30),
                        const Text(
                          'FEBRUARY 1, 2023',
                          style: TextStyle(
                              fontSize: 18,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        verticalSpacer(10),
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpacer(40),
              Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(WelcomeScreen.routeName);
                          },
                          child: const ColouredTextBox(title: 'DONE'))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
