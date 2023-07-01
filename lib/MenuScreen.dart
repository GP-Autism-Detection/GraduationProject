import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                    onPressed: () => Navigator.of(context).pop(true),
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
          centerTitle: true,
          title: Text(
            'MainMenu_Menu'.tr(),
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
                    transition: Transition.zoom,
                    duration: Duration(milliseconds: 500));
              },
            ),
          ],
        ),
        body: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => TestScreen(),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 500));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => TestScreen(),
                        //   ),
                        // );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie.asset(
                            //   'assets/Animations/shooting-photo-animation.json',
                            //   width: 120,
                            //   height: 100,
                            //   fit: BoxFit.fill,
                            // ),
                            Image(
                              image: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/4243/4243421.png'),
                              height: 80.0,
                              width: 80.0,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'MainMenu_Image_Test'.tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
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
                            // gradient: LinearGradient(
                            //   colors: [Color(0xf7df1b0c), Color(0xfc00bcd4)],
                            //   stops: [0, 1],
                            //   begin: Alignment.bottomCenter,
                            //   end: Alignment.topCenter,
                            // ),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            //color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(
                              color: Colors.grey[600]!,
                              width: 2,
                              //color: Theme.of(context).colorScheme.background
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
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
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
                              color: Colors.grey[600]!,
                              width: 2,
                              //color:
                              //Theme.of(context).colorScheme.background
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie.asset(
                            //   'assets/Animations/face-scan-2-boy.json',
                            //   width: 100,
                            //   height: 100,
                            //   fit: BoxFit.fill,
                            // ),
                            Image(
                              image: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/9136/9136551.png'),
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
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image(
                  //           image: NetworkImage(
                  //               'https://cdn-icons-png.flaticon.com/512/9136/9136551.png'),
                  //           height: 80.0,
                  //           width: 80.0,
                  //           fit: BoxFit.cover,
                  //         ),
                  //         SizedBox(
                  //           height: 15.0,
                  //         ),
                  //         Text(
                  //           'Game',
                  //           style: TextStyle(
                  //             fontSize: 20.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(
                  //         10.0,
                  //       ),
                  //       color: Theme.of(context).colorScheme.secondary,
                  //     ),
                  //   ),
                  // ),
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
                        Get.to(() => NearestCentersScreen(),
                            transition: Transition.zoom,
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
                            Lottie.asset(
                              'assets/Animations/help-center-1.json',
                              width: 120,
                              height: 120,
                              fit: BoxFit.fill,
                              animate: false,
                            ),
                            // Image(
                            //   image: NetworkImage(
                            //       'https://cdn-icons-png.flaticon.com/512/4243/4243416.png'),
                            //   height: 80.0,
                            //   width: 80.0,
                            //   fit: BoxFit.cover,
                            // ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'MainMenu_Help_Centers'.tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
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
                              color: Colors.grey[600]!,
                              width: 2,
                              //color:
                              //Theme.of(context).colorScheme.background
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
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
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
                              color: Colors.grey[600]!,
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
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
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
                              color: Colors.grey[600]!,
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
