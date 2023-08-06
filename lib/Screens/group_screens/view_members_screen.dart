import 'package:cooler/Models/group_model.dart';
import 'package:cooler/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../Blocs/group_bloc/groups_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Repositories/firestore_repository.dart';
import '../../Repositories/user_repository.dart';
import '../../Widgets/bottom_navigation_bar.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'invite_members_screen.dart';
import 'my_group_screen.dart';

class ViewGroupMembersScreen extends StatefulWidget {
  final Group group;
  final String button;
  final bool showInviteColumn;
  static const routeName = '/viewgroupmember';
  const ViewGroupMembersScreen(
      {required this.button,
      required this.group,
      required this.showInviteColumn,
      Key? key})
      : super(key: key);

  @override
  State<ViewGroupMembersScreen> createState() => _ViewGroupMembersScreenState();
}

class _ViewGroupMembersScreenState extends State<ViewGroupMembersScreen> {
  AppUser? currentUser;
  FirestoreRepository firestoreRepository = FirestoreRepository();
  Widget viewmembersFutureBuilder() {
    return FutureBuilder<List<AppUser>?>(
        future: firestoreRepository.getUsersInGroup(widget.group.members!),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/images/big_shimmer.json',
                height: 100,
                width: double.infinity,
              ),
            );
          }

          if (snapshot.data == null) {
            return const CircularProgressIndicator();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            final group = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: ViewGroupsMembersScreenBody(
                  currentUser: currentUser!,
                  button: widget.button,
                  users: snapshot.data!,
                  group: widget.group,
                  showInviteColumn: widget.showInviteColumn,
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

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kMainColor),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kMainColor),
          onPressed: () => Navigator.of(context).pop(),
          // .pushReplacementNamed(MyGroupsScreen.routeName),
        ),
        backgroundColor: background,
        centerTitle: true,
        title: const Text(
          'View Members',
          style: TextStyle(
              fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: viewmembersFutureBuilder(),
    );
  }
}

class ViewGroupsMembersScreenBody extends StatelessWidget {
  final AppUser currentUser;
  final List<AppUser> users;
  final Group group;
  final String button;
  final bool showInviteColumn;

  ViewGroupsMembersScreenBody({
    required this.users,
    required this.group,
    required this.button,
    required this.currentUser,
    required this.showInviteColumn,
    Key? key,
  }) : super(key: key);

  GroupsBloc? groupsBloc;

  @override
  Widget build(BuildContext context) {
    groupsBloc = BlocProvider.of<GroupsBloc>(context);
    return Consumer(builder: (context, ref, child) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showInviteColumn
                ? Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      GroupsMembersInviteScreen(group: group)),
                            );
                          },
                          child: const SmallSingleRightTextBox(
                              title: 'Invite New Members')),
                    ],
                  )
                : Container(),

            verticalSpacer(25),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                    itemCount: users.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      int? count = users.length;
                      AppUser user = users[index];

                      return count == 0
                          ? const Text('None')
                          : Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: GeneralLargeTextBox(
                                  name: user.firstName,
                                  isImage: true,
                                  isSub: true,
                                  isUrlImage: true,
                                  subTitle: user.email,
                                  imageUrl: user.imageUrl,
                                ),
                                // child: GeneralLargeInviteTextBox(
                                //   onTap: () {},
                                //   name: user.firstName,
                                //   isImage: true,
                                //   isSub: true,
                                //   subTitle: user.email,
                                //   imageUrl: user.imageUrl,
                                // ),
                              ),
                            );
                    }),
              ),
            ),

            verticalSpacer(25),
            button == 'Join'
                ? BlocListener<GroupsBloc, GroupsState>(
                    listener: (context, state) {
                      if (state is AddUserToPublicGroupSuccessfull) {
                        Future.delayed(Duration.zero, () {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text(
                                  "You have successfully joined ${group.groupName}"),
                              backgroundColor: Colors.black,
                            ));
                        });
                        ref.read(indexProvider.notifier).state = 1;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const DashboardScreen()));
                      }
                    },
                    child: BlocBuilder<GroupsBloc, GroupsState>(
                        builder: (context, state) {
                      if (state is AddUserToPublicGroupInProgress) {
                        return const GeneralLargeLoadingTextBox(
                          name: '',
                          isImage: true,
                          isSub: true,
                          subTitle: '',
                          imageUrl: '',
                        );
                      } else if (state is AddUserToPublicGroupFailed) {
                        Future.delayed(Duration.zero, () {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ));
                        });
                      }
                      // else if (state
                      //     is AddMemberToGroupSuccessfull) {
                      //   return Container();
                      // }

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: GestureDetector(
                                    onTap: () {
                                      groupsBloc?.add(AddUserToPublicGroupEvent(
                                          groupId: group.groupId!,
                                          inviteeUserId: currentUser.id!,
                                          memberUserId: currentUser.id!,
                                          memberEmail: currentUser.email,
                                          memberImageUrl: currentUser.imageUrl,
                                          memberName:
                                              '${currentUser.lastName} ${currentUser.firstName}'));
                                      ref.read(indexProvider.notifier).state =
                                          1;
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DashboardScreen()));
                                      // Navigator.of(context)
                                      //     .pushReplacementNamed(
                                      //         MyGroupsScreen.routeName);
                                    },
                                    child: ColouredTextBox(title: button))),
                          ),
                          verticalSpacer(20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: const [
                          //     SmallTextLetterBox(
                          //       isactive: false,
                          //       letter: 'H',
                          //     ),
                          //     SmallTextLetterBox(
                          //       isactive: true,
                          //       letter: 't',
                          //     ),
                          //     SmallTextLetterBox(
                          //       isactive: false,
                          //       letter: 'I',
                          //     ),
                          //     SmallTextLetterBox(
                          //       isactive: false,
                          //       letter: 'S',
                          //     )
                          //   ],
                          // ),
                        ],
                      );
                    }),
                  )
                : BlocListener<GroupsBloc, GroupsState>(
                    listener: (context, state) {
                      if (state is LeaveGroupSuccessfull) {
                        Future.delayed(Duration.zero, () {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text(
                                  "You have successfully left ${group.groupName}"),
                              backgroundColor: Colors.black,
                            ));
                        });
                        ref.read(indexProvider.notifier).state = 1;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const DashboardScreen()));
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //       builder: (context) => const MyGroupsScreen()),
                        // );
                      }
                    },
                    child: BlocBuilder<GroupsBloc, GroupsState>(
                        builder: (context, state) {
                      if (state is LeaveGroupInProgress) {
                        return const GeneralLargeLoadingTextBox(
                          name: '',
                          isImage: true,
                          isSub: true,
                          subTitle: '',
                          imageUrl: '',
                        );
                      } else if (state is LeaveGroupFailed) {
                        Future.delayed(Duration.zero, () {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ));
                        });
                      }
                      // else if (state
                      //     is AddMemberToGroupSuccessfull) {
                      //   return Container();
                      // }

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: GestureDetector(
                                    onTap: () {
                                      groupsBloc?.add(LeaveGroupEvent(
                                          currentUserId: currentUser.id!,
                                          groupName: group.groupName,
                                          groupId: group.groupId!));
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              MyGroupsScreen.routeName);
                                    },
                                    child: ColouredTextBox(title: button))),
                          ),
                          verticalSpacer(20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: const [
                          //     SmallTextLetterBox(
                          //       isactive: false,
                          //       letter: 'H',
                          //     ),
                          //     SmallTextLetterBox(
                          //       isactive: true,
                          //       letter: 't',
                          //     ),
                          //     SmallTextLetterBox(
                          //       isactive: false,
                          //       letter: 'I',
                          //     ),
                          //     SmallTextLetterBox(
                          //       isactive: false,
                          //       letter: 'S',
                          //     )
                          //   ],
                          // ),
                        ],
                      );
                    }),
                  ),

            // Column(
            //   children: [
            //     Row(
            //       children: [
            //         Expanded(
            //             child: GestureDetector(
            //                 onTap: () {
            //                   Navigator.of(context)
            //                       .pushNamed(SelectGroupTypeScreen.routeName);
            //                 },
            //                 child: const ColouredTextBox(title: 'JOIN'))),
            //         horizontalSpacer(10),
            //         Expanded(
            //             child: GestureDetector(
            //                 onTap: () {
            //                   Navigator.of(context)
            //                       .pushNamed(CreateGroupScreen.routeName);
            //                 },
            //                 child: const ColouredTextBox(title: 'CREATE'))),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      );
    });
  }
}
