// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cooler/Models/group_model.dart';
// import 'package:cooler/Screens/group_screens/select_group_type.dart';
// import 'package:cooler/Screens/group_screens/view_members_screen.dart';
// import 'package:cooler/Screens/welcome_screen.dart';
// import 'package:flutter/material.dart';

// import '../../Helpers/colors.dart';
// import '../../Helpers/constants.dart';
// import '../../Repositories/firestore_repository.dart';
// import '../../Widgets/texboxtbox_widgets.dart';
// import 'create_group_screen.dart';

// class GroupsScreen extends StatefulWidget {
//   static const routeName = '/groups';
//   const GroupsScreen({Key? key}) : super(key: key);

//   @override
//   State<GroupsScreen> createState() => _GroupsScreenState();
// }

// class _GroupsScreenState extends State<GroupsScreen> {
//   Stream<QuerySnapshot>? groups;
//   FirestoreRepository firestoreRepository = FirestoreRepository();
//   Widget GroupStreamScreen() {
//     return StreamBuilder(
//       stream: groups,
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         return snapshot.hasData
//             ? ListView.builder(
//                 //reverse: true,
//                 itemCount: snapshot.data?.docs.length ?? 6,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot ds = snapshot.data!.docs[index];
//                   print(ds.data());
//                   int? count = snapshot.data?.docs.length;
//                   return count == 0
//                       ? const Text('None')
//                       : FutureBuilder<Group?>(
//                           future: firestoreRepository.getGroupsbyid(ds.id),
//                           builder: (BuildContext context, snapshot) {
//                             if (snapshot.hasError) {
//                               return const Text("Something went wrong");
//                             }

//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               // print(ds.id);
//                               // print(snapshot.data);

//                               return const CircularProgressIndicator();
//                               // return buildChatShimmer();
//                             }

//                             if (snapshot.data == null) {
//                               print(snapshot.data);
//                               return const CircularProgressIndicator();
//                               // return buildChatShimmer();
//                             }

//                             if (snapshot.connectionState ==
//                                     ConnectionState.done &&
//                                 snapshot.hasData &&
//                                 snapshot.data != null) {
//                               final group = snapshot.data!;
//                               print(3);
//                               // final time = DateTime.now().difference(
//                               //     ds["lastMessageSendTime"].toDate());
//                               // print("This is time");
//                               // final convertedTime = (time.inSeconds);

//                               // // print(convertedTime.fromNow());
//                               // DateTime formattedDate =
//                               //     (ds["lastMessageSendTime"].toDate());
//                               // print(formattedDate);

//                               // String? finalTime;
//                               // if (convertedTime < 60) {
//                               //   finalTime = "${time.inSeconds} seconds ago";
//                               // } else if (convertedTime > 60 &&
//                               //     convertedTime < 3600) {
//                               //   finalTime = "${time.inMinutes} minutes ago";
//                               // } else if (convertedTime > 3600 &&
//                               //     convertedTime < 86400) {
//                               //   finalTime = "${time.inHours} hours ago";
//                               // } else if (convertedTime <= 24 &&
//                               //     convertedTime > 48) {
//                               //   finalTime = "yesterday";
//                               // } else {
//                               //   finalTime = "${time.inDays} days ago";
//                               // }
//                               // // final time = DateFormat.format(
//                               // //  ,
//                               // // );
//                               // print('object');
//                               // print(ds["lastMessage"]);
//                               // print(ds["unreadBy"] ?? '');
//                               // print(ds["unreadCount"] ?? 0);

//                               return GroupScreenBody(
//                                 noOfSavers: ds["noOfSavers"],
//                                 amount: ds["amount"],
//                                 startDate: ds["startDate"].toDate(),
//                                 groupName: ds["groupName"],
//                                 imageUrl: ds["imageUrl"],
//                                 status: ds["status"],
//                                 admins: ds["admins"],
//                                 members: ds["members"],
//                                 password: ds["password"],
//                                 pin: ds["pin"],
//                               );

//                               //DiscoverWidget(imageUrl: imageUrl, widget: widget);
//                             }
//                             print(4);
//                             return const CircularProgressIndicator();
//                             // return buildChatShimmer();
//                           });
//                 })
//             : const CircularProgressIndicator();
//         // buildChatShimmer();
//       },
//     );
//   }

//   getGroups() async {
//     groups = await firestoreRepository.getGroupIds();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     print(234);
//     getGroups();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: kMainColor),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: kMainColor),
//             onPressed: () => Navigator.of(context)
//                 .pushReplacementNamed(WelcomeScreen.routeName),
//           ),
//           backgroundColor: background,
//           centerTitle: true,
//           title: const Text(
//             'MY GROUPS',
//             style: TextStyle(
//                 fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: GroupStreamScreen(),
//       ),
//     );
//   }
// }

// class GroupScreenBody extends StatelessWidget {
//   final int noOfSavers;
//   final int amount;
//   final DateTime startDate;
//   final String groupName;
//   final String imageUrl;
//   final String status;
//   final List<dynamic?> admins;
//   final List<dynamic?> members;
//   final String? password;
//   final String? pin;
//   const GroupScreenBody({
//     required this.admins,
//     required this.amount,
//     required this.groupName,
//     required this.imageUrl,
//     required this.members,
//     required this.noOfSavers,
//     this.password,
//     this.pin,
//     required this.startDate,
//     required this.status,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             children: const [
//               SmallSingleRightTextBox(title: 'SEARCH'),
//             ],
//           ),
//           Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context)
//                       .pushReplacementNamed(ViewMembersScreen.routeName);
//                 },
//                 child: const GeneralLargeTextBox(
//                   name: 'TARGET IT',
//                   isImage: true,
//                   imageUrl: 'assets/images/target_logo.png',
//                 ),
//               ),
//               verticalSpacer(10),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context)
//                       .pushReplacementNamed(ViewMembersScreen.routeName);
//                 },
//                 child: const GeneralLargeTextBox(
//                   name: 'CYBER GROUP',
//                   isImage: true,
//                   imageUrl: 'assets/images/cyber_group.png',
//                 ),
//               ),
//               verticalSpacer(10),
//             ],
//           ),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                       child: GestureDetector(
//                           onTap: () {
//                             Navigator.of(context)
//                                 .pushNamed(SelectGroupTypeScreen.routeName);
//                           },
//                           child: const ColouredTextBox(title: 'JOIN'))),
//                   horizontalSpacer(10),
//                   Expanded(
//                       child: GestureDetector(
//                           onTap: () {
//                             Navigator.of(context)
//                                 .pushNamed(CreateGroupScreen.routeName);
//                           },
//                           child: const ColouredTextBox(title: 'CREATE'))),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
