import 'package:cooler/Blocs/login_bloc/login_bloc.dart';
import 'package:cooler/Screens/auth_screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Helpers/colors.dart';
import '../../Widgets/bottom_navigation_bar.dart';
import '../../Widgets/gesture_detector_widget.dart';
import 'create_screen.dart';

enum LoginType { email, google }

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginBloc? loginBloc;

  String password = '';
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
    var loading = CircularProgressIndicator(
      color: white,
    );
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(32.0, 80.0, 0.0, 100.0),
                  child: Text(
                    'Log In.',
                    style: TextStyle(fontSize: 40.0, color: Colors.black),
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
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 70,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _passwordController,
                    validator: (input) => input!.length < 6
                        ? 'Password must be atleast 6 characters'
                        : null,
                    onSaved: (input) => password = input!,
                    autofillHints: const [AutofillHints.password],
                    cursorColor: Colors.black,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: _obscureText
                          ? IconButton(
                              icon: const Icon(Icons.visibility_off,
                                  color: Colors.black, size: 16),
                              onPressed: _toggle)
                          : IconButton(
                              icon: const Icon(Icons.visibility,
                                  color: Colors.black, size: 16),
                              onPressed: _toggle),
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: "Password",
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(220, 0, 5, 10),
                  child: InkWell(
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen(
                                    canPopScreen: true,
                                  )));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ResetPassword()));
                    },
                  ),
                ),
                const SizedBox(height: 40),

                BlocListener<LoginBloc, LoginState>(
                  listener: ((context, state) {
                    if (state is LoginSuccessfull) {
                      Navigator.pushReplacementNamed(
                          context, DashboardScreen.routeName);
                    }
                  }),
                  child: BlocBuilder<LoginBloc, LoginState>(
                      builder: ((context, state) {
                    if (state is LoginInProgress) {
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
                    } else if (state is LoginFailed) {
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
                        text: 'Login',
                        textColor: Colors.white,
                        onPress: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            loginBloc?.add(
                              LoginButtonPressed(
                                  email: _emailController.text,
                                  password: _passwordController.text),
                            );
                          }
                        });
                  })),
                ),

                // _loading
                //     ?
                //     :
                const SizedBox(height: 30),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                //   child: Center(
                //     child: Text(
                //       '- Or Sign up with -',
                //       style: TextStyle(fontSize: 16, color: Colors.white),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 30),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 50),
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
                //             const Text(
                //               'Google',
                //               style: TextStyle(
                //                   color: Color(0xFF2C6319),
                //                   fontWeight: FontWeight.w700,
                //                   fontSize: 18),
                //             ),
                //           ],
                //         ),
                //         onPressed: () {
                //           _loginUser(type: LoginType.google, context: context);
                //         },
                //       ),
                //     ),
                //   ),
                // ),

                // const SizedBox(height: 30),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8.0),
                      child: Center(
                        child: InkWell(
                          child: const Text(
                            'New User? Create account',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateScreen()));
                          },
                        ),
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
