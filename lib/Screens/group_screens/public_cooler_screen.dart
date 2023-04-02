import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooler/Models/group_model.dart';
import 'package:cooler/Screens/group_screens/view_members_screen.dart';
import 'package:cooler/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Models/user_model.dart';
import '../../Repositories/firestore_repository.dart';
import '../../Repositories/user_repository.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'create_group_screen.dart';

class PublicCoolerScreen extends StatefulWidget {
  static const routeName = '/publiccooler';
  const PublicCoolerScreen({Key? key}) : super(key: key);

  @override
  State<PublicCoolerScreen> createState() => _PublicCoolerScreenState();
}

class _PublicCoolerScreenState extends State<PublicCoolerScreen> {
  late AppUser? currentUser;
  Stream<QuerySnapshot>? groups;
  Group? currentGroup;
  int? count;
  FirestoreRepository firestoreRepository = FirestoreRepository();
  Widget GroupStreamScreen() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? GroupScreenBody(
                currentUser: currentUser!,
                snapshot: snapshot,
                firestoreRepository: firestoreRepository,
              )
            : Lottie.asset(
                'assets/images/big_shimmer.json',
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
              );
      },
    );
  }

  getGroups() async {
    groups = await firestoreRepository.getPublicGroupIds();
    setState(() {});
  }

  @override
  void initState() {
    getGroups();
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kMainColor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kMainColor),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(WelcomeScreen.routeName),
          ),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'JOIN GROUP',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: GroupStreamScreen(),
      ),
    );
  }
}

class GroupScreenBody extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final FirestoreRepository firestoreRepository;
  final AppUser currentUser;

  const GroupScreenBody({
    required this.firestoreRepository,
    required this.snapshot,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CustomTextField(
                name: 'groupPin',
                hint: 'SEARCH',
                isdigit: false,
              ),
            ],
          ),
          verticalSpacer(25),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];

                    int? count = snapshot.data?.docs.length;
                    return count == 0
                        ? const Text('None')
                        : FutureBuilder<Group?>(
                            future:
                                firestoreRepository.getGroupsbyidMinusCurrent(
                                    ds.id, currentUser.id!),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text("Something went wrong");
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Lottie.asset(
                                    'assets/images/shimmer.json',
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                );
                              }

                              if (snapshot.data == null) {
                                return Container();
                              }

                              if (snapshot.data == null && index == count) {
                                return const Text('None');
                              }

                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData &&
                                  snapshot.data != null) {
                                final group = snapshot.data!;

                                final time = DateTime.now()
                                    .difference(ds["startDate"].toDate());

                                final convertedTime = (time.inSeconds * (-1));

                                // print(convertedTime.fromNow());
                                DateTime formattedDate =
                                    (ds["startDate"].toDate());

                                String? finalTime;
                                if (convertedTime < 60) {
                                  finalTime =
                                      "${time.inSeconds * (-1)} seconds";
                                } else if (convertedTime > 60 &&
                                    convertedTime < 3600) {
                                  finalTime =
                                      "${time.inMinutes * (-1)} minutes";
                                } else if (convertedTime > 3600 &&
                                    convertedTime < 86400) {
                                  finalTime = "${time.inHours * (-1)} hours";
                                } else if (convertedTime <= 24 &&
                                    convertedTime > 48) {
                                  finalTime = "yesterday";
                                } else {
                                  finalTime = "${time.inDays * (-1)} days";
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ViewGroupMembersScreen(
                                                    showInviteColumn: false,
                                                    button: 'Join',
                                                    group: group)),
                                      );
                                    },
                                    // noOfSavers: ds["noOfSavers"],
                                    //                     amount: ds["amount"],
                                    //                     startDate: ds["startDate"].toDate(),
                                    //                     groupName: ds["groupName"],
                                    //                     imageUrl: ds["imageUrl"],
                                    //                     status: ds["status"],
                                    //                     admins: ds["admins"],
                                    //                     members: ds["members"],
                                    //                     password: ds["password"],
                                    //                     pin: ds["pin"],
                                    child: convertedTime > 0
                                        ? GeneralTimeLargeTextBox(
                                            name: ds["groupName"],
                                            time: finalTime,
                                            isImage: true,
                                            isUrlImage: true,
                                            imageUrl: ds["imageUrl"],
                                          )
                                        : GeneralLargeTextBox(
                                            name: ds["groupName"],
                                            isImage: true,
                                            isUrlImage: true,
                                            imageUrl: ds["imageUrl"],
                                          ),
                                  ),
                                );
                              }

                              return Expanded(
                                  child: Lottie.asset(
                                'assets/images/big_shimmer.json',
                                height: 100,
                                width: double.infinity,
                              ));
                            });
                  }),
            ),
          ),
          verticalSpacer(25),
          // Column(
          //   children: [
          //     GestureDetector(
          //         onTap: () async {
          //           // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //           //     builder: ((context) =>
          //           //         InviteRequestsScreen(currentUser: currentUser))));
          //         },
          //         child: const ColouredTextBox(title: 'JOIN')),

          //   ],
          // ),
        ],
      ),
    );
  }
}




// import 'package:cooler/Screens/group_screens/contribute_screen.dart';
// import 'package:cooler/Screens/group_screens/select_group_type.dart';
// import 'package:flutter/material.dart';

// import '../../Helpers/colors.dart';
// import '../../Helpers/constants.dart';
// import '../../Widgets/texboxtbox_widgets.dart';

// class PublicCoolerScreen extends StatelessWidget {
//   static const routeName = '/public_cooler';
//   const PublicCoolerScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: kMainColor),
//             onPressed: () => Navigator.of(context)
//                 .pushReplacementNamed(SelectGroupTypeScreen.routeName),
//           ),
//           backgroundColor: background,
//           centerTitle: true,
//           title: const Text(
//             'PUBLIC COOLER',
//             style: TextStyle(
//                 fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: Padding(
//           padding:
//               const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
//           child: SingleChildScrollView(
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: const [
//                     SmallSingleRightTextBox(title: 'SEARCH'),
//                   ],
//                 ),
//                 verticalSpacer(50),
//                 Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context)
//                             .pushReplacementNamed(ContributeScreen.routeName);
//                       },
//                       child: const GeneralLargeTextBox(
//                         name: 'TARGET IT',
//                         isImage: true,
//                         imageUrl: 'assets/images/target_logo.png',
//                       ),
//                     ),
//                     verticalSpacer(10),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context)
//                             .pushReplacementNamed(ContributeScreen.routeName);
//                       },
//                       child: const GeneralLargeTextBox(
//                         name: 'CYBER GROUP',
//                         isImage: true,
//                         imageUrl: 'assets/images/cyber_group.png',
//                       ),
//                     ),
//                     verticalSpacer(10),
//                     verticalSpacer(10),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     Navigator.of(context)
//                     //         .pushReplacementNamed(ContributeScreen.routeName);
//                     //   },
//                     //   child: const GeneralLargeTextBox(
//                     //     name: 'TOPMAN SAVERS',
//                     //     isImage: true,
//                     //     imageUrl: 'assets/images/topman_logo.png',
//                     //   ),
//                     // ),
//                     // verticalSpacer(10),
//                     // verticalSpacer(10),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     Navigator.of(context)
//                     //         .pushReplacementNamed(ContributeScreen.routeName);
//                     //   },
//                     //   child: const GeneralLargeTextBox(
//                     //     name: 'CHASE PMO',
//                     //     isImage: true,
//                     //     imageUrl: 'assets/images/chase_logo.png',
//                     //   ),
//                     // ),
//                     verticalSpacer(10),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
