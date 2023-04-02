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
import '../../Widgets/texboxtbox_widgets.dart';
import '../settings_screen.dart';
import '../wallet_screens/wallet_home_screen.dart';
import 'create_group_screen.dart';
import 'my_group_screen.dart';

class EmployerGroupsScreen extends StatefulWidget {
  static const routeName = '/my_groups';
  const EmployerGroupsScreen({required this.currentUser, Key? key})
      : super(key: key);
  final AppUser currentUser;

  @override
  State<EmployerGroupsScreen> createState() => _EmployerGroupsScreenState();
}

class _EmployerGroupsScreenState extends State<EmployerGroupsScreen> {
  Stream<QuerySnapshot>? employerGroups;
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

  Widget employerGroupStreamScreen() {
    return StreamBuilder(
      stream: employerGroups,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          var count = snapshot.data!.docs.length;
          if (count == 0) {
            return EmployerDeletedScreen(
              currentUser: widget.currentUser,
            );
          }
          AppUser userDetails = AppUser.fromJson(snapshot.data!.docs[0].data());
          List<dynamic> userGroups = userDetails.coolers!;
          if (userGroups.isEmpty) {
            return EmployerGroupScreenEmpty(
              currentUser: widget.currentUser,
            );
          } else {
            return EmployerGroupScreenBody(
              currentUser: widget.currentUser,
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
    employerGroups = await firestoreRepository
        .getEmployerGroups(widget.currentUser.employerNumber!);
    setState(() {});
  }

  @override
  void initState() {
    getGroups();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kMainColor),
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: kMainColor),
          //   onPressed: () => Navigator.of(context)
          //       .pushReplacementNamed(WelcomeScreen.routeName),
          // ),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'JOIN COOLERS',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: employerGroupStreamScreen(),
      ),
    );
  }
}

class EmployerGroupScreenBody extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final FirestoreRepository firestoreRepository;
  final AppUser currentUser;

  const EmployerGroupScreenBody({
    required this.firestoreRepository,
    required this.snapshot,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var employerArray = [];
    var result = snapshot.data?.docs;
    for (int i = 0; i < result!.length; i++) {
      var employerList = result[i].get("coolers");
      for (int i = 0; i < employerList.length; i++) {
        employerArray.add(employerList[i]);
      }
    }
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
                  itemCount: employerArray.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String groupId = employerArray[index];

                    int? count = snapshot.data?.docs[0].get("coolers").length;
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
                                                ViewGroupMembersScreen(
                                                    button: 'Join',
                                                    showInviteColumn: false,
                                                    group: group)),
                                      );
                                    },
                                    child: GeneralLargeTextBox(
                                      name: snapshot.data!.groupName,
                                      isImage: true,
                                      isUrlImage: true,
                                      imageUrl: snapshot.data!.imageUrl,
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
          Column(
            children: [
              verticalSpacer(20),
            ],
          ),
        ],
      ),
    );
  }
}

class EmployerGroupScreenEmpty extends StatelessWidget {
  final AppUser currentUser;

  const EmployerGroupScreenEmpty({
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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No available group at the moment',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: kMainColor),
              ),
              verticalSpacer(10),
              const Text(
                'Try again later or Proceed to create a new one',
                style: TextStyle(color: Colors.grey),
              ),
              verticalSpacer(10),
              Lottie.asset(
                'assets/images/no_content.json',
                height: 100,
                width: double.infinity,
              )
            ],
          )),
          Column(
            children: [
              verticalSpacer(20),
            ],
          ),
        ],
      ),
    );
  }
}

class EmployerDeletedScreen extends StatelessWidget {
  final AppUser currentUser;

  const EmployerDeletedScreen({
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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Employer Seems to have an Issue',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: kMainColor),
              ),
              verticalSpacer(10),
              const Text(
                'Proceed to contact your organization for more information',
                style: TextStyle(color: Colors.grey),
              ),
              verticalSpacer(10),
              Lottie.asset(
                'assets/images/no_content.json',
                height: 100,
                width: double.infinity,
              )
            ],
          )),
          Column(
            children: [
              GestureDetector(
                  onTap: () async {},
                  child:
                      const ColouredTextBox(title: 'Update Employer Number')),
            ],
          ),
        ],
      ),
    );
  }
}
