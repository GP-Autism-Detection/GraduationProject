import 'package:flutter/material.dart';
import 'package:graduation_project_app/QuizScreen.dart';

class ChildExamStartScreen extends StatefulWidget {
  const ChildExamStartScreen({Key? key}) : super(key: key);

  @override
  State<ChildExamStartScreen> createState() => _ChildExamStartScreen();
}

class _ChildExamStartScreen extends State<ChildExamStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Children Autism Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "27 questions",
                style: TextStyle(fontSize: 15),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "This test can help you determine if your child or student is experiencing symptoms of Autism Spectrum Disorder.",
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
                  "Select how the child stands out as different from other children of his/her age.",
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
                      EdgeInsets.symmetric(vertical: 15, horizontal: 120),
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
