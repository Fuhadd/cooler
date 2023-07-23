import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Blocs/auth_bloc/auth_bloc.dart';
import 'Blocs/group_bloc/groups_bloc.dart';
import 'Blocs/image_bloc/image_bloc.dart';
import 'Blocs/login_bloc/login_bloc.dart';
import 'Blocs/signup_bloc/signup_bloc.dart';
import 'Helpers/theme.dart';
import 'Repositories/firebase_storage_repository.dart';
import 'Repositories/firestore_repository.dart';
import 'Repositories/user_repository.dart';
import 'Screens/auth_screens/forgot_password_screen.dart';
import 'Screens/auth_screens/login_screen.dart';
import 'Screens/group_screens/confirmation_screen.dart';
import 'Screens/group_screens/contribute_screen.dart';
import 'Screens/group_screens/create_group_screen.dart';
import 'Screens/group_screens/invite_members.dart';
import 'Screens/group_screens/join_group_screen.dart';
import 'Screens/group_screens/my_group_screen.dart';
import 'Screens/group_screens/private_cooler.dart';
import 'Screens/group_screens/public_cooler_screen.dart';
import 'Screens/group_screens/select_group_type.dart';
import 'Screens/loan_screens/loan_apply_screen.dart';
import 'Screens/loan_screens/loan_center_screen.dart';
import 'Screens/loan_screens/make_payment_screen.dart';
import 'Screens/loan_screens/view_loan_screen.dart';
import 'Screens/splash_screen.dart';
import 'Screens/wallet_screens/wallet_home_screen.dart';
import 'Screens/wallet_screens/wallet_transfer_screen.dart';
import 'Screens/wallet_screens/wallet_withdraw_screen.dart';
import 'Screens/welcome_screen.dart';
import 'Widgets/bottom_navigation_bar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    final firestoreRepository = FirestoreRepository();
    final firebaseStorageRepository = FirebaseStorageRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(userRepository, firestoreRepository),
        ),
        BlocProvider(
          create: (context) => SignupBloc(
              userRepository, firestoreRepository, firebaseStorageRepository),
        ),
        BlocProvider(
          create: (context) =>
              GroupsBloc(firestoreRepository, firebaseStorageRepository),
        ),
        BlocProvider(
          create: (context) => AuthBloc(userRepository),
        ),
        BlocProvider(
          create: (context) =>
              ImageBloc(firestoreRepository, firebaseStorageRepository),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else if (snapshot.hasData) {
                  return const DashboardScreen();
                } else {
                  return const LoginScreen();
                }
              }),

          // home: const DashboardScreen(),
          routes: {
            // HomeScreen.routeName: (context) => const HomeScreen(),
            ForgotPasswordScreen.routeName: (context) =>
                const ForgotPasswordScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            WelcomeScreen.routeName: (context) => const WelcomeScreen(),
            ConfirmationScreen.routeName: (context) =>
                const ConfirmationScreen(),
            CreateGroupScreen.routeName: (context) => const CreateGroupScreen(),
            // GroupsScreen.routeName: (context) => const GroupsScreen(),
            JoinGroupScreen.routeName: (context) => const JoinGroupScreen(),
            // ViewMembersScreen.routeName: (context) => const ViewMembersScreen(),
            LoanApplyScreen.routeName: (context) => const LoanApplyScreen(),
            LoanCenterScreen.routeName: (context) => const LoanCenterScreen(),
            MakePaymentScreen.routeName: (context) => const MakePaymentScreen(),
            ViewLoanScreen.routeName: (context) => const ViewLoanScreen(),
            WalletHomeScreen.routeName: (context) => const WalletHomeScreen(),
            WalletTransferScreen.routeName: (context) =>
                const WalletTransferScreen(),
            WalletWithdrawScreen.routeName: (context) =>
                const WalletWithdrawScreen(),
            PublicCoolerScreen.routeName: (context) =>
                const PublicCoolerScreen(),
            SelectGroupTypeScreen.routeName: (context) =>
                const SelectGroupTypeScreen(),
            ContributeScreen.routeName: (context) => const ContributeScreen(),
            InviteMembersScreen.routeName: (context) =>
                const InviteMembersScreen(),
            PrivateCoolerScreen.routeName: (context) =>
                const PrivateCoolerScreen(),
            MyGroupsScreen.routeName: (context) => const MyGroupsScreen(),

            DashboardScreen.routeName: (context) => const DashboardScreen(),
          },
        ),
      ),
    );
  }
}
