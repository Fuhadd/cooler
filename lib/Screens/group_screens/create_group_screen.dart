import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// import '../../Blocs/group_bloc/groups_bloc.dart';
import '../../Blocs/group_bloc/groups_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Models/user_model.dart';
import '../../Repositories/user_repository.dart';
import '../../Widgets/bottom_navigation_bar.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../../Widgets/text_widget.dart';
import '../settings_screen.dart';
import '../wallet_screens/wallet_home_screen.dart';
import '../welcome_screen.dart';
import 'my_group_screen.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  static const routeName = '/createGroup';
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  File? image;
  int _selectedIndex = 1;
  final _formKey = GlobalKey<FormBuilderState>();
  GroupsBloc? groupsBloc;
  late AppUser? currentUser;
  bool _loading = false;
  final List<Widget> _pages = [
    const WelcomeScreen(),
    const MyGroupsScreen(),
    const WalletHomeScreen(),
    const SettingsScreen(),
  ];

  Future<String?> onPickImage() async {
    setState(() {
      _loading = true;
    });
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      return imagePicked.path;
    } else {
      return null;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const WelcomeScreen(),
    const MyGroupsScreen(),
    const WalletHomeScreen(),
    const SettingsScreen(),
  ];

  Widget buildBottomNavigationBar(int menuIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kBlueColor,
      unselectedItemColor: iconGreyColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedFontSize: 14,
      unselectedFontSize: 13,
      backgroundColor: white,
      // selectedLabelStyle: TextStyle(
      //   fontSize: 12.sp,
      //   fontWeight: FontWeight.w500,
      //   color: CustomColors.deepGoldColor,
      // ),
      // unselectedLabelStyle: TextStyle(
      //   fontSize: 12.sp,
      //   fontWeight: FontWeight.w500,
      //   color: CustomColors.grayBackgroundColor,
      // ),
      currentIndex: menuIndex,
      onTap: (i) {
        ref.read(indexProvider.notifier).state = i;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/home_icon.svg',
              color: iconGreyColor),
          label: 'Home',
          activeIcon: SizedBox(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/home_icon.svg',
                    color: kBlueColor),
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: UShapePainter(),
                  ),
                )
              ],
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/cooler_icon.svg'),
          label: 'Savings',
          activeIcon: SizedBox(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/cooler_icon.svg',
                    color: kBlueColor),
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: UShapePainter(),
                  ),
                )
              ],
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/wallet_icon.svg',
            // height: 20,
          ),
          label: 'Investments',
          activeIcon: SizedBox(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/wallet_icon.svg',
                    color: kBlueColor),
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: UShapePainter(),
                  ),
                )
              ],
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/settings_icon.svg',
              // height: 22.h,
              color: iconGreyColor),
          label: 'Wallet',
          activeIcon: SizedBox(
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/settings_icon.svg',
                    color: kBlueColor),
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CustomPaint(
                    painter: UShapePainter(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
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

  bool _showContainer = false;
  String _radioValue = 'off';

  @override
  Widget build(BuildContext context) {
    groupsBloc = BlocProvider.of<GroupsBloc>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    final menuIndex = ref.watch(indexProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        bottomNavigationBar: buildBottomNavigationBar(menuIndex),
        // bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
        // bottomNavigationBar: BuildBottomNavigationBar(
        //   selectedIndex: 1,
        // ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: background,
          centerTitle: true,
          title: const Text(
            'Create Cooler',
            style: TextStyle(
                fontSize: 21, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                          // Center(
                          //   child: _loading
                          //       ? Container(
                          //           height: 100,
                          //           width: 100,
                          //           decoration: BoxDecoration(
                          //             border: Border.all(
                          //               color: Colors.grey,
                          //               width: 1,
                          //             ),
                          //           ),
                          //           child: const Center(
                          //             child: CircularProgressIndicator(),
                          //           ),
                          //         )
                          //       : image == null
                          //           ? Container(
                          //               height: 100,
                          //               width: 100,
                          //               decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                   color: Colors.grey,
                          //                   width: 1,
                          //                 ),
                          //               ),
                          //               child: Center(
                          //                 child: IconButton(
                          //                     icon: const Icon(Icons.image),
                          //                     onPressed: () async {
                          //                       var imagePath =
                          //                           await onPickImage();
                          //                       setState(() {
                          //                         _loading = false;
                          //                       });
                          //                       if (imagePath == null) {
                          //                         Future.delayed(Duration.zero,
                          //                             () {
                          //                           ScaffoldMessenger.of(
                          //                               context)
                          //                             ..removeCurrentSnackBar()
                          //                             ..showSnackBar(
                          //                                 const SnackBar(
                          //                               content: Text(
                          //                                   "Failed to pick an Image"),
                          //                               backgroundColor:
                          //                                   Colors.black,
                          //                             ));
                          //                         });
                          //                       } else {
                          //                         final tempimage = File(
                          //                             imagePath.toString());
                          //                         setState(() {
                          //                           image = tempimage;
                          //                         });
                          //                       }
                          //                     }),
                          //               ),
                          //             )
                          //           : Container(
                          //               height: 100,
                          //               width: 100,
                          //               decoration: BoxDecoration(
                          //                 image: DecorationImage(
                          //                     image: FileImage(image!),
                          //                     fit: BoxFit.cover),
                          //                 border: Border.all(
                          //                   color: Colors.grey,
                          //                   width: 1,
                          //                 ),
                          //               ),
                          //             ),
                          // ),
                          // verticalSpacer(25),
                          FormHeader('Name'),
                          verticalSpacer(5),
                          // const SmallSingleLeftTextBox(title: 'FEMI SAVERS'),
                          CustomTextField(
                            name: 'groupName',
                            // hint: 'Enter Group Name ......',
                            hint: '',
                            isdigit: false,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.minLength(4,
                                    errorText:
                                        'A valid group name should be greater than 4 characters '),
                              ],
                            ),
                          ),
                          verticalSpacer(15),

                          FormHeader('Fee'),
                          verticalSpacer(5),
                          CustomTextField(
                            name: 'amount',
                            // hint: 'Enter Set Amount ......',
                            hint: '',
                            isdigit: true,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'This is a required field'),
                                FormBuilderValidators.integer(
                                    errorText:
                                        'A valid pin should be in digit '),
                                // FormBuilderValidators.minLength(3,
                                //     errorText:
                                //         'A valid pin should be greater than 3 characters '),
                              ],
                            ),
                          ),
                          //  SmallSingleLeftTextBox(title: 'N100,000'),
                          verticalSpacer(15),
                          FormHeader('Max'),
                          verticalSpacer(5),
                          CustomTextField(
                            name: 'noOfSavers',
                            // hint: 'Enter Savers No ......',
                            hint: '',
                            isdigit: true,
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'This is a required field'),
                                FormBuilderValidators.integer(
                                    errorText:
                                        'A valid No.Of Savers be in digit '),
                                FormBuilderValidators.max(12,
                                    errorText:
                                        'A valid NO. Of Savers should be less than 12'),
                                FormBuilderValidators.min(1,
                                    errorText:
                                        'A valid NO. Of Savers should be greater than 1'),
                              ],
                            ),
                          ),
                          // const SmallSingleLeftTextBox(title: '12'),
                          verticalSpacer(15),
                          FormHeader('Start'),
                          verticalSpacer(5),
                          CustomDateField(
                            name: 'startDate',
                            // hint: 'Click to select Start Date ......',
                            hint: '',
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'This is a required field'),
                              ],
                            ),
                          ),
                          verticalSpacer(15),
                          FormHeader('Payout'),
                          verticalSpacer(5),
                          CustomDateField(
                            name: 'payoutDate',
                            // hint: 'Click to select Start Date ......',
                            hint: '',
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(
                                    errorText: 'This is a required field'),
                              ],
                            ),
                          ),
                          verticalSpacer(10),

                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                            // title: const Text('Off'),
                                            value: 'off',
                                            activeColor: kBlueColor,
                                            groupValue: _radioValue,
                                            onChanged: (value) {
                                              setState(() {
                                                _radioValue = value!;
                                                _showContainer = false;
                                              });
                                            },
                                          ),
                                          FormHeader('Public'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            // title: const Text('On'),
                                            value: 'on',
                                            activeColor: kBlueColor,
                                            groupValue: _radioValue,
                                            onChanged: (value) {
                                              setState(() {
                                                _radioValue = value!;
                                                _showContainer = true;
                                              });
                                            },
                                          ),
                                          FormHeader('Private'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _showContainer == true
                              ? Row(
                                  children: [
                                    FormHeader('Pin'),
                                    horizontalSpacer(10),
                                    Expanded(
                                      child: CustomTextField(
                                        name: 'pin',
                                        hint: '',
                                        isdigit: true,
                                        validator:
                                            FormBuilderValidators.compose(
                                          [
                                            FormBuilderValidators.required(
                                                errorText:
                                                    'This is a required field'),
                                            FormBuilderValidators.integer(
                                                errorText:
                                                    'A valid pin be in digit '),
                                            FormBuilderValidators.minLength(3,
                                                errorText:
                                                    'A valid pin should be greater than 3 characters '),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : verticalSpacer(10),

                          // const SmallSingleLeftTextBox(title: '01 - 02 - 2023'),
                          verticalSpacer(40),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        // SizedBox(
                        //     width: double.infinity,
                        //     child: GestureDetector(
                        //         onTap: () {
                        //           FocusScope.of(context).unfocus();
                        //           var validate = _formKey.currentState?.validate();

                        //           if (validate == true) {
                        //             _formKey.currentState?.save();
                        //             var status =
                        //                 value == true ? 'private' : 'public';
                        //             var groupName = _formKey
                        //                 .currentState?.fields['groupName']?.value
                        //                 .toString()
                        //                 .trim();

                        //             var password = _formKey
                        //                 .currentState?.fields['password']?.value
                        //                 .toString()
                        //                 .trim();
                        //             var pin =
                        //                 _formKey.currentState?.fields['pin']?.value;
                        //             var amount = int.parse(_formKey
                        //                 .currentState?.fields['amount']?.value);
                        //             var noOfSavers = int.parse(_formKey
                        //                 .currentState?.fields['noOfSavers']?.value);
                        //             var startDate = _formKey
                        //                 .currentState?.fields['startDate']?.value;

                        //             groupsBloc?.add(CreateGroupEvent(
                        //                 status: status,
                        //                 groupName: groupName!,
                        //                 amount: amount,
                        //                 noOfSavers: noOfSavers,
                        //                 startDate: startDate));

                        //           }

                        //         },
                        //         child: const ColouredTextBox(title: 'CONFIRM'))),

                        BlocListener<GroupsBloc, GroupsState>(
                          listener: (context, state) {
                            if (state is CreateGroupSuccessfull) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        const MyGroupsScreen()),
                              );
                            }
                          },
                          child: BlocBuilder<GroupsBloc, GroupsState>(
                            builder: (context, state) {
                              if (state is CreateGroupInProgress) {
                                return const SizedBox(
                                    width: double.infinity,
                                    child: ColouredLoadingBox());
                              } else if (state is CreateGroupFailed) {
                                Future.delayed(Duration.zero, () {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                      content: Text(state.message),
                                      backgroundColor: Colors.red,
                                    ));
                                });
                              }

                              return SizedBox(
                                  width: double.infinity,
                                  child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        var validate =
                                            _formKey.currentState?.validate();
                                        // if (image == null) {
                                        if (false) {
                                          validate = false;
                                          Future.delayed(Duration.zero, () {
                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Profile Image Field Cannot Be Empty'),
                                                backgroundColor: Colors.red,
                                              ));
                                          });
                                        }

                                        if (validate == true) {
                                          _formKey.currentState?.save();
                                          var status = _showContainer == true
                                              ? 'private'
                                              : 'public';
                                          var groupName = _formKey.currentState
                                              ?.fields['groupName']?.value
                                              .toString()
                                              .trim();

                                          var password = _formKey.currentState
                                              ?.fields['password']?.value
                                              .toString()
                                              .trim();
                                          var pin = _formKey.currentState
                                              ?.fields['pin']?.value;
                                          var amount = int.parse(_formKey
                                              .currentState
                                              ?.fields['amount']
                                              ?.value);
                                          var noOfSavers = int.parse(_formKey
                                              .currentState
                                              ?.fields['noOfSavers']
                                              ?.value);
                                          var startDate = _formKey.currentState
                                              ?.fields['startDate']?.value;
                                          if (pin == null) {
                                            groupsBloc?.add(CreateGroupEvent(
                                              // image: image!,
                                              status: status,
                                              groupName: groupName!,
                                              amount: amount,
                                              noOfSavers: noOfSavers,
                                              startDate: startDate,
                                              memberUserId: currentUser!.id!,
                                              inviteeUserId: currentUser!.id!,
                                              memberEmail: currentUser!.email,
                                              memberImageUrl:
                                                  currentUser!.imageUrl,

                                              memberName:
                                                  '${currentUser!.lastName} ${currentUser!.firstName}',
                                            ));
                                          } else {
                                            groupsBloc?.add(CreateGroupEvent(
                                              // image: image!,
                                              status: status,
                                              groupName: groupName!,
                                              amount: amount,
                                              noOfSavers: noOfSavers,
                                              startDate: startDate,
                                              pin: pin,
                                              memberUserId: currentUser!.id!,
                                              inviteeUserId: currentUser!.id!,
                                              memberEmail: currentUser!.email,
                                              memberImageUrl:
                                                  currentUser!.imageUrl,
                                              memberName:
                                                  '${currentUser!.lastName} ${currentUser!.firstName}',
                                            ));
                                          }
                                        }
                                      },
                                      child: const ColouredTextBox(
                                          title: 'SUBMIT')));

                              // }
                              // print('nothing $state');
                              // return Container();
                              // print('buildernothing $state');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRowTextField extends StatelessWidget {
  final String name;
  final String hint;
  final bool isdigit;
  String? Function(String?)? validator;
  CustomRowTextField({
    required this.name,
    required this.hint,
    required this.isdigit,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: kMainColor,
      // color: Colors.amber,
      child: FormBuilderTextField(
        name: name,
        // maxLength: 10,

        validator: validator,
        keyboardType: isdigit ? TextInputType.number : null,
        decoration: InputDecoration(
          suffixIcon: Container(
            height: 50,
            width: 80,
            color: kBlueColor,
            child: const Center(
              child: Text(
                'Search',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          // hintText: hint,
          // labelText: 'test',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: kMainColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: kMainColor, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          // icon: const Icon(Icons.abc)

          // floatingLabelBehavior: FloatingLabelBehavior.always // for the floatimg label
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String name;
  final String hint;
  final bool isdigit;
  String? Function(String?)? validator;
  CustomTextField({
    required this.name,
    required this.hint,
    required this.isdigit,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: kMainColor,
      color: background,
      child: FormBuilderTextField(
        name: name,
        // maxLength: 10,
        validator: validator,
        keyboardType: isdigit ? TextInputType.number : null,
        decoration: InputDecoration(
          hintText: hint,
          // labelText: 'test',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: kMainColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: kMainColor, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          // icon: const Icon(Icons.abc)

          // floatingLabelBehavior: FloatingLabelBehavior.always // for the floatimg label
        ),
      ),
    );
  }
}

class CustomDateField extends StatelessWidget {
  final String name;
  final String hint;
  String? Function(DateTime?)? validator;

  CustomDateField({
    required this.name,
    required this.hint,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey,
      color: background,
      child: FormBuilderDateTimePicker(
        name: name,
        format: DateFormat('yyyy-MM-dd'),
        validator: validator,
        transitionBuilder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: kMainColor, // <-- SEE HERE
                // onPrimary: Colors.red, // <-- SEE HERE
                // onSurface: Colors.red, // <-- SEE HERE
              ),
            ),
            child: child!,
          );
        },

        // maxLength: 10,
        inputType: InputType.date,
        decoration: InputDecoration(
          hintText: hint,
          // labelText: 'test',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: kMainColor, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          // icon: const Icon(Icons.abc)

          // floatingLabelBehavior: FloatingLabelBehavior.always // for the floatimg label
        ),
      ),
    );
  }
}
