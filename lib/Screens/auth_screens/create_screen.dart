import 'dart:io';

import 'package:cooler/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../Blocs/signup_bloc/signup_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Helpers/constants.dart';
import '../../Widgets/gesture_detector_widget.dart';
import './login_screen.dart';

enum SignUpType { email, google }

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  File? image;
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String confirmPass = "";
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();
  SignupBloc? signupBloc;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _latNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _employerNumberController =
      TextEditingController();

  bool _obscureText = true;
  bool _obscure = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _obscure = !_obscure;
    });
  }

  Future<String?> onPickImage() async {
    setState(() {
      _loading = true;
    });
    try {
      final imagePicked =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imagePicked != null) {
        return imagePicked.path;
      } else {
        return null;
      }
    } catch (e) {
      print("this is it --->");
      print(e.toString());
    }
    return null;
  }

  void signUpUser(
      {required SignUpType type,
      String? email,
      String? password,
      String? firstName,
      String? lastName,
      BuildContext? context}) async {
    // final firebaseAuth =
    //     Provider.of<FirebaseAuthentication>(context!, listen: false);

    @override
    void initState() {
      // Firebase.initializeApp().whenComplete(() {
      //   _auth = FirebaseAuthentication();
      //   setState(() {});
      // });
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    var loading = const CircularProgressIndicator();
    signupBloc = BlocProvider.of<SignupBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: background,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 30.0),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: _loading
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : image == null
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                      icon: const Icon(Icons.image),
                                      onPressed: () async {
                                        print(1);
                                        var imagePath = await onPickImage();
                                        setState(() {
                                          _loading = false;
                                        });
                                        if (imagePath == null) {
                                          Future.delayed(Duration.zero, () {
                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Failed to pick an Image"),
                                                backgroundColor: Colors.black,
                                              ));
                                          });
                                        } else {
                                          final tempimage =
                                              File(imagePath.toString());
                                          setState(() {
                                            image = tempimage;
                                          });
                                        }
                                      }),
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                  ),

                  verticalSpacer(25),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   'First Name',
                          //   style: TextStyle(color: kTextColor, fontSize: 16),
                          // ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            width: 170,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _firstNameController,
                              validator: (input) => input!.trim().isEmpty
                                  ? 'Enter your FirstName'
                                  : null,
                              onSaved: (input) => firstName = input!,
                              cursorColor: kMainColor,
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                    color: kTextColor, fontSize: 20.0),
                                hintText: 'First Name',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kBorderLineColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kMainColor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text(
                            //   'Last Name',
                            //   style: TextStyle(color: kTextColor, fontSize: 16),
                            // ),
                            const SizedBox(height: 5),
                            Container(
                              width: 150,
                              height: 50,
                              padding: const EdgeInsets.only(left: 12),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _latNameController,
                                validator: (input) => input!.trim().isEmpty
                                    ? 'Enter your LastName'
                                    : null,
                                onSaved: (input) => lastName = input!,
                                cursorColor: kMainColor,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                      color: kTextColor, fontSize: 20.0),
                                  hintText: 'Last Name',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kBorderLineColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kMainColor)),
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),

                  const SizedBox(height: 25),
                  // const Text(
                  //   'Email Address',
                  //   style: TextStyle(color: kTextColor, fontSize: 16),
                  // ),

                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _emailAddressController,
                      validator: (input) =>
                          !input!.contains('@') ? 'Enter correct email' : null,
                      onSaved: (input) => email = input!,
                      cursorColor: kMainColor,
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(color: kTextColor, fontSize: 20.0),
                        hintText: 'Email Address',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kBorderLineColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kMainColor)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // const Text(
                  //   'Employer Number',
                  //   style: TextStyle(color: kTextColor, fontSize: 16),
                  // ),

                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _employerNumberController,
                      cursorColor: kMainColor,
                      keyboardType: TextInputType.number,
                      validator: (input) => input!.trim().isEmpty
                          ? 'Emplyer number is a required field'
                          : null,
                      decoration: const InputDecoration(
                        labelStyle:
                            TextStyle(color: kTextColor, fontSize: 20.0),
                        hintText: 'Employer Number',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kBorderLineColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kMainColor)),
                      ),
                    ),
                  ),

                  // const SizedBox(height: 25),
                  // const Text(
                  //   'Phone number',
                  //   style: TextStyle(color: kTextColor, fontSize: 16),
                  // ),
                  // const SizedBox(height: 5),

                  // SizedBox(
                  //   height: 50,
                  //   child: TextFormField(
                  //     textInputAction: TextInputAction.next,
                  //     controller: _phoneNoController,
                  //     onSaved: (input) => phoneNumber = input!,
                  //     cursorColor: kMainColor,
                  //     decoration: const InputDecoration(
                  //       labelStyle:
                  //           TextStyle(color: kTextColor, fontSize: 20.0),
                  //       hintText: 'Phone number',
                  //       floatingLabelBehavior: FloatingLabelBehavior.always,
                  //       enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: kBorderLineColor)),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: kMainColor)),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 25),
                  // const Text(
                  //   'Password',
                  //   style: TextStyle(color: kTextColor, fontSize: 16),
                  // ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _passwordController,
                      validator: (input) => input!.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                      onSaved: (input) => password = input!,
                      obscureText: _obscure,
                      cursorColor: kMainColor,
                      decoration: InputDecoration(
                        suffixIcon: _obscure
                            ? IconButton(
                                icon: const Icon(Icons.visibility_off,
                                    color: kMainColor, size: 16),
                                onPressed: _toggle)
                            : IconButton(
                                icon: const Icon(Icons.visibility,
                                    color: kMainColor, size: 16),
                                onPressed: _toggle),
                        labelStyle:
                            const TextStyle(color: kTextColor, fontSize: 20.0),
                        hintText: 'Password',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kBorderLineColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kMainColor)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // const Text(
                  //   'Confirm Password',
                  //   style: TextStyle(color: kTextColor, fontSize: 16),
                  // ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: _confirmPassController,
                      validator: (input) => input!.length < 6
                          ? 'Password must be atleast 6 characters'
                          : null,
                      onSaved: (input) => password = input!,
                      cursorColor: kMainColor,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: _obscureText
                            ? IconButton(
                                icon: const Icon(Icons.visibility_off,
                                    color: kMainColor, size: 16),
                                onPressed: _toggle)
                            : IconButton(
                                icon: const Icon(Icons.visibility,
                                    color: kMainColor, size: 16),
                                onPressed: _toggle),
                        labelStyle:
                            const TextStyle(color: kTextColor, fontSize: 20.0),
                        hintText: 'Confirm Password',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kBorderLineColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: kMainColor)),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 30),
                  // GestureButtonWidget(
                  //     buttonColor: kMainColor,
                  //     text: 'Sign Up',
                  //     textColor: Colors.white,
                  //     onPress: () {
                  //       // setState(() {
                  //       //   _loading = true;
                  //       // });
                  //       if (_formKey.currentState!.validate() &&
                  //           _passwordController.text ==
                  //               _confirmPassController.text) {
                  //         signupBloc?.add(
                  //           SignUpButtonPressed(
                  //             email: _emailAddressController.text,
                  //             firstName: _firstNameController.text,
                  //             lastName: _latNameController.text,
                  //             password: _passwordController.text,
                  //           ),
                  //         );
                  //       } else {
                  //         setState(() {
                  //           _loading = false;
                  //         });
                  //       }
                  //     }),

                  const SizedBox(height: 30),
                  // _loading
                  //     ? Container(
                  //         height: 50,
                  //         margin: const EdgeInsets.symmetric(horizontal: 60),
                  //         child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: kMainColor,
                  //             padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(100),
                  //             ),
                  //           ),
                  //           onPressed: () {},
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Container(
                  //                 decoration: const BoxDecoration(
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(100)),
                  //                   color: kMainColor,
                  //                 ),
                  //                 child: loading,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     :
                  BlocListener<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is SignupSuccessful) {
                        Navigator.pushReplacementNamed(
                            context, DashboardScreen.routeName);
                      }
                    },
                    child: BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        if (state is SignupInProgress) {
                          return Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 60),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kBlueColor,
                                padding:
                                    const EdgeInsets.fromLTRB(80, 0, 80, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      color: kBlueColor,
                                    ),
                                    child: loading,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is SignupFailed) {
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

                        return GestureButtonWidget(
                            buttonColor: kBlueColor,
                            text: 'Sign Up',
                            textColor: Colors.white,
                            onPress: () {
                              // setState(() {
                              //   _loading = true;
                              // });
                              FocusScope.of(context).unfocus();
                              var validate = _formKey.currentState?.validate();
                              if (image == null) {
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
                              if (_formKey.currentState!.validate() &&
                                  _passwordController.text ==
                                      _confirmPassController.text) {
                                FocusScope.of(context).unfocus();
                                // if (_employerNumberController.text.isEmpty) {
                                //   _employerNumberController.text = "0";
                                // }
                                signupBloc?.add(
                                  SignUpButtonPressed(
                                    image: image!,
                                    email: _emailAddressController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _latNameController.text,
                                    password: _passwordController.text,
                                    employerNumber: int.parse(
                                        _employerNumberController.text),
                                  ),
                                );
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                              }
                            });

                        // }
                        // print('nothing $state');
                        // return Container();
                        // print('buildernothing $state');
                      },
                    ),
                  ),
                  // const SizedBox(height: 30),
                  // Center(
                  //   child: Text(
                  //     '- Or Sign up with -',
                  //     style: TextStyle(fontSize: 16, color: kDeepColor),
                  //   ),
                  // ),
                  // const SizedBox(height: 30),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 18),
                  //   child: Center(
                  //     child: Container(
                  //       height: 45,
                  //       margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  //       child: ElevatedButton(
                  //         // shape: RoundedRectangleBorder(
                  //         //     borderRadius: BorderRadius.circular(100.0),
                  //         //     side: BorderSide(color: Colors.white)),
                  //         // elevation: 5,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             Image.asset('assets/images/google_logo.png',
                  //                 height: 30.0),
                  //             const SizedBox(width: 10),
                  //             Text(
                  //               'Google',
                  //               style: TextStyle(
                  //                   color: kDeepColor,
                  //                   fontWeight: FontWeight.w700,
                  //                   fontSize: 18),
                  //             ),
                  //           ],
                  //         ),
                  //         onPressed: () {
                  //           signUpUser(
                  //               type: SignUpType.google, context: context);
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(fontSize: 16, color: kDeepColor),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Already have an account?',
                            style: TextStyle(fontSize: 16, color: kDeepColor),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          child: const Text(
                            'Login',
                            style: TextStyle(color: kMainColor, fontSize: 16.0),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   // TODO: implement build
//   throw UnimplementedError();
// }
