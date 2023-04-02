import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooler/Models/group_model.dart';
import 'package:cooler/Models/user_model.dart';
import 'package:cooler/Widgets/non_included_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Repositories/firestore_repository.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'my_group_screen.dart';

class InviteRequestsScreen extends StatefulWidget {
  static const routeName = '/inviterequest';
  final AppUser currentUser;
  const InviteRequestsScreen({required this.currentUser, Key? key})
      : super(key: key);

  @override
  State<InviteRequestsScreen> createState() => _InviteRequestsScreenState();
}

class _InviteRequestsScreenState extends State<InviteRequestsScreen> {
  AppUser? groups;
  Group? currentGroup;
  int? count;
  Stream<QuerySnapshot<Object?>>? inviteStream;
  FirestoreRepository firestoreRepository = FirestoreRepository();

  Widget inviteStreamBuilder() {
    return StreamBuilder(
        stream: inviteStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          // if (snapshot.hasData && snapshot.data?.docs.isNotEmpty) {
          //   final users = snapshot.data!;
          //   print(1);
          //   print(12);
          //   print(snapshot.data);
          //   // var groupName = snapshot.data!.docs[0].get('groupName');

          //   return Padding(
          //     padding: const EdgeInsets.only(top: 10.0),
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: InviteRequestBody(
          //         snapshot: snapshot,
          //       ),
          //     ),
          //   );
          // }

          if (snapshot.data == null) {
            var groupId = snapshot.data;
            return const NoContentWidget(mainText: 'No Invites');
          }

          if (snapshot.hasData && snapshot.data != null) {
            final users = snapshot.data!;
            // var groupName = snapshot.data!.docs[0].get('groupName');

            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: InviteRequestBody(
                  count: count,
                  currentGroup: currentGroup,
                  snapshot: snapshot,
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
  }

  getInvites() async {
    inviteStream =
        await FirestoreRepository().getAllInvites(widget.currentUser.id!);
    setState(() {});
  }

  @override
  void initState() {
    getInvites();

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
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(MyGroupsScreen.routeName);
              }
              //  Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             ViewGroupMembersScreen(group: widget.group))),
              ),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'GROUP INVITES',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: inviteStreamBuilder(),
      ),
    );
  }
}

class InviteRequestBody extends StatefulWidget {
  // final List<AppUser> users;
  // final AppUser currentUser;
  Group? currentGroup;
  int? count;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  InviteRequestBody({
    required this.snapshot,
    required this.count,
    // required this.currentUser,
    required this.currentGroup,
    Key? key,
  }) : super(key: key);

  @override
  State<InviteRequestBody> createState() => _InviteRequestBodyState();
}

class _InviteRequestBodyState extends State<InviteRequestBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                  itemCount: widget.snapshot.data?.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    int? count = widget.snapshot.data?.docs.length;
                    // AppUser user = users[index];
                    var groupId =
                        widget.snapshot.data!.docs[index].get('groupId');

                    return count == 0
                        ? const Text('None')
                        : FutureBuilder<Group?>(
                            future: FirestoreRepository().getGroupsbyid(
                                groupId), //getUsersNotInGroupTest(widget.group.members!),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                return const NoContentWidget(
                                    mainText: 'No Invites');
                              }
                              var group = snapshot.data;
                              return Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.currentGroup = group;
                                      widget.count = index;
                                    });
                                  },
                                  child: widget.count == index
                                      ? GeneralRequestBorderTextBox(
                                          onTap: () {},
                                          name: group!.groupName,
                                          isImage: true,
                                          isSub: true,
                                          subTitle: group.groupId,
                                          imageUrl: group.imageUrl,
                                        )
                                      : GeneralRequestTextBox(
                                          onTap: () {},
                                          name: group!.groupName,
                                          isImage: true,
                                          isSub: true,
                                          subTitle: group.groupId,
                                          imageUrl: group.imageUrl,
                                        ),
                                ),
                              );
                            });
                  }),
            ),
          ),
          verticalSpacer(25),
          widget.currentGroup != null
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .pushNamed(SelectGroupTypeScreen.routeName);
                                },
                                child: const ColouredTextBox(title: 'ACCEPT'))),
                        horizontalSpacer(10),
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .pushNamed(CreateGroupScreen.routeName);
                                },
                                child: const ColouredTextBox(title: 'DENY'))),
                      ],
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
