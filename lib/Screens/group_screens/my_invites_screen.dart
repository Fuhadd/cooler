import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooler/Models/user_model.dart';
import 'package:cooler/Widgets/no_content_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../Blocs/group_bloc/groups_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Repositories/firestore_repository.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'my_group_screen.dart';

class MyInviteScreen extends StatefulWidget {
  final AppUser currentUser;
  static const routeName = '/viewgroupsmember';
  const MyInviteScreen({required this.currentUser, Key? key}) : super(key: key);

  @override
  State<MyInviteScreen> createState() => _MyInviteScreenState();
}

class _MyInviteScreenState extends State<MyInviteScreen> {
  AppUser? user;
  String? currentGroupId;
  String? invitedUserId;
  int? count;
  GroupsBloc? groupsBloc;
  Stream<QuerySnapshot>? viewInvite;
  FirestoreRepository firestoreRepository = FirestoreRepository();
  Widget viewmembersStreamBuilder() {
    return StreamBuilder(
        stream: viewInvite,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (1 == 1) {
            return const NoContentScreen(
                mainText: 'No Invites at the moment',
                subTitle: 'Invitation tojoin a greoup will be displayed here');
          }
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

          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData &&
              snapshot.data != null) {
            final group = snapshot.data!;

            int invites = snapshot.data!.docs.length;

            return invites == 0
                ? const NoContentScreen(
                    mainText: 'No Invites at the moment',
                    subTitle:
                        'Invitation to join a greoup will be displayed here')
                : Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: MyInviteScreenBody(
                        invitedUserId: invitedUserId,
                        groupsBloc: groupsBloc,
                        count: count,
                        currentGroupId: currentGroupId,
                        currentUser: widget.currentUser,
                        snapshot: snapshot,
                      ),
                    ),
                  );
          }
          print(12);
          print(snapshot.error);
          print(snapshot.connectionState);
          print(snapshot.data);

          return const NoContentScreen(
              mainText: 'No Invites at the moment',
              subTitle: 'Invitation tojoin a greoup will be displayed here');
          // Expanded(
          //     child: Lottie.asset(
          //   'assets/images/big_shimmer.json',
          //   height: 100,
          //   width: double.infinity,
          // ));
        });
  }

  @override
  void initState() {
    FirestoreRepository()
        .getAllInviteRequest(widget.currentUser.id!)
        .then((val) {
      setState(() {
        viewInvite = val;
      });
    });
    // TODO: implement initState
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
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(MyGroupsScreen.routeName),
          ),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'GROUP INVITES',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: viewmembersStreamBuilder(),
      ),
    );
  }
}

class MyInviteScreenBody extends StatefulWidget {
  final AppUser currentUser;
  String? currentGroupId;
  String? invitedUserId;
  int? count;
  GroupsBloc? groupsBloc;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  MyInviteScreenBody({
    required this.currentUser,
    required this.snapshot,
    required this.count,
    required this.currentGroupId,
    required this.groupsBloc,
    required this.invitedUserId,
    Key? key,
  }) : super(key: key);

  @override
  State<MyInviteScreenBody> createState() => _MyInviteScreenBodyState();
}

class _MyInviteScreenBodyState extends State<MyInviteScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30, right: 30.0, top: 20, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Column(
          //   children: [
          //     GestureDetector(
          //         onTap: () {
          //           // Navigator.pushReplacement(
          //           //   context,
          //           //   MaterialPageRoute(
          //           //       builder: (builder) =>
          //           //           GroupsMembersInviteScreen(group: group)),
          //           // );
          //         },
          //         child: const SmallSingleRightTextBox(
          //             title: 'Invite New Members')),
          //   ],
          // ),
          verticalSpacer(25),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                  itemCount: widget.snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    int? count = widget.snapshot.data!.docs.length;

                    print('count is $count');
                    var groupName =
                        widget.snapshot.data!.docs[index].get("groupName");

                    return count == 0
                        ? const Text('None')
                        : Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  print(count);
                                  print(widget.snapshot.data!.docs[index]
                                      .get("groupId"));
                                  widget.currentGroupId = widget
                                      .snapshot.data!.docs[index]
                                      .get("groupId");
                                  // print(currentGroupId);
                                  widget.count = index;
                                  print(count == index);
                                  widget.invitedUserId = widget
                                      .snapshot.data!.docs[index]
                                      .get("sentBy");
                                });
                              },
                              child: widget.count == index
                                  ? GeneralLargeBorderTextBox(
                                      name: widget.snapshot.data!.docs[index]
                                          .get("groupName"),
                                      isImage: true,
                                      isSub: true,
                                      isUrlImage: true,
                                      subTitle: widget
                                          .snapshot.data!.docs[index]
                                          .get("groupName"),
                                      imageUrl: widget
                                          .snapshot.data!.docs[index]
                                          .get("groupName"),
                                    )
                                  : GeneralLargeTextBox(
                                      name: widget.snapshot.data!.docs[index]
                                          .get("groupName"),
                                      isImage: true,
                                      isSub: true,
                                      isUrlImage: true,
                                      subTitle: widget
                                          .snapshot.data!.docs[index]
                                          .get("groupName"),
                                      imageUrl: widget
                                          .snapshot.data!.docs[index]
                                          .get("groupName"),
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
          widget.currentGroupId != null
              ? Column(
                  children: [
                    Row(
                      children: [
                        BlocListener<GroupsBloc, GroupsState>(
                          listener: (context, state) {
                            if (state is AcceptGroupInviteSuccessfull) {
                              Future.delayed(Duration.zero, () {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(const SnackBar(
                                    content: Text(
                                        "Invite has been accepted successfully"),
                                    backgroundColor: Colors.black,
                                  ));
                              });
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => MyInviteScreen(
                                      currentUser: widget.currentUser),
                                ),
                              );
                            }
                          },
                          child: BlocBuilder<GroupsBloc, GroupsState>(
                              builder: (context, state) {
                            if (state is AcceptGroupInviteInProgress) {
                              return const ColouredTextBox(
                                title: '',
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

                            return Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      widget.groupsBloc?.add(
                                          AcceptGroupInviteEvent(
                                              groupId: widget.currentGroupId!,
                                              invitedUserId:
                                                  widget.invitedUserId!,
                                              currentUserId:
                                                  widget.currentUser.id!));
                                      // Navigator.of(context)
                                      //     .pushNamed(SelectGroupTypeScreen.routeName);
                                    },
                                    child: const ColouredTextBox(
                                        title: 'ACCEPT')));
                          }),
                        ),
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
  }
}
