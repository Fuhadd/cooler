import 'dart:io';

import 'package:cooler/Screens/wallet_screens/wallet_home_screen.dart';
import 'package:cooler/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../Blocs/image_bloc/image_bloc.dart';
import '../Repositories/user_repository.dart';
import 'auth_screens/forgot_password_screen.dart';
import 'auth_screens/login_screen.dart';
import 'group_screens/my_group_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/walletHome';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final int _selectedIndex = 3;

  File? _image;
  ImageBloc? imageBloc;

  final ImagePicker _picker = ImagePicker();
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

  void _showImageSourceOptions(ImageBloc? imageBloc) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () async {
                    await _getImage(ImageSource.gallery);
                    Navigator.pop(context);
                    if (_image != null) {
                      imageBloc?.add(UpdateImageButtonPressed(_image!));
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () {
                    _getImage(ImageSource.camera);
                    Navigator.pop(context);
                    if (_image != null) {
                      imageBloc?.add(UpdateImageButtonPressed(_image!));
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    imageBloc = BlocProvider.of<ImageBloc>(context);
    return SafeArea(
      child: Scaffold(
        // drawer: const CustomNavigationDrawer(
        //   pageIndex: 2,
        // ),
        bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kMainColor),
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'SETTINGS',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30, right: 30.0, top: 60, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocListener<ImageBloc, ImageState>(
                  listener: ((context, state) {
                    if (state is UpdateImageSuccessful) {
                      // Navigator.pushReplacementNamed(
                      //     context, LoginScreen.routeName);
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                          content: Text(
                              'Profile Image has been updated successfully '),
                          backgroundColor: Colors.green,
                        ));
                    }
                  }),
                  child: BlocBuilder<ImageBloc, ImageState>(
                      builder: ((context, state) {
                    if (state is UpdateImageInProgress) {
                      return GestureDetector(
                        onTap: () {
                          _showImageSourceOptions(imageBloc);
                        },
                        child: Card(
                          color: kBlueColor,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      )),
                                ),
                                horizontalSpacer(20),
                                const Text('Update Profile Picture')
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state is UpdateImageFailed) {
                      Future.delayed(Duration.zero, () {
                        // Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ));
                      });
                    }

                    return GestureDetector(
                      onTap: () {
                        _showImageSourceOptions(imageBloc);
                      },
                      child: Card(
                        color: kBlueColor,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.mode_edit),
                              horizontalSpacer(20),
                              const Text('Update Profile Picture')
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: kBlueColor,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.mode_edit),
                          horizontalSpacer(20),
                          const Text('Update Payout Link')
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, ForgotPasswordScreen.routeName);
                  },
                  child: Card(
                    color: kBlueColor,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.mode_edit),
                          horizontalSpacer(20),
                          const Text('Change/Reset Password')
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    UserRepository().logOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Card(
                    color: kBlueColor,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.mode_edit),
                          horizontalSpacer(20),
                          const Text('LOGOUT')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
