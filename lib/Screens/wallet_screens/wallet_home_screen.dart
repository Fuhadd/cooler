import 'package:cooler/Screens/wallet_screens/wallet_transfer_screen.dart';
import 'package:cooler/Screens/wallet_screens/wallet_withdraw_screen.dart';
import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../group_screens/my_group_screen.dart';
import '../settings_screen.dart';
import '../welcome_screen.dart';

class WalletHomeScreen extends StatefulWidget {
  static const routeName = '/walletHome';
  const WalletHomeScreen({Key? key}) : super(key: key);

  @override
  State<WalletHomeScreen> createState() => _WalletHomeScreenState();
}

class _WalletHomeScreenState extends State<WalletHomeScreen> {
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
        // drawer: const CustomNavigationDrawer(
        //   pageIndex: 2,
        // ),
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
        body: screenHeight > 780
            ? Padding(
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
                    Column(
                      children: [
                        const LargeDoubleTextBox(
                            text2: 'CONTRIBUTION', text1: '\$100'),
                        verticalSpacer(10),
                        const LargeDoubleTextBox(
                            text2: 'CONTRIBUTION', text1: '\$100'),
                        verticalSpacer(10),
                        const LargeDoubleTextBox(
                            text2: 'WITHDRAWAL', text1: '\$40'),
                        verticalSpacer(10),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      WalletTransferScreen.routeName);
                                },
                                child:
                                    const ColouredTextBox(title: 'TRANSFER'))),
                        verticalSpacer(20),
                        SizedBox(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      WalletWithdrawScreen.routeName);
                                },
                                child:
                                    const ColouredTextBox(title: 'WITHDRAW'))),
                      ],
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
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
                          const LargeDoubleTextBox(
                              text2: 'CONTRIBUTION', text1: '\$100'),
                          verticalSpacer(10),
                          const LargeDoubleTextBox(
                              text2: 'CONTRIBUTION', text1: '\$100'),
                          verticalSpacer(10),
                          const LargeDoubleTextBox(
                              text2: 'WITHDRAWAL', text1: '\$40'),
                          verticalSpacer(10),
                        ],
                      ),
                      verticalSpacer(30),
                      Column(
                        children: [
                          SizedBox(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        WalletTransferScreen.routeName);
                                  },
                                  child: const ColouredTextBox(
                                      title: 'TRANSFER'))),
                          verticalSpacer(20),
                          SizedBox(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        WalletWithdrawScreen.routeName);
                                  },
                                  child: const ColouredTextBox(
                                      title: 'WITHDRAW'))),
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
