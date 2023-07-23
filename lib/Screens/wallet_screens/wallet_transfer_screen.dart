import 'package:cooler/Screens/wallet_screens/wallet_home_screen.dart';
import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../../Widgets/text_widget.dart';
import '../group_screens/my_group_screen.dart';
import '../settings_screen.dart';
import '../welcome_screen.dart';

class WalletTransferScreen extends StatefulWidget {
  static const routeName = '/walletTransfer';
  const WalletTransferScreen({Key? key}) : super(key: key);

  @override
  State<WalletTransferScreen> createState() => _WalletTransferScreenState();
}

class _WalletTransferScreenState extends State<WalletTransferScreen> {
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
        // bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: kMainColor),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'Wallet',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            child: Column(
              children: [
                Container(
                  // height: 75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: blueBackground.withOpacity(0.08),
                  ),
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                          child: ColumnTextBox(
                        text1: 'Balance',
                        text2: '\$200',
                      ))),
                ),
                verticalSpacer(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: FormHeader('Amount')),
                      verticalSpacer(10),
                      const SmallSingleLeftTextBox(title: '\$400'),
                      verticalSpacer(25),
                      const PaymentDoubleTextBox(
                          imageUrl: 'assets/images/chase_logo.png',
                          title: 'Chase'),
                      verticalSpacer(15),
                      const PaymentDoubleTextBox(
                          imageUrl: 'assets/images/capital.png',
                          title: 'Capital One'),
                      verticalSpacer(15),
                      // const PaymentDoubleTextBox(
                      //     imageUrl: 'assets/images/interswitch_logo.png',
                      //     title: 'INTERSWITCH'),
                      // verticalSpacer(15),
                    ],
                  ),
                ),
                verticalSpacer(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      SizedBox(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    WalletHomeScreen.routeName);
                              },
                              child: const ColouredTextBox(title: 'Transfer'))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
