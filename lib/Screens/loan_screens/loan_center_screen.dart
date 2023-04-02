import 'package:cooler/Screens/loan_screens/view_loan_screen.dart';
import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/navigation_drawer.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'loan_apply_screen.dart';
import 'make_payment_screen.dart';

class LoanCenterScreen extends StatelessWidget {
  static const routeName = '/loanCenter';
  const LoanCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: const CustomNavigationDrawer(
          pageIndex: 3,
        ),
        appBar: AppBar(
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'LOAN CENTER',
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
                  ColumnVeryLargeTextBox(
                    text1: 'BALANCE',
                    text2: 'N200,000',
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(LoanApplyScreen.routeName);
                          },
                          child: const ColouredTextBox(title: 'APPLY'))),
                  verticalSpacer(20),
                  SizedBox(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ViewLoanScreen.routeName);
                          },
                          child: const ColouredTextBox(title: 'VIEW LOAN'))),
                  verticalSpacer(20),
                  SizedBox(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(MakePaymentScreen.routeName);
                          },
                          child: const ColouredTextBox(title: 'MAKE PAYMENT'))),
                  verticalSpacer(50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
