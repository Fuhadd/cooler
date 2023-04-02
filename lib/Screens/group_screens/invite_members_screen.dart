import 'package:cooler/Models/group_model.dart';
import 'package:cooler/Models/user_model.dart';
import 'package:cooler/Screens/group_screens/view_members_backup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../Blocs/group_bloc/groups_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Repositories/firestore_repository.dart';
import '../../Repositories/user_repository.dart';
import '../../Widgets/texboxtbox_widgets.dart';

class GroupsMembersInviteScreen extends StatefulWidget {
  final Group group;
  static const routeName = '/invitegroupmember';
  const GroupsMembersInviteScreen({required this.group, Key? key})
      : super(key: key);

  @override
  State<GroupsMembersInviteScreen> createState() =>
      _GroupsMembersInviteScreenState();
}

class _GroupsMembersInviteScreenState extends State<GroupsMembersInviteScreen> {
  AppUser? groups;
  late AppUser? currentUser;
  GroupsBloc? groupsBloc;
  FirestoreRepository firestoreRepository = FirestoreRepository();
  Widget inviteFutureBuilder() {
    return FutureBuilder<List<dynamic>>(
        future: firestoreRepository.getUsersIdInGroup(
            groupId: widget.group.groupId!),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Lottie.asset(
                'assets/images/big_shimmer.json',
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
              ),
            );
          }

          if (snapshot.data == null) {
            return const CircularProgressIndicator();
          }

          List<dynamic> membersList = snapshot.data!.toList();
          // builder: (context) {
          return FutureBuilder<List<AppUser>>(
              future: firestoreRepository.getUsersNotInGroupTest(membersList),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Lottie.asset(
                      'assets/images/big_shimmer.json',
                      height: MediaQuery.of(context).size.height,
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
                  final users = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: GroupsMembersInviteScreenBody(
                        groupsBloc: groupsBloc,
                        users: users,
                        currentUser: currentUser!,
                        group: widget.group,
                      ),
                    ),
                  );
                }

                return Lottie.asset(
                  'assets/images/big_shimmer.json',
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                );
              });
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
    groupsBloc = BlocProvider.of<GroupsBloc>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kMainColor),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kMainColor),
            onPressed: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ViewGroupsMembersScreen(
                          group: widget.group,
                          button: 'LEAVE',
                        ))),
          ),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'INVITE MEMBERS',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: inviteFutureBuilder(),
      ),
    );
  }
}

class GroupsMembersInviteScreenBody extends StatelessWidget {
  final List<AppUser> users;
  final AppUser currentUser;
  final Group group;
  GroupsBloc? groupsBloc;

  GroupsMembersInviteScreenBody({
    required this.users,
    required this.currentUser,
    required this.group,
    required this.groupsBloc,
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
            children: const [
              SmallSingleRightTextBox(title: 'Add Members'),
            ],
          ),
          verticalSpacer(25),
          Expanded(
              child: SizedBox(
                  child: ListView.builder(
                      itemCount: users.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        int? count = users.length;
                        AppUser user = users[index];
                        String uniqueId = FirestoreRepository().createUniqueId(
                            user.id!, currentUser.id!, group.groupId!);

                        return count == 0
                            ? const Text('None')
                            : BlocListener<GroupsBloc, GroupsState>(
                                listener: (context, state) {
                                  if (state is AddMemberToGroupSuccessfull) {
                                    Future.delayed(Duration.zero, () {
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                          content: Text(
                                              "Invite sent to ${user.lastName} has been sent successfully"),
                                          backgroundColor: Colors.black,
                                        ));
                                    });
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            GroupsMembersInviteScreen(
                                                group: group),
                                      ),
                                    );
                                  }
                                },
                                child: BlocBuilder<GroupsBloc, GroupsState>(
                                    builder: (context, state) {
                                  if (state is AddMemberToGroupInProgress &&
                                      state.uniqueId == uniqueId) {
                                    return GeneralLargeLoadingTextBox(
                                      name: user.firstName,
                                      isImage: true,
                                      isSub: true,
                                      subTitle: user.email,
                                      imageUrl: user.imageUrl,
                                    );
                                  } else if (state is AddMemberToGroupFailed) {
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

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: GeneralLargeInviteTextBox(
                                          onTap: () async {
                                            groupsBloc?.add(AddMemberToGroupEvent(
                                                group: group,
                                                groupId: group.groupId!,
                                                memberUserId: user.id!,
                                                inviteeUserId: currentUser.id!,
                                                time: DateTime.now(),
                                                invite: 1,
                                                memberEmail: user.email,
                                                memberImageUrl: user.imageUrl,
                                                memberName:
                                                    '${user.firstName} ${user.lastName}'));
                                          },
                                          name: user.firstName,
                                          isImage: true,
                                          isSub: true,
                                          subTitle: user.email,
                                          imageUrl: user.imageUrl,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                      
                      }

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
                      )))
        ],
      ),
    );
  }
}
