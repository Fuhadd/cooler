// import 'package:cooler/Screens/group_screens/my_group_screen.dart';
// import 'package:cooler/Screens/welcome_screen.dart';
// import 'package:flutter/material.dart';

// import '../Screens/settings_screen.dart';
// import '../Screens/wallet_screens/wallet_home_screen.dart';

// class HomeScreen extends StatefulWidget {
//   static const routeName = '/home';
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     const HomeScreen(),
//     const MyGroupsScreen(),
//     const WalletHomeScreen(),
//     const SettingsScreen(),
//   ];

//   void _onItemTapped(int index) {
//     // setState(() {
//     //   _selectedIndex = index;
//     // });
//   }

//   Widget buildBottomNavigationBar(int selectedIndex) {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       type: BottomNavigationBarType.fixed,
//       items: [
//         BottomNavigationBarItem(
//           icon: SmallTextLetterBox(
//             isactive: selectedIndex == 0 ? true : false,
//             letter: 'H',
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: SmallTextLetterBox(
//             isactive: selectedIndex == 1 ? true : false,
//             letter: 'C',
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: SmallTextLetterBox(
//             isactive: selectedIndex == 2 ? true : false,
//             letter: 'W',
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: SmallTextLetterBox(
//             isactive: selectedIndex == 3 ? true : false,
//             letter: 'S',
//           ),
//           label: '',
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _pages.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
//     );
//   }
// }
