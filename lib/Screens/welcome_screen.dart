import 'package:cooler/Repositories/firestore_repository.dart';
import 'package:cooler/Screens/settings_screen.dart';
import 'package:cooler/Screens/wallet_screens/wallet_home_screen.dart';
import 'package:flutter/material.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/user_model.dart';
import '../Repositories/user_repository.dart';
import '../Widgets/texboxtbox_widgets.dart';
import 'group_screens/my_group_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // @override
  final int _selectedIndex = 0;
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
  void initState() {
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    super.initState();
  }

  AppUser? currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: currentUser == null
          ? const CircularProgressIndicator()
          : Scaffold(
              // drawer: const CustomNavigationDrawer(
              //   pageIndex: 1,
              // ),
              bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
              appBar: AppBar(
                elevation: 0,
                iconTheme: const IconThemeData(color: kMainColor),
                backgroundColor: background,
                centerTitle: true,
                title: Text(
                  'WELCOME ${(currentUser!.firstName).toUpperCase()}',
                  style: const TextStyle(
                      fontSize: 21,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(currentUser!.imageUrl),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30.0, top: 70, bottom: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                const SizedBox(
                                  height: 250,
                                  width: 250,
                                  child: RotationTransition(
                                    turns: AlwaysStoppedAnimation(240 / 360),
                                    child: CircularProgressIndicator(
                                      value: 0.5,
                                      strokeWidth: 70,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kBlueColor),
                                      color: kBlueColor,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'ACCRUED',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: kMainColor,
                                        ),
                                      ),
                                      verticalSpacer(5),
                                      Text(
                                        '\$${currentUser!.amountAccrued}',
                                        style: const TextStyle(
                                            fontSize: 30,
                                            color: kMainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpacer(100),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              FirestoreRepository().getUsersInGroup(
                                  ['Zqhk3DGSz3NbZZvnOCOnlLikbpY2']);
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         const WalletHomeScreen(),
                              //   ),
                              // );
                            },
                            child: LargeTextBox(
                              lagging: '\$${currentUser!.walletBalance}',
                              leading: 'WALLLET',
                            ),
                          ),
                          // verticalSpacer(16),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.of(context).pushReplacement(
                          //       MaterialPageRoute(
                          //         builder: (context) => const LoanCenterScreen(),
                          //       ),
                          //     );
                          //   },
                          //   child: const LargeTextBox(
                          //     lagging: '\$200',
                          //     leading: 'LOANS',
                          //   ),
                          // ),
                          verticalSpacer(20),
                          GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pushReplacementNamed(
                                    MyGroupsScreen.routeName);
                              },
                              child: const LargeColouredTextBox(
                                  title: 'COO0LERS')),
                          verticalSpacer(30),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}

class SmallTextLetterBox extends StatelessWidget {
  const SmallTextLetterBox({
    required this.isactive,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final IconData? icon;
  final bool isactive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: isactive ? kMainColor : white,
          border: Border.all(color: kMainColor)),
      child: Center(
          child: Icon(
        icon,
        color: isactive ? white : kMainColor,
      )),
    );
  }
}
