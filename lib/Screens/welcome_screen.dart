import 'dart:math';

import 'package:cooler/Screens/settings_screen.dart';
import 'package:cooler/Screens/wallet_screens/wallet_home_screen.dart';
import 'package:flutter/material.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/user_model.dart';
import '../Repositories/user_repository.dart';
import 'group_screens/my_group_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // @override
  final int _selectedIndex = 0;
  final List<Widget> _pages = [
    const WelcomeScreen(),
    const MyGroupsScreen(),
    const WalletHomeScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    super.initState();
  }

  AppUser? currentUser;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.bottom);
    return SafeArea(
      child: currentUser == null
          ? const Center(
              child: CircularProgressIndicator(
              color: kBlueColor,
            ))
          : Scaffold(
              backgroundColor: background,
              // drawer: const CustomNavigationDrawer(
              //   pageIndex: 1,
              // ),
              // drawer: const Drawer(),
              // bottomNavigationBar: buildBottomNavigationBar(_selectedIndex),
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                iconTheme: const IconThemeData(color: kMainColor),
                backgroundColor: background,
                centerTitle: false,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.menu),
                    horizontalSpacer(15),
                    Text(
                      'Welcome ${(currentUser!.firstName)}  👋',
                      style: const TextStyle(
                          fontSize: 21,
                          color: kMainColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(currentUser!.imageUrl),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  // height: screenHeight,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      verticalSpacer(20),
                      SizedBox(
                        height: screenHeight * 0.35,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgress(
                            filledFraction: 0.7,
                            currentUser: currentUser,
                          ),
                        ),
                      ),
                      verticalSpacer(20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Wallet",
                            style: TextStyle(
                                color: blueText,
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                          ),
                        ),
                      ),
                      verticalSpacer(20),
                      Container(
                        child: Container(
                          width: double.infinity,
                          color: blueBackground.withOpacity(0.09),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: background,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Recent",
                                          style: TextStyle(
                                              color: blueText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        const Text(
                                          "VIEW ALL",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    verticalSpacer(20),
                                    RecentContainer(
                                      circleColor: kBlueColor.withOpacity(0.3),
                                      circleIcon: Icons.trending_up,
                                      circleIconColor: kBlueColor,
                                      title: "Bank Transfer",
                                      subTitle: "0.5% Charged",
                                      rTitle: "\$30,000",
                                      rSubTitle: "3 days ago",
                                    ),
                                    verticalSpacer(25),
                                    RecentContainer(
                                      circleColor:
                                          kLemonColor.withOpacity(0.24),
                                      circleIcon: Icons.add,
                                      circleIconColor: kLemonColor,
                                      title: "Plan Transfer",
                                      subTitle: "Free",
                                      rTitle: "\$1,245,000",
                                      rSubTitle: "3 days ago",
                                    ),
                                    verticalSpacer(25),
                                    RecentContainer(
                                      circleColor:
                                          kLemonColor.withOpacity(0.24),
                                      circleIcon: Icons.add,
                                      isImage: true,
                                      imageUrl: currentUser!.imageUrl,
                                      circleIconColor: kLemonColor,
                                      title: "Transfer To Eniola",
                                      subTitle: "Free",
                                      rTitle: "\$1,245,000",
                                      rSubTitle: "3 days ago",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}

class RecentContainer extends StatelessWidget {
  final Color? circleColor;
  final IconData? circleIcon;
  final Color? circleIconColor;
  final String title;
  final String subTitle;
  final String rTitle;
  final String rSubTitle;
  final String? imageUrl;
  final bool isImage;
  const RecentContainer({
    super.key,
    this.circleColor,
    this.circleIcon,
    this.circleIconColor,
    required this.title,
    required this.subTitle,
    required this.rTitle,
    required this.rSubTitle,
    this.imageUrl,
    this.isImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            isImage
                ? CircleAvatar(
                    radius: 45 / 2,
                    backgroundImage: NetworkImage(imageUrl!),
                  )
                : Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: circleColor),
                    child: Center(
                      child: Icon(
                        circleIcon,
                        color: circleIconColor,
                      ),
                    ),
                  ),
            horizontalSpacer(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: blueText,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                verticalSpacer(5),
                Text(
                  subTitle,
                  style: TextStyle(color: greyText, fontSize: 12),
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              rTitle,
              style: TextStyle(
                  color: blueText, fontWeight: FontWeight.w600, fontSize: 14),
            ),
            verticalSpacer(5),
            Text(
              rSubTitle,
              style: TextStyle(color: greyText, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}

class SmallTextLetterBox extends StatelessWidget {
  const SmallTextLetterBox({
    required this.isactive,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final IconData? icon;
  final bool isactive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: isactive ? kMainColor : white,
          border: Border.all(color: kMainColor)),
      child: Center(
          child: Icon(
        icon,
        color: isactive ? white : kMainColor,
      )),
    );
  }
}

class CircularProgress extends StatelessWidget {
  final double filledFraction;
  final AppUser? currentUser;

  const CircularProgress(
      {super.key, required this.filledFraction, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        children: [
          CustomPaint(
            painter: BackgroundCirclePainter(),
            child: Container(),
          ),
          // Circular progress indicator
          CustomPaint(
            painter: HalfCirclePainter(filledFraction: filledFraction),
            child: Container(),
          ),
          // White container in the middle
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ACCRUED',
                    style: TextStyle(
                      fontSize: 18,
                      color: kMainColor,
                    ),
                  ),
                  verticalSpacer(5),
                  Text(
                    '\$${currentUser!.amountAccrued}',
                    style: const TextStyle(
                        fontSize: 30,
                        color: kMainColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  final double filledFraction;

  HalfCirclePainter({required this.filledFraction});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    final Paint paint = Paint();

    // Gradient colors
    final colors = [const Color(0xFF130B74), const Color(0xFF42ADE2)];

    // Gradient Shader
    final gradient = LinearGradient(
        // center: Alignment(centerX, centerY),
        colors: colors,
        stops: const [0.4, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);

    paint.shader = gradient.createShader(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
    );

    // Draw portion of the circle based on filledFraction (anti-clockwise)
    double startAngle = 1.5 * pi;
    double sweepAngle = -2 * pi * filledFraction;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      true,
      paint,
    );

    // double sweepAngle1 = -2 * pi * filledFraction;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BackgroundCirclePainter extends CustomPainter {
  BackgroundCirclePainter();

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    final Paint paint = Paint();

    // Grey color for the whole circle
    Color greyColor = lightgreyBg;

    paint.color = greyColor;

    // Draw the whole circle with grey color
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      0,
      2 * pi,
      true,
      paint,
    );

    // double sweepAngle1 = -2 * pi * filledFraction;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
