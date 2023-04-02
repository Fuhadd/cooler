import 'package:cooler/Screens/group_screens/private_cooler.dart';
import 'package:cooler/Screens/group_screens/public_cooler_screen.dart';
import 'package:flutter/material.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import 'join_group_screen.dart';
import 'my_group_screen.dart';

class SelectGroupTypeScreen extends StatelessWidget {
  static const routeName = '/selectgrouptype';
  const SelectGroupTypeScreen({Key? key}) : super(key: key);

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
            'JOIN GROUP',
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
                  Container(
                    height: 40,
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(PublicCoolerScreen.routeName);
                    },
                    child: const GeneralLargeTextBox(
                      name: 'PUBLIC COOLER',
                      isImage: true,
                      imageUrl: 'assets/images/cooler_logo.png',
                    ),
                  ),
                  verticalSpacer(10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(PrivateCoolerScreen.routeName);
                    },
                    child: const GeneralLargeTextBox(
                      name: 'PRIVATE COOLER',
                      isImage: true,
                      imageUrl: 'assets/images/cooler_logo.png',
                    ),
                  ),
                  verticalSpacer(10),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(JoinGroupScreen.routeName);
                      },
                      child: const ColouredTextBox(title: 'SEARCH')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
