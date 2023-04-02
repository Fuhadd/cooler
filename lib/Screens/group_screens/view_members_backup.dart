import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooler/Models/group_model.dart';
import 'package:cooler/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../Blocs/group_bloc/groups_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Repositories/firestore_repository.dart';
import '../../Repositories/user_repository.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'invite_members_screen.dart';
import 'my_group_screen.dart';

class ViewGroupsMembersScreen extends StatefulWidget {
  final Group group;
  final String button;
  static const routeName = '/viewgroupsmember';
  const ViewGroupsMembersScreen(
      {required this.button, required this.group, Key? key})
      : super(key: key);

  @override
  State<ViewGroupsMembersScreen> createState() =>
      _ViewGroupsMembersScreenState();
}

class _ViewGroupsMembersScreenState extends State<ViewGroupsMembersScreen> {
  AppUser? currentUser;
  Stream<QuerySnapshot>? viewMembers;
  FirestoreRepository firestoreRepository = FirestoreRepository();
  Widget viewmembersStreamBuilder() {
    return StreamBuilder(
        stream: viewMembers,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            print(snapshot.data!.docs.length);

            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: ViewGroupsMembersScreenBody(
                  button: widget.button,
                  snapshot: snapshot,
                  group: widget.group,
                  memberEmail: '',
                  memberImageUrl: '',
                  memberName: '',
                  memberId: currentUser!.id!,
                ),
              ),
            );
          }
          print(snapshot.error);
          print(snapshot.connectionState);
          print(snapshot.data);

          return Container();
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
        .getAllGroupMembers(groupId: widget.group.groupId!)
        .then((val) {
      setState(() {
        viewMembers = val;
      });
    });
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return currentUser == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
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
                  'VIEW MEMBERS',
                  style: TextStyle(
                      fontSize: 21,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: viewmembersStreamBuilder(),
            ),
          );
  }
}

class ViewGroupsMembersScreenBody extends StatelessWidget {
  final Group group;
  final String button;
  final String memberName;
  final String memberEmail;
  final String memberImageUrl;
  final String memberId;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  ViewGroupsMembersScreenBody({
    required this.group,
    required this.button,
    required this.memberId,
    required this.memberEmail,
    required this.memberImageUrl,
    required this.memberName,
    required this.snapshot,
    Key? key,
  }) : super(key: key);

  GroupsBloc? groupsBloc;
  @override
  Widget build(BuildContext context) {
    groupsBloc = BlocProvider.of<GroupsBloc>(context);
    return Padding(
      padding:
          const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          button == 'join'
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
              : const SizedBox(),
          verticalSpacer(25),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    int? count = snapshot.data!.docs.length;
                    print(count);

                    return count == 0
                        ? const Text('None')
                        : Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: GeneralLargeTextBox(
                                name: snapshot.data!.docs[index]
                                    .get("memberName"),
                                isImage: true,
                                isSub: true,
                                isUrlImage: true,
                                subTitle: snapshot.data!.docs[index]
                                    .get("memberEmail"),
                                imageUrl: snapshot.data!.docs[index]
                                    .get("memberImageUrl"),
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
          BlocListener<GroupsBloc, GroupsState>(
            listener: (context, state) {
              if (state is LeaveGroupSuccessfull) {
                Future.delayed(Duration.zero, () {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content:
                          Text("You have successfully left ${group.groupName}"),
                      backgroundColor: Colors.black,
                    ));
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const MyGroupsScreen()),
                );
              }
            },
            child:
                BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
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
                                  currentUserId: memberId,
                                  groupName: group.groupName,
                                  groupId: group.groupId!));
                              Navigator.of(context).pushReplacementNamed(
                                  MyGroupsScreen.routeName);
                            },
                            child: ColouredTextBox(title: button))),
                  ),
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
          //       letter: 'C',
          //     ),
          //     SmallTextLetterBox(
          //       isactive: false,
          //       letter: 'W',
          //     ),
          //     SmallTextLetterBox(
          //       isactive: false,
          //       letter: 'S',
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
