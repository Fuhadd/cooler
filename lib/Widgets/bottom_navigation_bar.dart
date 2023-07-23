import 'package:cooler/Helpers/colors.dart';
import 'package:cooler/Screens/wallet_screens/wallet_home_screen.dart';
import 'package:cooler/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../Screens/group_screens/my_group_screen.dart';
import '../Screens/settings_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = "dashboardScreen";
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final userData = locator<LocalCache>().getUserData();
    final menuIndex = ref.watch(indexProvider);
    final List<Widget> pages = [
      const WelcomeScreen(),
      const MyGroupsScreen(),
      const WalletHomeScreen(),
      const SettingsScreen(),
    ];
    return Scaffold(
      // onWillPop: () async {
      //   false;
      // },
      backgroundColor: background,
      // appBar: AppBar(
      //     centerTitle: false,
      //     automaticallyImplyLeading: false,
      //     backgroundColor: CustomColors.scaffoldBackgroundColor,
      //     // leading: IconButton(
      //     //   icon: Icon(Icons.schedule_rounded,
      //     //       color: CustomColors.blackColor, size: ScreenUtil().setSp(30)),
      //     //   onPressed: () {},
      //     // ),
      //     actions: [
      //       menuIndex == 1
      //           ? ProductIconButtonWidget(
      //               filter: ProductType.savings.name,
      //               activePage: SavingsProductType.regular.index,
      //             )
      //           : menuIndex == 2
      //               ? ProductIconButtonWidget(
      //                   filter: ProductType.investments.name,
      //                   activePage: 1
      //                 )
      //               : IconButton(
      //                   icon: Icon(Icons.account_circle_outlined,
      //                       color: CustomColors.blackColor,
      //                       size: ScreenUtil().setSp(30)),
      //                   onPressed: () {
      //                     Navigator.push(context,
      //                         MaterialPageRoute(builder: (context) {
      //                       return const ProfileView();
      //                     }));
      //                   },
      //                 ),
      //     ],
      //     title: Text(
      //       menuIndex == 0
      //           ? "Welcome, ${userData.firstname}"
      //           : menuIndex == 1
      //               ? "Savings"
      //               : menuIndex == 2
      //                   ? "Investments"
      //                   : menuIndex == 3
      //                       ? "Wallet"
      //                       : "",
      //       style: TextStyle(
      //           fontSize: 18.sp,
      //           fontWeight: FontWeight.w500,
      //           color: CustomColors.blackColor),
      //     )),

      bottomNavigationBar: BottomNavigationBar(
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
      ),
      // builder: ((size) {
      //   return pages[menuIndex];
      // }),
      body: pages[menuIndex],
    );
  }
}

final indexProvider = StateProvider.autoDispose<int>((ref) => 0);

class UShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kBlueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path();

    // Calculate control points and endpoints of the U-curve
    final startPoint = Offset(0, size.height / 2); // Start from the left side
    final endPoint =
        Offset(size.width, size.height / 2); // End on the right side
    final controlPoint1 = Offset(size.width / 3,
        size.height * 2 / 3); // Adjust the y-coordinate of controlPoint1
    final controlPoint2 = Offset(size.width * 2 / 3,
        size.height * 2 / 3); // Adjust the y-coordinate of controlPoint2

    // Draw the U-curve using the calculated points
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    // Draw the curve on the canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
// class UShapePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0;

//     final Path path = Path()
//       ..quadraticBezierTo(
//         size.width / 2,
//         size.height *
//             0.5, // Control point for the curve (curve starts from the middle)
//         size.width * 2 / 3, 0, // End point of the curve
//       ); // Draw straight line to the top-right corner

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

class UCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kBlueColor // Set the color of the U-curve outline
      ..style = PaintingStyle.stroke // Set to stroke to draw only the outline
      ..strokeWidth = 4.0; // Set the thickness of the outline

    final path = Path();

    // Calculate control points and endpoints of the U-curve
    final startPoint = Offset(20, size.height - 20);
    final endPoint = Offset(size.width - 20, size.height - 20);
    final controlPoint1 = Offset(size.width / 3, size.height / 3);
    final controlPoint2 = Offset(size.width * 2 / 3, size.height / 3);

    // Draw the U-curve using the calculated points
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    // Draw the curve on the canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
