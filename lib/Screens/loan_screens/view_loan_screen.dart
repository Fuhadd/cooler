import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'loan_center_screen.dart';

class ViewLoanScreen extends StatelessWidget {
  static const routeName = '/viewLoan';
  const ViewLoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'VIEW LOAN',
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
              Column(
                children: const [
                  ColumnLoanLargeTextBox(
                    text1: 'BALANCE',
                    text2: 'N15,000',
                    text3: 'MIN DUE N5,000',
                  )
                ],
              ),
              Column(
                children: [
                  const LargeStraightDoubleTextBox(
                      text2: 'MARCH 31, 2023', text1: 'N5,000'),
                  verticalSpacer(10),
                  const LargeStraightDoubleTextBox(
                      text2: 'APRIL 30, 2023', text1: 'N15,000'),
                  verticalSpacer(10),
                  const LargeStraightDoubleTextBox(
                      text2: 'MAY 31, 2023', text1: 'N7,000'),
                  verticalSpacer(10),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                LoanCenterScreen.routeName);
                          },
                          child: const ColouredTextBox(title: 'CONFIRM'))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
