// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../Screens/group_screens/my_group_screen.dart';
// import '../Screens/welcome_screen.dart';

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late int _currentIndex;
//   late List<Widget> _children;

//   @override
//   void initState() {
//     _currentIndex = 0;
//     _children = [
//       const WelcomeScreen(),
//       const MyGroupsScreen(),
//       Container(
//         alignment: Alignment.center,
//         child: const Text('C'),
//       ),
//       Container(
//         alignment: Alignment.center,
//         child: const Text('D'),
//       ),
//     ];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//         tabBar: CupertinoTabBar(
//           currentIndex: _currentIndex,
//           onTap: onTabTapped,
//           items: [
//             BottomNavigationBarItem(
//               icon: SmallTextLetterBox(
//                 isactive: _currentIndex == 0 ? true : false,
//                 letter: 'H',
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SmallTextLetterBox(
//                 isactive: _currentIndex == 1 ? true : false,
//                 letter: 'C',
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SmallTextLetterBox(
//                 isactive: _currentIndex == 2 ? true : false,
//                 letter: 'W',
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: SmallTextLetterBox(
//                 isactive: _currentIndex == 3 ? true : false,
//                 letter: 'S',
//               ),
//               label: '',
//             ),
//           ],
//         ),
//         tabBuilder: (BuildContext context, int index) {
//           return CupertinoTabView(
//             builder: (BuildContext context) {
//               return SafeArea(
//                 top: false,
//                 bottom: false,
//                 child: CupertinoApp(
//                   home: CupertinoPageScaffold(
//                     resizeToAvoidBottomInset: false,
//                     child: _children[_currentIndex],
//                   ),
//                 ),
//               );
//             },
//           );
//         });
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }
