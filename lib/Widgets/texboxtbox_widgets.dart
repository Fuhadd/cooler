import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Helpers/colors.dart';
import '../Helpers/constants.dart';

class SmallTextBox extends StatelessWidget {
  const SmallTextBox({
    required this.lagging,
    required this.leading,
    Key? key,
  }) : super(key: key);
  final String leading;
  final String lagging;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
      ),
    );
  }
}

class SmallSingleRightTextBox extends StatelessWidget {
  const SmallSingleRightTextBox({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 19, color: kMainColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class SmallSingleLeftTextBox extends StatelessWidget {
  const SmallSingleLeftTextBox({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
                color: kShadowColor),
          ],
          border: Border.all(color: kShadowColor, width: 0.8)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: kMainColor),
          ),
        ),
      ),
    );
  }
}

class SmallDoubleTextBox extends StatelessWidget {
  const SmallDoubleTextBox({
    required this.title,
    required this.mail,
    Key? key,
  }) : super(key: key);

  final String title;
  final String mail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 4),
                color: kShadowColor),
          ],
          border: Border.all(color: kBoxBackground, width: 1.3)),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              mail,
              style: const TextStyle(fontSize: 17, color: kMainColor),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 19, color: kMainColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallRightAlignDoubleTextBox extends StatelessWidget {
  const SmallRightAlignDoubleTextBox({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text(
              //   mail,
              //   style:   TextStyle(fontSize: 17, color: kMainColor),
              // ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 19,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeDoubleTextBox extends StatelessWidget {
  const LargeDoubleTextBox({
    required this.text2,
    required this.text1,
    required this.icon,
    required this.iconColor,
    Key? key,
  }) : super(key: key);

  final String text2;
  final String text1;

  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 4),
                color: kShadowColor),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Row(
                children: [
                  const Text(
                    "~",
                    style: TextStyle(
                        fontSize: 17,
                        color: kMainColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text1,
                    style: const TextStyle(
                        fontSize: 17,
                        color: kMainColor,
                        fontWeight: FontWeight.bold),
                  ),
                  horizontalSpacer(10),
                  Text(
                    text2,
                    style: const TextStyle(
                      fontSize: 16,
                      color: kMainColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeStraightDoubleTextBox extends StatelessWidget {
  const LargeStraightDoubleTextBox({
    required this.text2,
    required this.text1,
    Key? key,
  }) : super(key: key);

  final String text2;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                    fontSize: 17,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
              horizontalSpacer(35),
              Container(
                child: Text(
                  text2,
                  style: const TextStyle(
                      fontSize: 19,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentDoubleTextBox extends StatelessWidget {
  const PaymentDoubleTextBox({
    required this.imageUrl,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 4),
                color: kShadowColor),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imageUrl), fit: BoxFit.cover),
                ),
              ),
              horizontalSpacer(30),
              Container(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentBoxDoubleTextBox extends StatelessWidget {
  const PaymentBoxDoubleTextBox({
    required this.imageUrl,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imageUrl), fit: BoxFit.cover),
                ),
              ),
              horizontalSpacer(30),
              Container(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeTextBox extends StatelessWidget {
  const LargeTextBox({
    required this.lagging,
    required this.leading,
    Key? key,
  }) : super(key: key);
  final String leading;
  final String lagging;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 85,
        width: double.infinity,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                leading,
                style: const TextStyle(fontSize: 19, color: kMainColor),
              ),
              Center(
                child: Text(
                  lagging,
                  style: const TextStyle(
                      fontSize: 30,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SmallIconTextBox extends StatelessWidget {
  const SmallIconTextBox({
    required this.lagging,
    required this.leading,
    Key? key,
  }) : super(key: key);
  final String leading;
  final String lagging;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
      ),
    );
  }
}

class ColouredTextBox extends StatelessWidget {
  const ColouredTextBox({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 5,
      child: Container(
        height: 60,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: kBlueColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
                color: kShadowColor),
          ],
          // border: Border.all(color: kBoxBackground, width: 0.8)
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18, color: white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class ColouredOutlineTextBox extends StatelessWidget {
  const ColouredOutlineTextBox({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 5,
      child: Container(
        height: 60,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kBlueColor),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
                color: kShadowColor),
          ],
          // border: Border.all(color: kBoxBackground, width: 0.8)
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, color: kBlueColor, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class ColouredSettingsTextBox extends StatelessWidget {
  const ColouredSettingsTextBox({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kBlueColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
                color: kShadowColor),
          ],
          // border: Border.all(color: kBoxBackground, width: 0.8)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// class ColouredLoadingBox extends StatelessWidget {
//     ColouredLoadingBox({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       child: Container(
//         height: 50,
//         // width: double.infinity,
//         decoration: BoxDecoration(
//             color: kMainColor,
//             borderRadius: BorderRadius.circular(5),
//             boxShadow: [
//               BoxShadow(
//                   spreadRadius: 1,
//                   blurRadius: 1,
//                   offset:   Offset(0, 1),
//                   color: Colors.grey.withOpacity(0.5)),
//             ],
//             border: Border.all(color: Colors.grey.shade300, width: 0.8)),
//         child:   Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
// }

class LargeColouredTextBox extends StatelessWidget {
  const LargeColouredTextBox({
    required this.title,
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 85,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: kBlueColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
                color: kShadowColor),
          ],
          // border: Border.all(color: kBoxBackground, width: 0.8)
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 22, color: kMainColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ColouredLoadingBox extends StatelessWidget {
  const ColouredLoadingBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 50,
        // width: double.infinity,
        decoration: BoxDecoration(
            color: kBlueColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class GeneralLargeTextBox extends StatelessWidget {
  const GeneralLargeTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.isUrlImage = false,
    this.subTitle,
    this.imageUrl,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final bool isUrlImage;
  final String? subTitle;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isImage
                  ? isUrlImage
                      ? Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              // stops: const [1.0, 0.8444, 0.625, 0.57],
                              colors: [
                                const Color(0xFF348AED),
                                const Color(0xFF4772E2).withOpacity(0.84),
                                const Color(0xFF4E85E2).withOpacity(0.63),
                                const Color(0xFF6242E2).withOpacity(0.57),
                              ],
                            ),
                            // image: DecorationImage(
                            //     image: NetworkImage(
                            //       imageUrl!,
                            //     ),
                            //     fit: BoxFit.cover),
                          ),
                        )
                      : Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              // stops: const [1.0, 0.8444, 0.625, 0.57],
                              colors: [
                                const Color(0xFF348AED),
                                const Color(0xFF4772E2).withOpacity(0.84),
                                const Color(0xFF4E85E2).withOpacity(0.63),
                                const Color(0xFF6242E2).withOpacity(0.57),
                              ],
                            ),
                            // image: DecorationImage(
                            //     image: AssetImage(
                            //       imageUrl!,
                            //     ),
                            //     fit: BoxFit.cover),
                          ),
                        )
                  : isIcon
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            FontAwesomeIcons.userGroup,
                            size: 30,
                            color: kMainColor,
                          ),
                        )
                      : const Text(
                          'leading',
                          style: TextStyle(fontSize: 15, color: kMainColor),
                        ),
              horizontalSpacer(35),
              isSub
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 18,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          subTitle ?? '',
                          style:
                              const TextStyle(fontSize: 12, color: kMainColor),
                        ),
                      ],
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                        fontSize: 19,
                        color: kMainColor,
                      ),
                    ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralLargeBorderTextBox extends StatelessWidget {
  const GeneralLargeBorderTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.isUrlImage = false,
    this.subTitle,
    this.imageUrl,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final bool isUrlImage;
  final String? subTitle;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isImage
                  ? isUrlImage
                      ? Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  imageUrl!,
                                ),
                                fit: BoxFit.cover),
                          ),
                        )
                      : Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  imageUrl!,
                                ),
                                fit: BoxFit.cover),
                          ),
                        )
                  : isIcon
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            FontAwesomeIcons.userGroup,
                            size: 30,
                            color: kMainColor,
                          ),
                        )
                      : const Text(
                          'leading',
                          style: TextStyle(fontSize: 15, color: kMainColor),
                        ),
              horizontalSpacer(35),
              isSub
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 18,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          subTitle ?? '',
                          style:
                              const TextStyle(fontSize: 12, color: kMainColor),
                        ),
                      ],
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                        fontSize: 19,
                        color: kMainColor,
                      ),
                    ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralBorderLargeTextBox extends StatelessWidget {
  const GeneralBorderLargeTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.isUrlImage = false,
    this.subTitle,
    this.imageUrl,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final bool isUrlImage;
  final String? subTitle;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isImage
                  ? isUrlImage
                      ? Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  imageUrl!,
                                ),
                                fit: BoxFit.cover),
                          ),
                        )
                      : Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  imageUrl!,
                                ),
                                fit: BoxFit.cover),
                          ),
                        )
                  : isIcon
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            FontAwesomeIcons.userGroup,
                            size: 30,
                            color: kMainColor,
                          ),
                        )
                      : const Text(
                          'leading',
                          style: TextStyle(fontSize: 15, color: kMainColor),
                        ),
              horizontalSpacer(35),
              isSub
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 18,
                              color: kMainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          subTitle ?? '',
                          style:
                              const TextStyle(fontSize: 12, color: kMainColor),
                        ),
                      ],
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                        fontSize: 19,
                        color: kMainColor,
                      ),
                    ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralLargeInviteTextBox extends StatelessWidget {
  const GeneralLargeInviteTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.subTitle,
    this.imageUrl,
    this.onTap,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final String? subTitle;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        // height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isImage
                  ? Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              imageUrl!,
                            ),
                            fit: BoxFit.cover),
                      ),
                    )
                  : isIcon
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            FontAwesomeIcons.userGroup,
                            size: 30,
                            color: kMainColor,
                          ),
                        )
                      : const Text(
                          'leading',
                          style: TextStyle(fontSize: 15, color: kMainColor),
                        ),
              horizontalSpacer(35),
              isSub
                  ? Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpacer(10),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18,
                                color: kMainColor,
                                fontWeight: FontWeight.bold),
                          ),
                          verticalSpacer(10),
                          Text(
                            subTitle ?? '',
                            style: const TextStyle(
                                fontSize: 12, color: kMainColor),
                          ),
                          verticalSpacer(10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: onTap,
                              child: Card(
                                elevation: 10,
                                child: Container(
                                  // height: 20,
                                  // width: double.infinity,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: kMainColor,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0, 1),
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ],
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 0.8)),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Center(
                                      child: Text(
                                        'Invite',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpacer(10),
                        ],
                      ),
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                        fontSize: 19,
                        color: kMainColor,
                      ),
                    ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralLargeLoadingTextBox extends StatelessWidget {
  const GeneralLargeLoadingTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.subTitle,
    this.imageUrl,
    this.onTap,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final String? subTitle;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        // height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isImage
                  ? Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              imageUrl!,
                            ),
                            fit: BoxFit.cover),
                      ),
                    )
                  : isIcon
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            FontAwesomeIcons.userGroup,
                            size: 30,
                            color: kMainColor,
                          ),
                        )
                      : const Text(
                          'leading',
                          style: TextStyle(fontSize: 15, color: kMainColor),
                        ),
              horizontalSpacer(35),
              isSub
                  ? Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpacer(10),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18,
                                color: kMainColor,
                                fontWeight: FontWeight.bold),
                          ),
                          verticalSpacer(10),
                          Text(
                            subTitle ?? '',
                            style: const TextStyle(
                                fontSize: 12, color: kMainColor),
                          ),
                          verticalSpacer(10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: onTap,
                              child: Card(
                                elevation: 10,
                                child: Container(
                                  // height: 20,
                                  // width: double.infinity,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: kMainColor,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0, 1),
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ],
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 0.8)),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpacer(10),
                        ],
                      ),
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                        fontSize: 19,
                        color: kMainColor,
                      ),
                    ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralRequestTextBox extends StatelessWidget {
  const GeneralRequestTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.subTitle,
    this.imageUrl,
    this.onTap,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final String? subTitle;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 85,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        imageUrl!,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              horizontalSpacer(35),
              Flexible(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    verticalSpacer(10),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 18,
                          color: kMainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    verticalSpacer(5),
                    Text(
                      'You have been invited to join $name savings group',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralRequestBorderTextBox extends StatelessWidget {
  const GeneralRequestBorderTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.subTitle,
    this.imageUrl,
    this.onTap,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final String? subTitle;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 85,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        imageUrl!,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              horizontalSpacer(35),
              Flexible(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    verticalSpacer(10),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 18,
                          color: kMainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    verticalSpacer(5),
                    Text(
                      'You have been invited to join $name savings group',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralLargeGreyInviteTextBox extends StatelessWidget {
  const GeneralLargeGreyInviteTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.subTitle,
    this.imageUrl,
    this.onTap,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final String? subTitle;
  final String? imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        // height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isImage
                  ? Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              imageUrl!,
                            ),
                            fit: BoxFit.cover),
                      ),
                    )
                  : isIcon
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            FontAwesomeIcons.userGroup,
                            size: 30,
                            color: kMainColor,
                          ),
                        )
                      : const Text(
                          'leading',
                          style: TextStyle(fontSize: 15, color: kMainColor),
                        ),
              horizontalSpacer(35),
              isSub
                  ? Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpacer(10),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18,
                                color: kMainColor,
                                fontWeight: FontWeight.bold),
                          ),
                          verticalSpacer(10),
                          Text(
                            subTitle ?? '',
                            style: const TextStyle(
                                fontSize: 12, color: kMainColor),
                          ),
                          verticalSpacer(10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: onTap,
                              child: Card(
                                elevation: 10,
                                child: Container(
                                  // height: 20,
                                  // width: double.infinity,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0, 1),
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ],
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 0.8)),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Center(
                                      child: Text(
                                        'Invited',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpacer(10),
                        ],
                      ),
                    )
                  : Text(
                      name,
                      style: const TextStyle(
                        fontSize: 19,
                        color: kMainColor,
                      ),
                    ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class GeneralTimeLargeTextBox extends StatelessWidget {
  const GeneralTimeLargeTextBox({
    this.isIcon = false,
    this.isImage = false,
    this.isSub = false,
    this.isUrlImage = false,
    this.subTitle,
    this.imageUrl,
    this.time,
    required this.name,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isIcon;
  final bool isImage;
  final bool isSub;
  final bool isUrlImage;
  final String? subTitle;
  final String? time;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isImage
                  ? isUrlImage
                      ? Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  imageUrl!,
                                ),
                                fit: BoxFit.cover),
                          ),
                        )
                      : Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  imageUrl!,
                                ),
                                fit: BoxFit.cover),
                          ),
                        )
                  : isIcon
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            FontAwesomeIcons.userGroup,
                            size: 30,
                            color: kMainColor,
                          ),
                        )
                      : const Text(
                          'leading',
                          style: TextStyle(fontSize: 15, color: kMainColor),
                        ),
              horizontalSpacer(35),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 19,
                  color: kMainColor,
                ),
              ),
              horizontalSpacer(20),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      FontAwesomeIcons.clock,
                      size: 14,
                      color: Colors.grey,
                    ),
                    horizontalSpacer(5),
                    Text(
                      time!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnLargeTextBox extends StatelessWidget {
  const ColumnLargeTextBox({
    required this.text1,
    required this.text2,
    Key? key,
  }) : super(key: key);

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text1,
                style: const TextStyle(
                    fontSize: 15,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpacer(10),
              Text(
                text2,
                style: const TextStyle(
                    fontSize: 23,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnTextBox extends StatelessWidget {
  const ColumnTextBox({
    required this.text1,
    required this.text2,
    Key? key,
  }) : super(key: key);

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        verticalSpacer(30),
        Text(
          text1,
          style: const TextStyle(
              fontSize: 16, color: kMainColor, fontWeight: FontWeight.bold),
        ),
        verticalSpacer(20),
        Container(
          // height: 100,
          // width: double.infinity,
          width: 200,
          decoration: BoxDecoration(
            // color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            // boxShadow: [
            //   BoxShadow(
            //       spreadRadius: 1,
            //       blurRadius: 1,
            //       offset: const Offset(0, 1),
            //       color: kShadowColor),
            // ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text2,
                  style: const TextStyle(
                      fontSize: 40,
                      color: kMainColor,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
        verticalSpacer(30),
      ],
    );
  }
}

class ColumnLoanLargeTextBox extends StatelessWidget {
  const ColumnLoanLargeTextBox({
    required this.text1,
    required this.text2,
    required this.text3,
    Key? key,
  }) : super(key: key);

  final String text1;
  final String text2;
  final String text3;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text1,
                style: const TextStyle(
                    fontSize: 15,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
              horizontalSpacer(20),
              Text(
                text2,
                style: const TextStyle(
                    fontSize: 23,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
              horizontalSpacer(20),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  text3,
                  style: const TextStyle(
                      fontSize: 13,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnVeryLargeTextBox extends StatelessWidget {
  const ColumnVeryLargeTextBox({
    required this.text1,
    required this.text2,
    Key? key,
  }) : super(key: key);

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  color: kShadowColor),
            ],
            border: Border.all(color: kBoxBackground, width: 0.8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text1,
                style: const TextStyle(
                    fontSize: 15,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
              horizontalSpacer(20),
              Text(
                text2,
                style: const TextStyle(
                    fontSize: 23,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
