import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'my_group_screen.dart';

class InviteMembersScreen extends StatelessWidget {
  static const routeName = '/inviteMembers';
  const InviteMembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kMainColor),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(MyGroupsScreen.routeName),
          ),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'INVITE MEMBERS',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30.0, top: 50, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const GeneralLargeTextBox(
                    name: 'JOINED',
                    isImage: true,
                    isSub: true,
                    subTitle: 'Kevin@cooler.com',
                    imageUrl: 'assets/images/kevin.png',
                  ),
                  verticalSpacer(10),
                  verticalSpacer(10),
                  const GeneralLargeTextBox(
                    name: 'INVITE SENT',
                    isImage: true,
                    isSub: true,
                    subTitle: 'John@cooler.com',
                    imageUrl: 'assets/images/john.png',
                  ),
                  verticalSpacer(10),
                ],
              ),
              Column(
                children: const [
                  SmallRightAlignDoubleTextBox(
                    title: 'ADD',
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(MyGroupsScreen.routeName);
                          },
                          child: const ColouredTextBox(title: 'ADD'))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
