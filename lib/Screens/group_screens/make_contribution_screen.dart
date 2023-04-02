// import 'package:cooler/Models/group_model.dart';
// import 'package:cooler/Screens/group_screens/groups_screen.dart';
// import 'package:cooler/Screens/group_screens/view_members_screen.dart';
// import 'package:flutter/material.dart';

// import '../../Helpers/colors.dart';
// import '../../Helpers/constants.dart';
// import '../../Widgets/texboxtbox_widgets.dart';
// import '../../Widgets/text_widget.dart';

// class ContributeScreen extends StatelessWidget {
//   final Group group;
//   static const routeName = '/contribute';
//   const ContributeScreen({required this.group, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: kMainColor),
//             onPressed: () => Navigator.of(context)
//                 .pushReplacementNamed(GroupsScreen.routeName),
//           ),
//           backgroundColor: background,
//           centerTitle: true,
//           title: const Text(
//             'MAKE CONTRIBUTION',
//             style: TextStyle(
//                 fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: Padding(
//           padding:
//               const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: const [
//                   ColumnLargeTextBox(
//                     text1: 'BALANCE',
//                     text2: '\$200',
//                   )
//                 ],
//               ),
//               verticalSpacer(40),
//               Column(
//                 children: [
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: FormHeader(group.groupName)),
//                   verticalSpacer(10),
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: FormHeader('AMOUNT')),
//                   verticalSpacer(10),
//                   // const CustomTextField(
//                   //   name: 'amount',
//                   //   hint: 'Enter Amount ......',
//                   //   isdigit: true,
//                   // ),
//                   SmallSingleLeftTextBox(title: '\$${group.amount}'),
//                   // verticalSpacer(15),
//                   // const PaymentBoxDoubleTextBox(
//                   //     imageUrl: 'assets/images/GTBank_logo.png', title: 'GTB'),
//                   verticalSpacer(15),
//                   const PaymentBoxDoubleTextBox(
//                       imageUrl: 'assets/images/stripe_logo.png',
//                       title: 'STRIPE'),
//                   // verticalSpacer(15),
//                 ],
//               ),
//               verticalSpacer(35),
//               Column(
//                 children: [
//                   SizedBox(
//                       child: GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pushReplacementNamed(
//                                 ViewMembersScreen.routeName);
//                           },
//                           child: const ColouredTextBox(title: 'CONTRIBUTE'))),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
