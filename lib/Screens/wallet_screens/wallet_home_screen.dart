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
        // bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
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
                // Column(
                //   children: const [
                //     ColumnTextBox(
                //       text1: 'BALANCE',
                //       text2: '\$200',
                //     )
                //   ],
                // ),
                verticalSpacer(40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      const LargeDoubleTextBox(
                        text2: 'Contribution',
                        text1: '\$100',
                        icon: Icons.trending_up,
                        iconColor: kLemonColor,
                      ),
                      verticalSpacer(10),
                      const LargeDoubleTextBox(
                        text2: 'Contribution',
                        text1: '\$100',
                        icon: Icons.trending_up,
                        iconColor: kLemonColor,
                      ),
                      verticalSpacer(10),
                      LargeDoubleTextBox(
                        text2: 'Withdrawal',
                        text1: '\$40',
                        icon: Icons.trending_down,
                        iconColor: redColor,
                      ),
                      verticalSpacer(10),
                    ],
                  ),
                ),
                verticalSpacer(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      // GestureDetector(
                      //     onTap: () async {
                      //       Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //           builder: ((context) =>
                      //               MyInviteScreen(currentUser: currentUser))));
                      //     },
                      //     child: const ColouredTextBox(title: 'INVITES')),

                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        WalletTransferScreen.routeName);
                                  },
                                  child: const ColouredTextBox(
                                      title: 'Transfer'))),
                          // horizontalSpacer(10),
                          // Expanded(
                          //     child: GestureDetector(
                          //         onTap: () {
                          //           Navigator.of(context)
                          //               .pushNamed(CreateGroupScreen.routeName);
                          //         },
                          //         child: const ColouredTextBox(title: 'CREATE'))),
                        ],
                      ),

                      GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(WalletWithdrawScreen.routeName);
                          },
                          child:
                              const ColouredOutlineTextBox(title: 'Withdraw'))
                      // verticalSpacer(20),
                    ],
                  ),
                ),
                // verticalSpacer(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
