import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/QuizScreen.dart';
import 'package:get/get.dart' hide Trans;
import 'MenuScreen.dart';

class ExamStartScreen extends StatefulWidget {
  const ExamStartScreen({Key? key}) : super(key: key);

  @override
  State<ExamStartScreen> createState() => _ExamStartScreenState();
}

class _ExamStartScreenState extends State<ExamStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Exam_Start_Screen_appbar".tr()),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => MenuScreen(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MenuScreen()),
              // );
            },
            icon: const Icon(Icons.home),
            iconSize: 40,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  alignment: Alignment(0, 0),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 700,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Exam_Start_Screen_nQuestions'.tr(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text(
                            "Exam_Start_Screen_T1".tr(),
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: FilledButton(
                                      onPressed: () {
                                        Get.to(() => QuizScreen(),
                                            transition: Transition.leftToRight,
                                            duration:
                                                Duration(milliseconds: 500));
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) => QuizScreen()),
                                        // );
                                      },
                                      // padding: EdgeInsetsDirectional.symmetric(
                                      //     vertical: 5, horizontal: 100),
                                      //color: Colors.blue,
                                      // shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.all(
                                      //         Radius.circular(30))),
                                      child: Text(
                                        "Exam_Start_Screen_T2".tr(),
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
