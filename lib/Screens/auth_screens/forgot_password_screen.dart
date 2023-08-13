import 'package:cooler/Helpers/constants.dart';
import 'package:cooler/Screens/auth_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Blocs/auth_bloc/auth_bloc.dart';
import '../../Helpers/colors.dart';
import '../../Widgets/gesture_detector_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool canPopScreen;
  // static const routeName = '/forgot_pass';
  const ForgotPasswordScreen({this.canPopScreen = false, super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthBloc? authBloc;

  String email = '';
  final bool _loading = false;
  bool _obscureText = true;
  var loginUser;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _loginUser() async {}
  @override
  Widget build(BuildContext context) {
    //final firebaseProvider = Provider.of<FirebaseAuthentication>(context);
    var loading = const CircularProgressIndicator();
    authBloc = BlocProvider.of<AuthBloc>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        // backgroundColor: kBlueColor,
        body: SingleChildScrollView(
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 40.0, 0.0, 70.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reset Password.',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                      verticalSpacer(20),
                      const Text(
                        'A Password reset link will be sent to your mail',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _emailController,
                    validator: (input) =>
                        !input!.contains('@') ? 'Enter correct email' : null,
                    onSaved: (input) => email = input!,
                    autofillHints: const [AutofillHints.email],
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.3))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.3))),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                BlocListener<AuthBloc, AuthState>(
                  listener: ((context, state) {
                    if (state is PasswordResetSuccessful) {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                          content: Text(
                              'Password Reset Link Has Been Sent to Your Mail '),
                          backgroundColor: Colors.red,
                        ));
                    }
                  }),
                  child: BlocBuilder<AuthBloc, AuthState>(
                      builder: ((context, state) {
                    if (state is PasswordResetInProgress) {
                      return Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kBlueColor,
                            //padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: kBlueColor,
                                ),
                                child: loading,
                              ),
                              // GestureButtonWidget(
                              //     buttonColor: Colors.white,
                              //     text: 'Please wait!!!',
                              //     textColor: Color(0xFF2C6319)),
                              // Expanded(
                              //     child: Container(
                              //   alignment: Alignment.center,
                              //   child: Text(
                              //     "Please wait!!!",
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              // )),
                              //loading
                            ],
                          ),
                        ),
                      );
                    } else if (state is PasswordResetFailed) {
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
                        text: 'Reset Password',
                        textColor: Colors.white,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            authBloc?.add(
                              ForgotPasswordButtonPressed(
                                _emailController.text,
                              ),
                            );
                          }
                        });
                  })),
                ),
                const SizedBox(height: 30),
                Container(
                  child: Center(
                    child: InkWell(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      onTap: () {
                        if (widget.canPopScreen) {
                          Navigator.pop(context);
                        } else {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        }
                      },
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
