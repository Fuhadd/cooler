import 'package:cooler/Screens/wallet_screens/wallet_home_screen.dart';
import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../../Widgets/text_widget.dart';
import '../group_screens/create_group_screen.dart';
import '../group_screens/my_group_screen.dart';
import '../settings_screen.dart';
import '../welcome_screen.dart';

class WalletWithdrawScreen extends StatefulWidget {
  static const routeName = '/walletWithdraw';
  const WalletWithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WalletWithdrawScreen> createState() => _WalletWithdrawScreenState();
}

class _WalletWithdrawScreenState extends State<WalletWithdrawScreen> {
  final int _selectedIndex = 2;
  final List<Widget> _pages = [
    const WelcomeScreen(),
    const MyGroupsScreen(),
    const WalletHomeScreen(),
    const SettingsScreen(),
  ];

  Widget buildBottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _pages[index]),
        );
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SmallTextLetterBox(
            isactive: selectedIndex == 0 ? true : false,
            icon: Icons.home,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SmallTextLetterBox(
            isactive: selectedIndex == 1 ? true : false,
            icon: Icons.group,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SmallTextLetterBox(
            isactive: selectedIndex == 2 ? true : false,
            icon: Icons.wallet,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SmallTextLetterBox(
            isactive: selectedIndex == 3 ? true : false,
            icon: Icons.settings,
          ),
          label: '',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kMainColor),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'WALLET',
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
                    ColumnLargeTextBox(
                      text1: 'BALANCE',
                      text2: '\$200',
                    )
                  ],
                ),
                verticalSpacer(40),
                Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: FormHeader('AMOUNT')),
                    verticalSpacer(10),
                    CustomTextField(
                      name: 'amount',
                      hint: 'Enter Amount ......',
                      isdigit: true,
                    ),
                    // const SmallSingleLeftTextBox(title: 'N10,000'),
                    verticalSpacer(15),
                    // const PaymentBoxDoubleTextBox(
                    //     imageUrl: 'assets/images/GTBank_logo.png',
                    //     title: 'GTB'),
                    verticalSpacer(15),
                    const PaymentBoxDoubleTextBox(
                        imageUrl: 'assets/images/chase_logo.png',
                        title: 'CHASE'),
                    // verticalSpacer(15),
                  ],
                ),
                verticalSpacer(35),
                Column(
                  children: [
                    SizedBox(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                  WalletHomeScreen.routeName);
                            },
                            child: const ColouredTextBox(title: 'WITHDRAW'))),
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
