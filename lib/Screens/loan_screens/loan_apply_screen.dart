import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../../Widgets/text_widget.dart';
import '../group_screens/create_group_screen.dart';
import 'loan_center_screen.dart';

class LoanApplyScreen extends StatelessWidget {
  static const routeName = '/loanApply';
  const LoanApplyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'APPLY',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30, right: 30.0, top: 50, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormHeader('LOAN AMOUNT'),
                    verticalSpacer(10),
                    CustomTextField(
                      name: 'loanAmount',
                      hint: 'EnterLoan Amount ......',
                      isdigit: true,
                    ),
                    //SmallSingleLeftTextBox(title: 'N50,000'),
                    verticalSpacer(30),
                    FormHeader('PASSWORD'),
                    verticalSpacer(10),
                    CustomTextField(
                      name: 'password',
                      hint: 'Enter Password ......',
                      isdigit: false,
                    ),
                    verticalSpacer(30),
                    FormHeader('PIN'),
                    verticalSpacer(10),
                    CustomTextField(
                      name: 'pin',
                      hint: 'Enter Pin......',
                      isdigit: true,
                    ),
                    verticalSpacer(40),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
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
      ),
    );
  }
}
