import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../Blocs/group_bloc/groups_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../../Widgets/text_widget.dart';
import '../settings_screen.dart';
import '../wallet_screens/wallet_home_screen.dart';
import '../welcome_screen.dart';
import 'confirmation_screen.dart';
import 'create_group_screen.dart';
import 'my_group_screen.dart';

class JoinGroupScreen extends StatefulWidget {
  static const routeName = '/joinGroup';
  const JoinGroupScreen({Key? key}) : super(key: key);

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  GroupsBloc? groupsBloc;
  final int _selectedIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
        appBar: AppBar(
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'JOIN GROUP',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30, right: 30.0, top: 50, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormHeader('GROUP NAME'),
                      verticalSpacer(10),
                      CustomTextField(
                        name: 'groupName',
                        hint: 'Enter Group Name ......',
                        isdigit: false,
                      ),
                      verticalSpacer(30),
                      FormHeader('GROUP PASSWORD'),
                      verticalSpacer(10),
                      CustomTextField(
                        name: 'groupPass',
                        hint: 'Enter Group Password ......',
                        isdigit: false,
                      ),
                      // SmallSingleLeftTextBox(title: 'PMOPASSWORD'),
                      verticalSpacer(30),
                      FormHeader('GROUP PIN'),
                      verticalSpacer(10),
                      CustomTextField(
                        name: 'groupPin',
                        hint: 'Enter Group Pin ......',
                        isdigit: false,
                      ),
                      // const SmallSingleLeftTextBox(title: '0009'),
                      verticalSpacer(50),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const GeneralLargeTextBox(
                      name: 'FIDELITY PMO',
                      isImage: true,
                      imageUrl: 'assets/images/fidelity_bank.png',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                  ConfirmationScreen.routeName);
                            },
                            child: const ColouredTextBox(title: 'CONFIRM'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
