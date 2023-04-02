// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cooler/Models/group_model.dart';
// import 'package:cooler/Screens/group_screens/my_invites_screen.dart';
// import 'package:cooler/Screens/group_screens/select_group_type.dart';
// import 'package:cooler/Screens/group_screens/view_members_backup.dart';
// import 'package:cooler/Screens/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// import '../../Helpers/colors.dart';
// import '../../Helpers/constants.dart';
// import '../../Models/user_model.dart';
// import '../../Repositories/firestore_repository.dart';
// import '../../Repositories/user_repository.dart';
// import '../../Widgets/texboxtbox_widgets.dart';
// import 'create_group_screen.dart';

// class GroupsScreen extends StatefulWidget {
//   static const routeName = '/groups';
//   const GroupsScreen({Key? key}) : super(key: key);

//   @override
//   State<GroupsScreen> createState() => _GroupsScreenState();
// }

// class _GroupsScreenState extends State<GroupsScreen> {
//   late AppUser? currentUser;
//   Stream<QuerySnapshot>? groups;
//   FirestoreRepository firestoreRepository = FirestoreRepository();
//   Widget GroupStreamScreen() {
//     return StreamBuilder(
//       stream: groups,
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         return snapshot.hasData
//             ? GroupScreenBody(
//                 currentUser: currentUser!,
//                 snapshot: snapshot,
//                 firestoreRepository: firestoreRepository,
//               )
//             : Lottie.asset(
//                 'assets/images/big_shimmer.json',
//                 height: MediaQuery.of(context).size.height,
//                 width: double.infinity,
//               );
//       },
//     );
//   }

//   getGroups() async {
//     groups = await firestoreRepository.getPublicGroupIds();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getGroups();
//     UserRepository().fetchCurrentUser().then((value) {
//       setState(() {
//         currentUser = value;
//       });
//     });

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
//   final AsyncSnapshot<QuerySnapshot> snapshot;
//   final FirestoreRepository firestoreRepository;
//   final AppUser currentUser;

//   const GroupScreenBody({
//     required this.firestoreRepository,
//     required this.snapshot,
//     required this.currentUser,
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
//             children: [
//               CustomTextField(
//                 name: 'groupPin',
//                 hint: 'SEARCH',
//                 isdigit: false,
//               ),
//             ],
//           ),
//           verticalSpacer(25),
//           Expanded(
//             child: SizedBox(
//               child: ListView.builder(
//                   itemCount: snapshot.data?.docs.length ?? 6,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot ds = snapshot.data!.docs[index];

//                     int? count = snapshot.data?.docs.length;
//                     return count == 0
//                         ? const Text('None')
//                         : FutureBuilder<Group?>(
//                             future: firestoreRepository.getGroupsbyid(ds.id),
//                             builder: (BuildContext context, snapshot) {
//                               if (snapshot.hasError) {
//                                 return const Text("Something went wrong");
//                               }

//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(top: 10.0),
//                                   child: Lottie.asset(
//                                     'assets/images/shimmer.json',
//                                     height: 100,
//                                     width: double.infinity,
//                                   ),
//                                 );
//                               }

//                               if (snapshot.data == null) {
//                                 return const CircularProgressIndicator();
//                               }

//                               if (snapshot.connectionState ==
//                                       ConnectionState.done &&
//                                   snapshot.hasData &&
//                                   snapshot.data != null) {
//                                 final group = snapshot.data!;

//                                 final time = DateTime.now()
//                                     .difference(ds["startDate"].toDate());

//                                 final convertedTime = (time.inSeconds * (-1));

//                                 // print(convertedTime.fromNow());
//                                 DateTime formattedDate =
//                                     (ds["startDate"].toDate());

//                                 String? finalTime;
//                                 if (convertedTime < 60) {
//                                   finalTime =
//                                       "${time.inSeconds * (-1)} seconds";
//                                 } else if (convertedTime > 60 &&
//                                     convertedTime < 3600) {
//                                   finalTime =
//                                       "${time.inMinutes * (-1)} minutes";
//                                 } else if (convertedTime > 3600 &&
//                                     convertedTime < 86400) {
//                                   finalTime = "${time.inHours * (-1)} hours";
//                                 } else if (convertedTime <= 24 &&
//                                     convertedTime > 48) {
//                                   finalTime = "yesterday";
//                                 } else {
//                                   finalTime = "${time.inDays * (-1)} days";
//                                 }

//                                 return Padding(
//                                   padding: const EdgeInsets.only(top: 10.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (builder) =>
//                                                 ViewGroupsMembersScreen(
//                                                     button: 'LEAVE',
//                                                     group: group)),
//                                       );
//                                     },
//                                     // noOfSavers: ds["noOfSavers"],
//                                     //                     amount: ds["amount"],
//                                     //                     startDate: ds["startDate"].toDate(),
//                                     //                     groupName: ds["groupName"],
//                                     //                     imageUrl: ds["imageUrl"],
//                                     //                     status: ds["status"],
//                                     //                     admins: ds["admins"],
//                                     //                     members: ds["members"],
//                                     //                     password: ds["password"],
//                                     //                     pin: ds["pin"],
//                                     child: convertedTime > 0
//                                         ? GeneralTimeLargeTextBox(
//                                             name: ds["groupName"],
//                                             time: finalTime,
//                                             isImage: true,
//                                             imageUrl: ds["imageUrl"],
//                                           )
//                                         : GeneralLargeTextBox(
//                                             name: ds["groupName"],
//                                             isImage: true,
//                                             imageUrl: ds["imageUrl"],
//                                           ),
//                                   ),
//                                 );
//                               }

//                               return Expanded(
//                                   child: Lottie.asset(
//                                 'assets/images/big_shimmer.json',
//                                 height: 100,
//                                 width: double.infinity,
//                               ));
//                             });
//                   }),
//             ),
//           ),
//           verticalSpacer(25),
//           Column(
//             children: [
//               GestureDetector(
//                   onTap: () async {
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(
//                         builder: ((context) =>
//                             MyInviteScreen(currentUser: currentUser))));
//                   },
//                   child: const ColouredTextBox(title: 'INVITES')),
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
