import 'package:cooler/Screens/group_screens/view_members_screen.dart';
import 'package:cooler/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../Blocs/group_bloc/groups_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Models/user_model.dart';
import '../../Repositories/user_repository.dart';
import '../../Widgets/texboxtbox_widgets.dart';
import '../../Widgets/text_widget.dart';
import 'create_group_screen.dart';

class PrivateCoolerScreen extends StatefulWidget {
  static const routeName = '/PrivateCooler';
  const PrivateCoolerScreen({Key? key}) : super(key: key);

  @override
  State<PrivateCoolerScreen> createState() => _PrivateCoolerScreenState();
}

class _PrivateCoolerScreenState extends State<PrivateCoolerScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  GroupsBloc? groupsBloc;
  AppUser? currentUser;
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
      child: currentUser == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: kMainColor),
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(WelcomeScreen.routeName),
                ),
                backgroundColor: background,
                centerTitle: true,
                title: const Text(
                  'PRIVATE COOLER',
                  style: TextStyle(
                      fontSize: 21,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
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
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.minLength(4,
                                      errorText:
                                          'A valid group name should be greater than 4 characters '),
                                ],
                              ),
                            ),
                            verticalSpacer(30),
                            FormHeader('GROUP PASSWORD'),
                            verticalSpacer(10),
                            CustomTextField(
                              name: 'groupPass',
                              hint: 'Enter Group Password ......',
                              isdigit: false,
                            ),
                            //  SmallSingleLeftTextBox(title: 'PMOPASSWORD'),
                            verticalSpacer(30),
                            FormHeader('GROUP PIN'),
                            verticalSpacer(10),
                            CustomTextField(
                              name: 'groupPin',
                              hint: 'Enter Group Pin ......',
                              isdigit: true,
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                      errorText: 'This is a required field'),
                                  FormBuilderValidators.integer(
                                      errorText: 'A valid pin be in digit '),
                                  FormBuilderValidators.minLength(3,
                                      errorText:
                                          'A valid pin should be greater than 3 characters '),
                                ],
                              ),
                            ),
                            // const SmallSingleLeftTextBox(title: '0009'),
                            verticalSpacer(50),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const GeneralLargeTextBox(
                            name: 'CHASE PMO',
                            isImage: true,
                            imageUrl: 'assets/images/chase_logo.png',
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          BlocListener<GroupsBloc, GroupsState>(
                            listener: (context, state) {
                              if (state is JoinPrivateGroupSuccessfull) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          ViewGroupMembersScreen(
                                            showInviteColumn: false,
                                            button: 'LEAVE',
                                            group: state.group!,
                                          )),
                                );
                              }
                            },
                            child: BlocBuilder<GroupsBloc, GroupsState>(
                              builder: (context, state) {
                                if (state is JoinPrivateGroupInProgress) {
                                  return const SizedBox(
                                      width: double.infinity,
                                      child: ColouredLoadingBox());
                                } else if (state is JoinPrivateGroupFailed) {
                                  if (state.message == 'Not Found') {
                                    Future.delayed(Duration.zero, () {
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(const SnackBar(
                                          content: Text(
                                              'Incorrect Group Name or Pin'),
                                          backgroundColor: Colors.red,
                                        ));
                                    });
                                  } else {
                                    Future.delayed(Duration.zero, () {
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                          content: Text(state.message),
                                          backgroundColor: Colors.red,
                                        ));
                                    });
                                  }
                                }

                                return SizedBox(
                                    width: double.infinity,
                                    child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          var validate =
                                              _formKey.currentState?.validate();

                                          if (validate == true) {
                                            _formKey.currentState?.save();

                                            var groupName = _formKey
                                                .currentState
                                                ?.fields['groupName']
                                                ?.value
                                                .toString()
                                                .trim();

                                            var pin = _formKey.currentState
                                                ?.fields['groupPin']?.value
                                                .toString()
                                                .trim();

                                            groupsBloc?.add(JoinPrivateGroupEvent(
                                                inviteeUserId: currentUser!.id!,
                                                memberEmail: currentUser!.email,
                                                memberImageUrl:
                                                    currentUser!.imageUrl,
                                                memberUserId: currentUser!.id!,
                                                memberName:
                                                    '${currentUser!.lastName} ${currentUser!.firstName}',
                                                pin: pin!,
                                                groupName: groupName!));
                                          }
                                        },
                                        child: const ColouredTextBox(
                                            title: 'CONFIRM')));
                              },
                            ),
                          ),
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
