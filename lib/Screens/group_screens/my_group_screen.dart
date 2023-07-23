import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooler/Models/group_model.dart';
import 'package:cooler/Screens/group_screens/employer_groups_screen.dart';
import 'package:cooler/Screens/group_screens/view_members_backup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Models/user_model.dart';
import '../../Repositories/firestore_repository.dart';
import '../../Repositories/user_repository.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../settings_screen.dart';
import '../wallet_screens/wallet_home_screen.dart';
import '../welcome_screen.dart';
import 'create_group_screen.dart';

class MyGroupsScreen extends StatefulWidget {
  static const routeName = '/my_groups';
  const MyGroupsScreen({Key? key}) : super(key: key);

  @override
  State<MyGroupsScreen> createState() => _MyGroupsScreenState();
}

class _MyGroupsScreenState extends State<MyGroupsScreen> {
  late AppUser? currentUser;
  Stream<DocumentSnapshot>? myGroups;
  FirestoreRepository firestoreRepository = FirestoreRepository();
  final int _selectedIndex = 1;
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

  Widget MyGroupStreamScreen() {
    return StreamBuilder(
      stream: myGroups,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          AppUser userDetails = AppUser.fromJson(snapshot.data!.data());
          List<dynamic> userGroups = userDetails.coolers!;
          if (userGroups.isEmpty) {
            return MyGroupScreenEmpty(
              currentUser: currentUser!,
            );
          } else {
            return MyGroupScreenBody(
              currentUser: currentUser!,
              snapshot: snapshot,
              firestoreRepository: firestoreRepository,
            );
          }
        } else {
          return Lottie.asset(
            'assets/images/big_shimmer.json',
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          );
        }
      },
    );
  }

  getGroups() async {
    myGroups = await firestoreRepository.getUserGroups();
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
        // bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kMainColor),
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: kMainColor),
          //   onPressed: () => Navigator.of(context)
          //       .pushReplacementNamed(WelcomeScreen.routeName),
          // ),
          elevation: 0,
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'My Coolers',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: MyGroupStreamScreen(),
      ),
    );
  }
}

class MyGroupScreenBody extends StatelessWidget {
  final AsyncSnapshot<DocumentSnapshot> snapshot;
  final FirestoreRepository firestoreRepository;
  final AppUser currentUser;

  const MyGroupScreenBody({
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
                  itemCount: snapshot.data
                      ?.get("coolers")
                      .length, //  ;.docs.length ?? 6,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String groupId = snapshot.data?.get("coolers")[index];

                    int? count = snapshot.data?.get("coolers").length;
                    return count == 0
                        ? const Text('None')
                        : FutureBuilder<Group?>(
                            future: firestoreRepository.getGroupsbyid(groupId),
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
                                print(snapshot);
                                print(snapshot.connectionState);
                                return const CircularProgressIndicator();
                              }

                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData &&
                                  snapshot.data != null) {
                                final group = snapshot.data!;

                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ViewGroupsMembersScreen(
                                                    button: 'LEAVE',
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
                                    child: GeneralLargeTextBox(
                                      name: snapshot.data!.groupName,
                                      isImage: true,
                                      isUrlImage: true,
                                      imageUrl: snapshot.data!.imageUrl,
                                    ),

                                    // convertedTime > 0
                                    //     ? GeneralTimeLargeTextBox(
                                    //         name: ds["groupName"],
                                    //         time: finalTime,
                                    //         isImage: true,
                                    //         imageUrl: ds["imageUrl"],
                                    //       )
                                    //     : GeneralLargeTextBox(
                                    //         name: ds["groupName"],
                                    //         isImage: true,
                                    //         imageUrl: ds["imageUrl"],
                                    //       ),
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
          Column(
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EmployerGroupsScreen(
                                    currentUser: currentUser)));
                          },
                          child: const ColouredTextBox(title: 'JOIN'))),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateGroupScreen()),
                    );
                    // Navigator.of(context)
                    //     .pushNamed(CreateGroupScreen.routeName);
                  },
                  child: const ColouredTextBox(title: 'CREATE')),
              // verticalSpacer(20),
            ],
          ),
        ],
      ),
    );
  }
}

class MyGroupScreenEmpty extends StatelessWidget {
  final AppUser currentUser;

  const MyGroupScreenEmpty({
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CustomRowTextField(
                  name: 'groupPin',
                  hint: 'SEARCH',
                  isdigit: false,
                ),
              ),
            ],
          ),
          verticalSpacer(40),
          Expanded(
            child: Container(
              height: 75,
              width: double.infinity,
              decoration: BoxDecoration(
                color: blueBackground.withOpacity(0.08),
                // borderRadius: BorderRadius.circular(5),
                // boxShadow: [
                //   BoxShadow(
                //       spreadRadius: 1,
                //       blurRadius: 1,
                //       offset: const Offset(0, 1),
                //       color: kShadowColor),
                // ],
                // border: Border.all(color: kBoxBackground, width: 0.8)
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      'Coolers you’ve joined would appear here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  )),
            ),
            //     child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'Not on any group',
            //       style: Theme.of(context)
            //           .textTheme
            //           .headline3!
            //           .copyWith(color: kMainColor),
            //     ),
            //     verticalSpacer(10),
            //     const Text(
            //       'Proceed to join an existing groupor create a new one',
            //       style: TextStyle(color: Colors.grey),
            //     ),
            //     verticalSpacer(10),
            //     Lottie.asset(
            //       'assets/images/no_content.json',
            //       height: 100,
            //       width: double.infinity,
            //     )
            //   ],
            // )
          ),
          verticalSpacer(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EmployerGroupsScreen(
                                      currentUser: currentUser)));
                            },
                            child: const ColouredTextBox(title: 'Join'))),
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
                verticalSpacer(10),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CreateGroupScreen.routeName);
                    },
                    child: const ColouredOutlineTextBox(title: 'Create')),
                verticalSpacer(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
