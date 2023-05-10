import 'package:flutter/material.dart';
import 'package:graduation_project_app/QuizScreen.dart';

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
        title: Text("Adult Autism Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "14 questions",
                style: TextStyle(fontSize: 15),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "This test can help you determine if you are experiencing symptoms of Autism Spectrum Disorder.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "This is not a diagnostic test. Please consult a physician if you are concerned about autism spectrum disorder.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 200.0),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Answer the question according to what is true for you.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "If you can not determine a specific answer you can skip the question and its weight won't be considered in the final result",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(40),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizScreen()),
                        );
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
