import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project_app/ChildExamStartScreen.dart';
import 'package:graduation_project_app/ExamStartScreen.dart';
import 'package:graduation_project_app/ProfileScreen.dart';
import '/TestScreen.dart';
import '/NearestCentersScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project_app/GameScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

get userid => FirebaseAuth.instance.currentUser?.uid;

class MenuScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final AlertValue = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text("Do you want to Exit ?"),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No"),
                  ),
                  ElevatedButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text("Exit"),
                  )
                ],
              );
            });
        if (AlertValue != null) {
          return Future.value(AlertValue);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + 1.25,
          centerTitle: true,
          title: Text(
            "Autism'Mate",
          ),

          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.account_circle),
              onPressed: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                Get.to(() => ProfileScreen(),
                    transition: Transition.upToDown,
                    duration: Duration(milliseconds: 500));
              },
            ),

          ],
        ),
        body: Column(children: [
          ClipPath(
            clipper: BezierClipper1(),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.09, 1],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xFF09203F), Color(0xFF537895)])),
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.to(() => TestScreen(),
                          transition: Transition.upToDown,
                          duration: Duration(milliseconds: 500));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => GameScreen(),
                      //   ),
                      // );
                    },
                    child: Align(
                      alignment: AlignmentDirectional(0, 2),
                      child: Container(
                          width: 200,
                          height: 200,
                          child: Align(
                            //alignment: Alignment.bottomCenter,
                            child: Lottie.asset(
                              'assets/Animations/shooting-photo-animation-5.json',
                              width: 120,
                              height: 120,
                              //fit: BoxFit.fill,
                            ),
                          )),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Try The Children Facial Detection',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        (SizedBox(height: 50)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => NearestCentersScreen(),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 500));

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => NearestCentersScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie.asset(
                            //   'assets/Animations/form-application-3.json',
                            //   width: 100,
                            //   height: 100,
                            //   fit: BoxFit.fill,
                            // ),
                            Lottie.asset(
                              'assets/Animations/help-center-1.json',
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              animate: false,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'MainMenu_Help_Centers'.tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                stops: [0.09, 1],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xFF09203F), Color(0xFF537895)]),
                            // gradient: LinearGradient(
                            //     stops: [0.35, 1],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Color(0xFF2196F3), Color(0xFF2147A1)]),
                            // gradient: LinearGradient(
                            //     stops: [0, 1],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Color(0xFF1B2359), Color(0xFF78C1CB)]),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            //color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 2,
                              //color:
                              //Theme.of(context).colorScheme.background
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => GameScreen(),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 500));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => GameScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie.asset(
                            //   'assets/Animations/form-application-4.json',
                            //   width: 100,
                            //   height: 100,
                            //   fit: BoxFit.fill,
                            // ),
                            Image(
                              image: AssetImage(
                                  "assets/Game/Icon.png"),
                              height: 80.0,
                              width: 80.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'MainMenu_Game'.tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                stops: [0.09, 1],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xFF09203F), Color(0xFF537895)]),
                            //color: Colors.grey[400],
                            // gradient: LinearGradient(
                            //     stops: [0.35, 1],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Color(0xFF2196F3), Color(0xFF2147A1)]),
                            // gradient: LinearGradient(
                            //     stops: [0, 1],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Color(0xFF1B2359), Color(0xFF78C1CB)]),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            //color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 2,
                              // color:Theme.of(context).colorScheme.background
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ExamStartScreen(),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 500));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ExamStartScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie.asset(
                            //   'assets/Animations/form-application-3.json',
                            //   width: 100,
                            //   height: 100,
                            //   fit: BoxFit.fill,
                            // ),
                            Image(
                              image: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/3403/3403504.png'),
                              height: 80.0,
                              width: 80.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'MainMenu_Adults_Test'.tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            //color: Colors.grey[400],
                            gradient: LinearGradient(
                                stops: [0.09, 1],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xFF09203F), Color(0xFF537895)]),
                            // gradient: LinearGradient(
                            //     stops: [0.35, 1],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Color(0xFF2196F3), Color(0xFF2147A1)]),
                            // gradient: LinearGradient(
                            //     stops: [0, 1],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Color(0xFF1B2359), Color(0xFF78C1CB)]),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            //color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 2,
                              //color:
                              //Theme.of(context).colorScheme.background
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ChildExamStartScreen(),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 500));

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ChildExamStartScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie.asset(
                            //   'assets/Animations/form-application-4.json',
                            //   width: 100,
                            //   height: 100,
                            //   fit: BoxFit.fill,
                            // ),
                            Image(
                              image: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/2210/2210419.png'),
                              height: 80.0,
                              width: 80.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'MainMenu_Children_Test'.tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            // color: Colors.grey[400],
                            gradient: LinearGradient(
                                stops: [0.09, 1],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xFF09203F), Color(0xFF537895)]),
                            // gradient: LinearGradient(
                            //     stops: [0.35, 1],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Color(0xFF2196F3), Color(0xFF2147A1)]),
                            // gradient: LinearGradient(
                            //     stops: [0, 1],
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [Color(0xFF1B2359), Color(0xFF78C1CB)]),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            //color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 2,
                              // color:Theme.of(context).colorScheme.background
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class BezierClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var heightOffset = height * 0.2;
    Path path = Path();
    path.lineTo(
      0, // x value
      height - heightOffset, // y value
    );
    path.quadraticBezierTo(
      width * 0.5, // x1 of P1
      height, // y1 of P1
      width, // x2 of P2
      height - heightOffset, // y2 of P2
    );
    path.lineTo(
      width, // x value
      0, // y value
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
