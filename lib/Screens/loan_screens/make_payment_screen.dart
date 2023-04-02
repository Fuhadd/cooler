import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../../Widgets/text_widget.dart';
import '../group_screens/create_group_screen.dart';
import 'loan_center_screen.dart';

class MakePaymentScreen extends StatelessWidget {
  static const routeName = '/makePayment';
  const MakePaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'MAKE PAYMENT',
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
                  children: const [
                    ColumnLoanLargeTextBox(
                      text1: 'BALANCE',
                      text2: 'N12,000',
                      text3: 'MIN DUE N5,000',
                    ),
                  ],
                ),
                verticalSpacer(40),
                Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: FormHeader('LOAN AMOUNT')),
                    verticalSpacer(10),
                    CustomTextField(
                      name: 'loanAmount',
                      hint: 'Enter Loan Amount ......',
                      isdigit: true,
                    ),
                    // const SmallSingleLeftTextBox(title: 'N5,000'),
                    verticalSpacer(15),
                    const PaymentDoubleTextBox(
                        imageUrl: 'assets/images/paystack_logo.png',
                        title: 'PAYSTACK'),
                    verticalSpacer(15),
                    const PaymentDoubleTextBox(
                        imageUrl: 'assets/images/flutterwave_logo.png',
                        title: 'FLUTTERWAVE'),
                    verticalSpacer(15),
                    const PaymentDoubleTextBox(
                        imageUrl: 'assets/images/interswitch_logo.png',
                        title: 'INTERSWITCH'),
                    verticalSpacer(15),
                  ],
                ),
                verticalSpacer(30),
                Column(
                  children: [
                    SizedBox(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                  LoanCenterScreen.routeName);
                            },
                            child:
                                const ColouredTextBox(title: 'MAKE PAYMENT'))),
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
