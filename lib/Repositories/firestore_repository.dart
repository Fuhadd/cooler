import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooler/Models/group_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helpers/strings.dart';
import '../Models/user_model.dart';

class FirestoreRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CollectionReference employeeFirebaseFirestore =
      FirebaseFirestore.instance.collection('employees');

  CollectionReference employerFirebaseFirestore =
      FirebaseFirestore.instance.collection('employers');

  CollectionReference groupFirebaseFirestore =
      FirebaseFirestore.instance.collection('groups');

  CollectionReference matchFirebaseFirestore =
      FirebaseFirestore.instance.collection("matches");

  ///?IMPORTANT NOTE
  ///1. Invite of '0' means the user is a member
  ///2. Invite of '1' means the user has been invited to join
  ///
  ///
  ///NOTE

  Future<void> saveUserCredentials(
    String email,
    String firstName,
    String lastName,
    int employerNumber,
  ) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    String profileImage = userImage1;
    var rng = Random();
    var num = rng.nextInt(10);

    if (num % 2 == 0) {
      profileImage = userImage2;
    }
    await employeeFirebaseFirestore.doc(uid.toString()).set(
        {
          "id": uid.toString(),
          "firstName": firstName,
          "lastName": lastName,
          "amountAccrued": 200,
          "email": email,
          "walletBalance": 500,
          "loanBalance": 7500,
          'accountCreated': DateTime.now(),
          "cooler": [],
          "employerNumber": employerNumber,
          "isMobile": true,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<AppUser?> getUserbyid(String uid) async {
    try {
      final user = employeeFirebaseFirestore.doc(uid);
      final snapshot = await user.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
      }
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  Future<AppUser?> getEmployerFromNumber(int employerNumber) async {
    try {
      final user = employerFirebaseFirestore.where("employerNumber",
          isEqualTo: employerNumber);
      final snapshot = await user.get();
      if (snapshot.docs.isEmpty) {
        return null;
      }
      var employee = snapshot.docs[0].data();
      return AppUser.fromJson(employee);
    } catch (error) {
      print(1);
      print(error.toString());
    }
    return null;
  }

  Future<String> createGroup(
    String status,
    String groupName,
    String? password,
    String? pin,
    int amount,
    int noOfSavers,
    DateTime startDate,
  ) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    String profileImage = userImage1;
    var rng = Random();
    var num = rng.nextInt(10);

    if (num % 2 == 0) {
      profileImage = userImage2;
    }
    final docUser = groupFirebaseFirestore.doc();
    await docUser.set(
        {
          "groupId": docUser.id,
          "groupName": groupName,
          "amount": amount,
          "noOfSavers": noOfSavers,
          "startDate": startDate,
          "members": [uid.toString()],
          "admins": [uid.toString()],
          "accountCreated": DateTime.now(),
          "status": status,
          "password": password,
          "pin": pin,
        },
        SetOptions(
          merge: true,
        ));
    return docUser.id.toString();
  }

  Future<Stream<DocumentSnapshot>> getUserGroups(String currentUserId) async {
    String? uid = firebaseAuth.currentUser?.uid.toString() ?? currentUserId;
    return employeeFirebaseFirestore.doc(uid.toString()).snapshots();
    // return groupFirebaseFirestore
    //     .where("status", isEqualTo: 'public')
    //     .orderBy("startDate")
    //     .snapshots();
  }

  Future<Stream<QuerySnapshot>> getEmployerGroups(int employerNumber) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    return employerFirebaseFirestore
        .where("employerNumber", whereIn: [employerNumber, 0]).snapshots();
    // return groupFirebaseFirestore
    //     .where("status", isEqualTo: 'public')
    //     .orderBy("startDate")
    //     .snapshots();
  }

  Future<void> AddGroupToEmployerCredentials(List<String> groupId) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await employerFirebaseFirestore.doc('lghnBxZASI9ArDdsmCbh').update(
      {
        'cooler': FieldValue.arrayUnion(groupId),
      },
    );

    return;
  }

  Future<void> addMemberToGroup(
      {required String groupId,
      required String memberUserId,
      required String inviteeUserId,
      required String memberImageUrl,
      required String memberEmail,
      required String memberName,
      required DateTime time,
      required int invite}) async {
    List<String> users = [memberUserId, inviteeUserId];
    Map<String, dynamic> memberData = {
      "id": groupId,
      "users": users,
      "invitedBy": inviteeUserId,
      "paid": 0,
      "invite": invite,
      'sentAt': time,
      "memberImageUrl": memberImageUrl,
      "memberEmail": memberEmail,
      "memberName": memberName,
    };

    await initiateMember(groupId, memberUserId, memberData);
  }

  Future<void> AddGroupToUserCredentials(List<String> groupId) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await employeeFirebaseFirestore.doc(uid.toString()).update(
      {
        'groups': FieldValue.arrayUnion(groupId),
        'cooler': FieldValue.arrayUnion(groupId),
      },
    );

    return;
  }

  Future<void> removeGroupFromUserCredentials(
      List<String> groupId, String currentUserId) async {
    String? uid = firebaseAuth.currentUser?.uid.toString() ?? currentUserId;
    await employeeFirebaseFirestore.doc(uid.toString()).update(
      {
        'cooler': FieldValue.arrayRemove(groupId), //.arrayUnion(groupId),
      },
    );

    return;
  }

  Future<void> removeUserFromGroupCredentials(
      String groupId, List<String> currentUserId) async {
    await groupFirebaseFirestore.doc(groupId).update(
      {
        'members': FieldValue.arrayRemove(currentUserId),
      },
    );

    return;
  }

  Future<void> AddUserToGroupCredentials(
      String groupId, List<String> currentUserId) async {
    await groupFirebaseFirestore.doc(groupId).update(
      {
        'members': FieldValue.arrayUnion(currentUserId),
      },
    );

    return;
  }

  Future<void>? initiateMember(
      String groupId, String memberUserId, memberData) async {
    final docUser = groupFirebaseFirestore.doc(groupId);
    await docUser
        .collection("membersCollection")
        .doc(memberUserId)
        .set(memberData)
        .catchError((e) {
      print(e.toString());
    });
    return;
  }

  Future<void>? removeMemberFromGroup(
    String groupId,
    String currentUserId,
  ) async {
    final docUser = groupFirebaseFirestore.doc(groupId);
    await docUser
        .collection("membersCollection")
        .doc(currentUserId)
        .delete()
        .catchError((e) {
      print(e.toString());
    });
    return;
  }

  getGroupMembersInviteRequestedByMe(
      {required String groupId, required String currentUserId}) async {
    return groupFirebaseFirestore
        .doc(groupId)
        .collection("membersCollection")
        .where("invitedBy", isEqualTo: currentUserId)
        .where("invite", isEqualTo: 1)
        .orderBy('time')
        .snapshots();
  }

  getAllGroupMembers({required String groupId}) async {
    try {
      var groupMembers = groupFirebaseFirestore
          .doc(groupId)
          .collection("membersCollection")
          .where("invite", isEqualTo: 0)
          .orderBy('sentAt')
          .snapshots();
      return groupMembers;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Stream<QuerySnapshot>> getAllInviteRequest(
      String currentUserId) async {
    return matchFirebaseFirestore
        .where("users", arrayContains: currentUserId)
        .where("isAccept", isEqualTo: "0")
        .where("isReject", isEqualTo: "0")
        .where("sentBy", isNotEqualTo: currentUserId)
        .orderBy("sentBy", descending: true)
        .snapshots();
  }

  Future<void>? acceptInviteRequest(String groupId, String currentUserId) {
    var groupMembers = groupFirebaseFirestore
        .doc(groupId)
        .collection("membersCollection")
        .doc(currentUserId)
        .set(
            {
          "invite": 0,
        },
            SetOptions(
              merge: true,
            )).catchError((e) {
      print(e.toString());
    });
    return null;
  }

  Future<void> deleteInviteRequest(
      String currentUserId, String invitedUserId) async {
    String deleteId = createChatRoomId(currentUserId, invitedUserId);
    return matchFirebaseFirestore.doc(deleteId).delete();
  }

  Future<List<dynamic>> getUsersIdInGroup({required String groupId}) async {
    var snapshot = await groupFirebaseFirestore.doc(groupId).get();
    List<dynamic> groupMembersId = await snapshot.get("members");
    return groupMembersId;
  }

  Future<void> addMemberToGroupList(
      List<String> memberId, String groupId) async {
    await groupFirebaseFirestore.doc(groupId).update(
      {
        'members': FieldValue.arrayUnion(memberId),
      },
    );
    return;
  }

  Future<Stream<QuerySnapshot>> getSentRequest(
      String currentUserId, String groupId) async {
    return groupFirebaseFirestore
        .doc(groupId)
        .collection("membersCollection")
        .where("users", arrayContains: currentUserId)
        .where("invite", isEqualTo: 1)
        .where("invitedBy", isNotEqualTo: currentUserId)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getPublicGroupIds() async {
    return groupFirebaseFirestore
        .where("status", isEqualTo: 'public')
        .orderBy("startDate")
        .snapshots();
  }

  Future<List<AppUser>> getUsersNotInGroupTest(
      List<dynamic> groupMembersId) async {
    List<AppUser> nonMembers = [];
    List<List<dynamic>> subList = [];
    for (var i = 0; i < groupMembersId.length; i += 10) {
      subList.add(groupMembersId.sublist(
          i, i + 10 > groupMembersId.length ? groupMembersId.length : i + 10));
    }
    for (var element in subList) {
      await employeeFirebaseFirestore
          .orderBy("id", descending: true)
          .where("id", whereNotIn: element)
          .get()
          .then((value) {
        for (var snapshot in value.docs) {
          var result = AppUser.fromJson(snapshot.data());
          nonMembers.add(result);
        }
      });
    }

    return nonMembers;
  }

  Future<List<AppUser>?> getUsersInGroup(List<dynamic> groupMembersId) async {
    List<AppUser> nonMembers = [];
    List<List<dynamic>> subList = [];
    try {
      for (var i = 0; i < groupMembersId.length; i += 10) {
        subList.add(groupMembersId.sublist(i,
            i + 10 > groupMembersId.length ? groupMembersId.length : i + 10));
      }
      for (var element in subList) {
        await employeeFirebaseFirestore
            // .orderBy("id", descending: true)
            .where("id", whereIn: element)
            .get()
            .then((value) {
          for (var snapshot in value.docs) {
            var result = AppUser.fromJson(snapshot.data());
            nonMembers.add(result);
          }
        });
      }

      return nonMembers;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<Stream<QuerySnapshot>> getUsersNotInGroup(
      List<dynamic> groupMembersId) async {
    List<List<dynamic>> subList = [];
    for (var i = 0; i < groupMembersId.length; i += 10) {
      subList.add(groupMembersId.sublist(
          i, i + 10 > groupMembersId.length ? groupMembersId.length : i + 10));
    }
    return employeeFirebaseFirestore
        .orderBy("id", descending: true)
        .where("id", whereNotIn: groupMembersId)
        .snapshots();
  }

  Future<Group?> getPrivateGroup(String groupName, String pin) async {
    try {
      final group = groupFirebaseFirestore
          .where("groupName", isEqualTo: groupName)
          .where("pin", isEqualTo: pin);

      final snapshot = await group.get();
      if (snapshot.docs.isEmpty) {
        return null;
      }
      var result = snapshot.docs[0].data();

      return Group.fromJson(result);

      // if (snapshot.exists) {
      //   return Group.fromJson(snapshot.d);
      // }
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  Future<Group?> getGroupsbyid(String groupId) async {
    try {
      final group = groupFirebaseFirestore.doc(groupId);
      final snapshot = await group.get();

      if (snapshot.exists) {
        return Group.fromJson(snapshot.data());
      }
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  Future<Group?> getGroupsbyidMinusCurrent(
      String groupId, String currentUserId) async {
    try {
      final group = groupFirebaseFirestore.doc(groupId);
      final snapshot = await group.get();

      if (snapshot.exists) {
        Group group = Group.fromJson(snapshot.data());
        if (group.members!.contains(currentUserId)) {
          return null;
        }

        return Group.fromJson(snapshot.data());
      }
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  Future<AppUser?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final employee = employeeFirebaseFirestore.doc(uid);
      final snapshot = await employee.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  Future<AppUser?> saveUsersCredentialslocal() async {
    try {
      AppUser? employee = await getUsersCredentials();

      if (employee != null) {
        final userJson = json.encode(employee.toJson());

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', userJson);
      }
    } catch (error) {
      print(1);
      print(error.toString());
    }
    return null;
  }

  //#Send Invite
  createChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  createUniqueId(String a, String b, String c) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_${a}_$c";
    } else {
      return "${a}_${b}_$c";
    }
  }

  Future<void>? sendInvite(String matchId, chatMessageData) {
    matchFirebaseFirestore
        .doc(matchId)
        .set(
            chatMessageData,
            SetOptions(
              merge: true,
            ))
        .catchError((e) {
      print(e.toString());
    });
    return null;
  }

  Future<void> initializeMatches(
      {required String currentUserId,
      required String invitedUserId,
      required Group group,
      required DateTime time}) async {
    List<String> users = [currentUserId, invitedUserId];

    String matchId = await createChatRoomId(currentUserId, invitedUserId);

    Map<String, dynamic> matchesData = {
      "users": users,
      "matchId": matchId,
      "sentBy": currentUserId,
      "isAccept": "0",
      "isReject": "0",
      "sentAt": time,
      "groupName": group.groupName,
      "groupId": group.groupId,
    };
    await sendInvite(matchId, matchesData);
  }

  Future<int> getAllRequest(String currentUserId, String invitedUserId) async {
    String matchId = await createChatRoomId(currentUserId, invitedUserId);
    final invite = matchFirebaseFirestore.doc(matchId);
    final snapshot = await invite.get();
    if (snapshot.exists) {
      var isAccept = snapshot.get('isAccept');
      var isReject = snapshot.get('isReject');
      var sentBy = snapshot.get('sentBy');
      if (isAccept == '0' && isReject == '0' && sentBy != currentUserId) {
        return 1;
      } else if (isAccept == '0' &&
          isReject == '0' &&
          sentBy == currentUserId) {
        return 2;
      }
    }
    return 0;
  }

  Future<Stream<QuerySnapshot>> getAllInvites(String currentUserId) async {
    return matchFirebaseFirestore
        .where("users", arrayContains: currentUserId)
        .where("isAccept", isEqualTo: "0")
        .where("isReject", isEqualTo: "0")
        .where("sentBy", isNotEqualTo: currentUserId)
        .orderBy("sentBy", descending: true)
        .snapshots();
  }
}
