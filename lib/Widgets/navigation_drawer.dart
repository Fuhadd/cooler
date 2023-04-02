import 'package:cooler/Screens/wallet_screens/wallet_home_screen.dart';
import 'package:flutter/material.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/user_model.dart';
import '../Repositories/user_repository.dart';
import '../Screens/auth_screens/login_screen.dart';
import '../Screens/welcome_screen.dart';

class CustomNavigationDrawer extends StatefulWidget {
  final int pageIndex;
  const CustomNavigationDrawer({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  late AppUser? currentUser;

  @override
  void initState() {
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildMenuItems(context, widget.pageIndex),
        ],
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/Logo.png'))),
  );
}

class SideMenus extends StatelessWidget {
  SideMenus({
    this.padding = 16,
    this.color = Colors.white,
    required this.onClick,
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String title;
  double padding;
  Color color;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: padding),
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.w900, color: color),
      ),
      onTap: onClick,
    );
  }
}

Widget buildMenuItems(BuildContext context, int pageIndex) {
  return Padding(
    padding: const EdgeInsets.only(left: 25.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SideDivider(),
        SideMenus(
            color: pageIndex == 1 ? kMainColor : Colors.black,
            icon: Icons.home_outlined,
            title: 'HOME',
            onClick: () {
              Navigator.of(context)
                  .pushReplacementNamed(WelcomeScreen.routeName);
            }),
        SideDivider(),
        SideMenus(
            color: pageIndex == 2 ? kMainColor : Colors.black,
            icon: Icons.nature_people_outlined,
            title: 'Wallet',
            onClick: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const WalletHomeScreen(),
                ),
              );
            }),
        // SideDivider(),
        // SideMenus(
        //     color: pageIndex == 3 ? kMainColor : Colors.black,
        //     icon: Icons.nature_people_outlined,
        //     title: 'Loan',
        //     onClick: () {
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => const LoanCenterScreen(),
        //         ),
        //       );
        //     }),
        SideDivider(),
        SideMenus(
            color: pageIndex == 4 ? kMainColor : Colors.black,
            icon: Icons.nature_people_outlined,
            title: 'Logout',
            onClick: () {
              UserRepository().logOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }),
      ],
    ),
  );
}
