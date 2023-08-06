import 'package:cooler/Screens/wallet_screens/wallet_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/bottom_navigation_bar.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../../Widgets/text_widget.dart';
import '../group_screens/create_group_screen.dart';
import '../group_screens/my_group_screen.dart';
import '../settings_screen.dart';
import '../welcome_screen.dart';

class WalletWithdrawScreen extends ConsumerStatefulWidget {
  static const routeName = '/walletWithdraw';
  const WalletWithdrawScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WalletWithdrawScreen> createState() =>
      _WalletWithdrawScreenState();
}

class _WalletWithdrawScreenState extends ConsumerState<WalletWithdrawScreen> {
  final int _selectedIndex = 2;
  final List<Widget> pages = [
    const WelcomeScreen(),
    const MyGroupsScreen(),
    const WalletHomeScreen(),
    const SettingsScreen(),
  ];

  Widget buildBottomNavigationBar(int menuIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kBlueColor,
      unselectedItemColor: iconGreyColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedFontSize: 14,
      unselectedFontSize: 13,
      backgroundColor: white,
      // selectedLabelStyle: TextStyle(
      //   fontSize: 12.sp,
      //   fontWeight: FontWeight.w500,
      //   color: CustomColors.deepGoldColor,
      // ),
      // unselectedLabelStyle: TextStyle(
      //   fontSize: 12.sp,
      //   fontWeight: FontWeight.w500,
      //   color: CustomColors.grayBackgroundColor,
      // ),
      currentIndex: menuIndex,
      onTap: (i) {
        ref.read(indexProvider.notifier).state = i;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/home_icon.svg',
              color: iconGreyColor),
          label: 'Home',
          activeIcon: SizedBox(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/home_icon.svg',
                    color: kBlueColor),
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: UShapePainter(),
                  ),
                )
              ],
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/cooler_icon.svg'),
          label: 'Savings',
          activeIcon: SizedBox(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/cooler_icon.svg',
                    color: kBlueColor),
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: UShapePainter(),
                  ),
                )
              ],
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/wallet_icon.svg',
            // height: 20,
          ),
          label: 'Investments',
          activeIcon: SizedBox(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/wallet_icon.svg',
                    color: kBlueColor),
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: UShapePainter(),
                  ),
                )
              ],
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/settings_icon.svg',
              // height: 22.h,
              color: iconGreyColor),
          label: 'Wallet',
          activeIcon: SizedBox(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/settings_icon.svg',
                    color: kBlueColor),
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: UShapePainter(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    final menuIndex = ref.watch(indexProvider);
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(menuIndex),
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
              verticalSpacer(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: FormHeader('Amount')),
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
              ),
              verticalSpacer(35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    SizedBox(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();

                              // Navigator.of(context).pushReplacementNamed(
                              //     WalletHomeScreen.routeName);
                            },
                            child: const ColouredTextBox(title: 'Withdraw'))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
